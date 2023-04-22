import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xscan/manufacturer/models/employee.dart';

import '../providers/employee_provider.dart';

class WorkerHistory extends ConsumerWidget {
  const WorkerHistory({super.key, required this.employee});
  final Employee employee;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getEmpHistoryProvider(employee.id)).when(data: (data) {
      return SingleChildScrollView(
        child: Column(
          children: data.map((e) {
            var status = ref.watch(getEmpScanStatus(e.barcode!)).when(
                data: (status) => status,
                error: (Object error, StackTrace stackTrace) {
                  return false;
                },
                loading: () {
                  return false;
                });
            return ListTile(
              title: Text(e.brandName!),
              subtitle: Text(e.barcode!),
              trailing: Text(
                  status == false ? 'status: pending' : 'status: approved'),
            );
          }).toList(),
        ),
      );
    }, error: (er, st) {
      return const Center(child: Text("ERROR"));
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    });
  }
}
