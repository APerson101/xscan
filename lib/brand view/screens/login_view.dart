import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../providers/login_provider.dart';

class LoginView extends ConsumerWidget {
  LoginView({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(loginMessage, (previous, next) {
      if (previous != next) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(next)));
      }
    });
    return ref.watch(_animationAssetLoader).when(data: (composition) {
      return SizedBox.expand(
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AbsorbPointer(
                absorbing: ref.watch(_isLoading),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ref.watch(_isLoading) == false
                          ? Image.asset(
                              'assets/images/logo.png',
                              width: 250,
                              height: 250,
                              fit: BoxFit.contain,
                            )
                          : Lottie(
                              composition: composition,
                              width: 250,
                              height: 250,
                              fit: BoxFit.contain,
                              animate: true,
                              repeat: true,
                            ),
                      TextFormField(
                          controller: emailController,
                          validator: (email) {
                            if (email != null) {
                              return EmailValidator.validate(email, true, true)
                                  ? null
                                  : 'Enter valid email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email),
                              labelText: 'Enter Email',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40)))),
                      const SizedBox(height: 25),
                      TextFormField(
                          validator: (password) {
                            if (password != null) {
                              return password.length >= 8
                                  ? null
                                  : 'Enter at least 8 characters';
                            }
                            return null;
                          },
                          controller: passwordController,
                          obscureText: ref.watch(_isPasswordObscure),
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.password),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                    onPressed: () => ref
                                        .watch(_isPasswordObscure.notifier)
                                        .state = !ref.watch(_isPasswordObscure),
                                    icon: const Icon(Icons.lock)),
                              ),
                              labelText: 'Enter password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40)))),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            ref.watch(_isLoading.notifier).state = true;
                            ref.watch(loginStateProvider.notifier).login(
                                emailController.text, passwordController.text);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            maximumSize: Size.infinite,
                            minimumSize: const Size(150, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        child: const Text("Login"),
                      )
                    ],
                  ),
                ),
              ),
            )),
          ),
        ),
      );
    }, error: (er, st) {
      return const Center(child: Text("Failed to laod assets"));
    }, loading: () {
      return Container();
    });
  }
}

final _isLoading = StateProvider.autoDispose((ref) => false);
final _isPasswordObscure = StateProvider.autoDispose((ref) => true);
final _animationAssetLoader = FutureProvider(
    (ref) async => AssetLottie('assets/animations/wave.json').load());
final loginMessage = StateProvider((ref) => '');
