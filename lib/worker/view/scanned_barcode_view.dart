import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:xscan/manufacturer/models/employee.dart';
import 'package:xscan/worker/models/scanmodel.dart';

import '../../brand view/models/manufacturer.dart';
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
                return DropdownButtonFormField<Agreement>(
                    value: ref.watch(_selectedProduct) ?? data[0],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: "Select product",
                    ),
                    items: data
                        .map((e) => DropdownMenuItem<Agreement>(
                              value: e,
                              child: SizedBox(
                                  height: 74,
                                  width: 150,
                                  child: ListTile(
                                    title: Text(e.product.name),
                                    subtitle: Text("ID: ${e.agreementID}"),
                                  )),
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
                  ..brandName = ref.watch(_selectedProduct)!.product.brandOwner
                  ..id = const Uuid().v4().toString()
                  ..agreementID = ref.watch(_selectedProduct)!.agreementID
                  ..productID = ref.watch(_selectedProduct)!.product.id
                  ..productName = ref.watch(_selectedProduct)!.product.name
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

final _selectedProduct = StateProvider<Agreement?>((ref) => null);
