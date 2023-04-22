import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:xscan/manufacturer/models/employee.dart';
import 'package:xscan/worker/models/scanmodel.dart';

import '../../brand view/models/product.dart';
import '../providers/employee_provider.dart';

class ScannedBarcodeView extends ConsumerWidget {
  const ScannedBarcodeView(
      {super.key, required this.barcode, required this.employee});
  final String barcode;
  final Employee employee;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(employeeApproveCodeProvider, (pr, nx) {
      ref.watch(employeeApproveCodeProvider).when(
          data: (data) {
            if (data == EmployeeApproveCodeEnum.successful) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content:
                      Text("successfully added, pending approval from boss")));
              Navigator.of(context).pop();
            }
          },
          error: (er, st) {},
          loading: () {});
    });
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("scanned code is: $barcode"),
          ref.watch(getAllEmployeeProducts(employee.businessID)).when(
              data: (data) {
                return DropdownButton<Product>(
                    value: ref.watch(_selectedProduct) ?? data[0],
                    hint: const Text("Select product"),
                    items: data
                        .map((e) => DropdownMenuItem<Product>(
                              value: e,
                              child: Text(e.name),
                            ))
                        .toList(),
                    onChanged: (newt) {
                      if (newt != null) {
                        ref.watch(_selectedProduct.notifier).state = newt;
                      }
                    });
              },
              error: (er, st) => const Text("error"),
              loading: () => const CircularProgressIndicator.adaptive()),
          ElevatedButton(
              onPressed: () async {
                // save barcode
                var scanned = ScanModel()
                  ..barcode = barcode
                  ..brandName = 'brand name'
                  ..id = const Uuid().v4().toString()
                  ..productID = ref.watch(_selectedProduct)!.id
                  ..productName = ref.watch(_selectedProduct)!.name
                  ..timeAdded = DateTime.now()
                  ..scanner = employee;
                ref
                    .watch(employeeApproveCodeProvider.notifier)
                    .employeeScanItem(barcode, scanned);
              },
              child: const Text("Continue"))
        ],
      ),
    );
  }
}

final _selectedProduct = StateProvider<Product?>((ref) => null);
