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
    return Scaffold(
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            ref.watch(loginStateProvider.notifier).logout();
          },
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 60),
              backgroundColor: Colors.red),
          child: const Text("Log out"),
        )
      ],
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Your profile"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 70,
            backgroundImage: NetworkImage(brand.logoImage),
          ),
          Card(
              child: ListTile(
            title: Text(brand.name),
            subtitle: const Text("Brand name"),
            leading: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(Icons.person),
            ),
          )),
          Card(
              child: ListTile(
                  leading: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.location_history),
                  ),
                  subtitle: const Text("Business Location"),
                  title: Text(brand.location))),
          Card(
            child: ListTile(
              subtitle: const Text("Registered Email"),
              title: Text(brand.email),
              leading: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.email),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return AddSalesStaff(brand: brand);
                }));
              },
              child: const Text("Add Sales employee")),
        ],
      ),
    );
  }
}
