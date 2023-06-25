import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xscan/brand%20view/models/manufacturer.dart';
import 'package:xscan/brand%20view/providers/login_provider.dart';

class ManuProfile extends ConsumerWidget {
  const ManuProfile({super.key, required this.data});
  final Manufacturer data;
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
            backgroundImage: NetworkImage(data.logoImage),
          ),
          Card(
              child: ListTile(
            title: Text(data.name),
            subtitle: const Text("Manufacturer name"),
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
                  title: Text(data.location))),
          Card(
            child: ListTile(
              subtitle: const Text("Registered Email"),
              title: Text(data.email),
              leading: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.email),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
