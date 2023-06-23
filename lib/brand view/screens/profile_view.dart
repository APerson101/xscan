import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xscan/brand%20view/models/brand.dart';
import 'package:xscan/brand%20view/providers/login_provider.dart';

import 'add_sales_staff.dart';

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
        ElevatedButton(
            onPressed: () async {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return AddSalesStaff(brand: brand);
              }));
            },
            child: const Text("Add employee")),
        Image.network(brand.logoImage),
        ElevatedButton(
            onPressed: () {
              ref.watch(loginStateProvider.notifier).logout();
            },
            child: const Text("Log out"))
      ],
    );
  }
}
