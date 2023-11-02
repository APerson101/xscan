import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:uuid/uuid.dart';
import 'package:xscan/brand%20view/models/manufacturer.dart';

import '../../brand_owner_view.dart';
import '../../customsview.dart';
import '../models/brand.dart';
import '../models/usermodel.dart';
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
        ref.watch(_isLoading.notifier).state = false;
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
                          ? Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                'assets/images/logo.png',
                                width: 250,
                                height: 250,
                                fit: BoxFit.contain,
                              ),
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
                                  borderRadius: BorderRadius.circular(15)))),
                      const SizedBox(height: 50),
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
                                padding: const EdgeInsets.all(3),
                                child: IconButton(
                                    onPressed: () => ref
                                        .watch(_isPasswordObscure.notifier)
                                        .state = !ref.watch(_isPasswordObscure),
                                    icon: const Icon(Icons.lock)),
                              ),
                              labelText: 'Enter password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)))),
                      const SizedBox(height: 50),
                      Row(
                        children: [
                          Expanded(child: Container()),
                          TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor:
                                            Colors.blueAccent.shade100,
                                        // margin: const EdgeInsets.all(8),
                                        padding: const EdgeInsets.all(8),
                                        content: ListTile(
                                          title: const Text(
                                              "Contact admin on discord: @another_User"),
                                          trailing: Lottie.asset(
                                            'assets/animations/sad.json',
                                            width: 75,
                                            height: 75,
                                            fit: BoxFit.contain,
                                            animate: true,
                                            repeat: true,
                                          ),
                                        )));
                              },
                              child: const Text("Forgot Credentials?"))
                        ],
                      ),
                      const SizedBox(height: 75),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            ref.watch(_isLoading.notifier).state = true;
                            if (emailController.text.contains("customs")) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const CustomsView()));
                            } else if (emailController.text.contains("brand")) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const BrandOwnerView()));
                            }
                            return;
                            ref.watch(loginStateProvider.notifier).login(
                                emailController.text, passwordController.text);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            maximumSize: Size.infinite,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: const Text("Login"),
                      ),
                      const SizedBox(height: 35),
                      Row(children: [
                        const Expanded(child: Divider()),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      SignUpPage(ctx: context)));
                            },
                            child: const Text("Sign up")),
                        const Expanded(child: Divider()),
                      ])
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

