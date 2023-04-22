import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xscan/brand%20view/models/manufacturer.dart';
import 'package:xscan/brand%20view/providers/login_provider.dart';

class ManuProfile extends ConsumerWidget {
  const ManuProfile({super.key, required this.data});
  final Manufacturer data;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(children: [
      ElevatedButton(
          onPressed: () async {
            ref.watch(loginStateProvider.notifier).logout();
          },
          child: const Text("Sign out")),
      Text(data.name),
      Text(data.location),
      Text(data.notes),
    ]);
  }
}
