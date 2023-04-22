import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xscan/brand%20view/models/brand.dart';
import 'package:xscan/brand%20view/providers/login_provider.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key, required this.brand});
  final Brand brand;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const Text("Business Name"),
        const Text("Business Location"),
        const Text("RegisteredEmail"),
        const Text("Change Password"),
        ElevatedButton(
            onPressed: () {
              ref.watch(loginStateProvider.notifier).logout();
            },
            child: const Text("Log out"))
      ],
    );
  }
}
