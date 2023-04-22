import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xscan/brand%20view/providers/login_provider.dart';
import 'package:xscan/manufacturer/models/employee.dart';

class WorkerProfileView extends ConsumerWidget {
  const WorkerProfileView({super.key, required this.employee});
  final Employee employee;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text(employee.name),
        Text(employee.email),
        ElevatedButton(
            onPressed: () {
              ref.watch(loginStateProvider.notifier).logout();
            },
            child: const Text("Logout"))
      ],
    );
  }
}