class SignUpPage extends ConsumerWidget {
  SignUpPage({super.key, required this.ctx});
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final BuildContext ctx;
  final FToast toast = FToast();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    toast.init(ctx);
    double padding = ref.watch(_selectedUserTypes) == UserTypes.user ? 10 : 3;
    ref.listen(signUpState, (previous, next) {
      if (previous != next) {
        switch (next) {
          case SignUpStates.creating:
            ref.watch(_shouldAbsord.notifier).state = true;
            toast.showToast(
                gravity: ToastGravity.TOP,
                toastDuration: const Duration(seconds: 3),
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Creating new account...."),
                    )));
          case SignUpStates.failure:
            ref.watch(_shouldAbsord.notifier).state = false;
            toast.showToast(
                gravity: ToastGravity.TOP,
                toastDuration: const Duration(seconds: 3),
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          "Failed to create, please check details and try again later"),
                    )));
          case SignUpStates.success:
            ref.watch(_shouldAbsord.notifier).state = true;
            Navigator.of(context).pop();
            toast.showToast(
                gravity: ToastGravity.TOP,
                toastDuration: const Duration(seconds: 3),
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Succesfully created account"),
                    )));
            ref.invalidate(loginStateProvider);
          default:
            ref.watch(_shouldAbsord.notifier).state = false;
        }
      }
    });
    return Scaffold(
      appBar:
          AppBar(centerTitle: true, title: const Text("Create new account")),
      body: AbsorbPointer(
        absorbing: ref.watch(_shouldAbsord),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(padding),
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          labelText: "Select user type",
                          suffixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      value: ref.watch(_selectedUserTypes),
                      items: UserTypes.values
                          .map((e) =>
                              DropdownMenuItem(value: e, child: Text(e.label)))
                          .toList(),
                      onChanged: (selected) {
                        if (selected != null) {
                          ref.watch(_selectedUserTypes.notifier).state =
                              selected;
                        }
                      }),
                ),
                Padding(
                  padding: EdgeInsets.all(padding),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        suffixIcon:
                            ref.watch(_selectedUserTypes) == UserTypes.user
                                ? const Icon(Icons.person)
                                : const Icon(Icons.business),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText:
                            ref.watch(_selectedUserTypes) == UserTypes.user
                                ? 'Enter your name'
                                : "Enter business name"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(padding),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: "Enter Email"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(padding),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'Enter Password'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(padding),
                  child: TextFormField(
                    controller: confirmPasswordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (psswrd) {
                      if (psswrd != null) {
                        if (psswrd == passwordController.text) {
                          return null;
                        } else {
                          return "password does not match";
                        }
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'Confirm Password'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(padding),
                  child: ref.watch(_selectedUserTypes) != UserTypes.user
                      ? TextFormField(
                          controller: descriptionController,
                          decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.abc),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              labelText: "Enter business description"),
                        )
                      : const Gap(0),
                ),
                Padding(
                  padding: EdgeInsets.all(padding),
                  child: ref.watch(_selectedUserTypes) != UserTypes.user
                      ? TextFormField(
                          controller: locationController,
                          decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.location_on_sharp),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              labelText: "Enter business location"),
                        )
                      : const Gap(0),
                ),
                Padding(
                  padding: EdgeInsets.all(padding),
                  child: ref.watch(_selectedUserTypes) != UserTypes.user
                      ? TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.location_on_sharp),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              labelText: "Enter business phone number"),
                        )
                      : const Gap(0),
                ),
                Padding(
                  padding: EdgeInsets.all(padding),
                  child: ref.watch(_selectedUserTypes) != UserTypes.user
                      ? TextFormField(
                          controller: phoneNumberController,
                          decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.phone),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              labelText: "Enter business phone number"),
                        )
                      : const Gap(0),
                ),
                Padding(
                  padding: EdgeInsets.all(padding),
                  child: ref.watch(_selectedUserTypes) != UserTypes.user
                      ? TextFormField(
                          controller: addressController,
                          decoration: InputDecoration(
                              suffixIcon:
                                  const Icon(Icons.quick_contacts_mail_sharp),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              labelText: "Enter business address"),
                        )
                      : const Gap(0),
                ),
                Padding(
                  padding: EdgeInsets.all(padding),
                  child: ref.watch(_businessLogo) == null
                      ? ElevatedButton(
                          onPressed: () async {
                            ref.watch(_businessLogo.notifier).state =
                                await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                          },
                          child: Text(
                              ref.watch(_selectedUserTypes) != UserTypes.user
                                  ? "Select logo"
                                  : "Select Profile pic"))
                      : Row(children: [
                          TextButton(
                              onPressed: () {
                                ref.watch(_businessLogo.notifier).state = null;
                              },
                              child: const Text('change')),
                          const SizedBox(width: 20),
                          CircleAvatar(
                            radius: 100,
                            backgroundImage:
                                FileImage(File(ref.watch(_businessLogo)!.path)),
                          )
                        ]),
                ),
                Padding(
                  padding: EdgeInsets.all(padding),
                  child: ElevatedButton(
                      onPressed: () async {
                        var model = switch (ref.watch(_selectedUserTypes)) {
                          UserTypes.business => Brand(
                              name: nameController.text,
                              id: const Uuid().v4(),
                              location: locationController.text,
                              created: DateTime.now(),
                              privateKey: 'privateKey',
                              phone: phoneNumberController.text,
                              address: addressController.text,
                              email: emailController.text,
                              logoImage: ref.watch(_businessLogo)!.path,
                              accountID: 'accountID',
                              catalog: [],
                              balance: 0),
                          UserTypes.manufacturer => Manufacturer(
                              name: nameController.text,
                              location: locationController.text,
                              notes: descriptionController.text,
                              logoImage: ref.watch(_businessLogo)!.path,
                              id: const Uuid().v4(),
                              privateKey: 'privateKey',
                              email: emailController.text,
                              phone: phoneController.text,
                              accountID: 'accountID',
                              productions: []),
                          UserTypes.user => UserModel(
                              name: nameController.text,
                              privateKey: 'privateKey',
                              accountID: 'accountID',
                              email: emailController.text,
                              id: const Uuid().v4(),
                              created: DateTime.now(),
                              profilePic: ref.watch(_businessLogo)!.path,
                            ),
                          _ => Container()
                        };
                        ref.watch(loginStateProvider.notifier).createAccount(
                            emailController.text,
                            passwordController.text,
                            model,
                            ref.read(_selectedUserTypes));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          minimumSize: const Size(double.infinity, 60)),
                      child: const Text("Continue")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum UserTypes {
  user(label: 'user'),
  business(label: 'brand'),
  manufacturer(label: "manufacturer");

  const UserTypes({required this.label});
  final String label;
}

final _selectedUserTypes = StateProvider.autoDispose((ref) => UserTypes.user);
final _businessLogo = StateProvider.autoDispose<XFile?>((ref) => null);
final signUpState = StateProvider.autoDispose((ref) => SignUpStates.idle);
final _shouldAbsord = StateProvider.autoDispose((ref) => false);

enum SignUpStates { idle, success, failure, creating }
