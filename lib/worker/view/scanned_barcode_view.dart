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
      appBar: AppBar(
        centerTitle: true,
        title: Text("scanned code is: $barcode"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
                              value: e, child: Text(e.product.name)))
                          .toList(),
                      onChanged: (newt) {
                        if (newt != null) {
                          ref.watch(_selectedProduct.notifier).state = newt;
                        }
                      });
                },
                error: (er, st) => const Text("error"),
                loading: () => const CircularProgressIndicator.adaptive()),
            ref.watch(_selectedProduct) == null
                ? Container()
                : Card(
                    child: ListTile(
                    title: Text(
                        "Brand Name: ${ref.watch(_selectedProduct)!.product.brandOwner}"),
                    subtitle: Text(
                        "Product Name: ${ref.watch(_selectedProduct)!.product.name}"),
                  )),
            ref.watch(_selectedProduct) == null
                ? Container()
                : SizedBox(
                    height: 200,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...ref
                                .watch(_selectedProduct)!
                                .product
                                .imageLink
                                .map((e) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.network(e),
                                    ))
                                .toList()
                          ],
                        )),
                  ),
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
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 65)),
              child: const Text("Continue"),
            )
          ],
        ),
      ),
    );
  }
}

final _selectedProduct = StateProvider<Agreement?>((ref) => null);
