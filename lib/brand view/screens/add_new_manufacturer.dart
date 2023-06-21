import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:xscan/brand%20view/models/brand.dart';
import 'package:xscan/brand%20view/models/brand_manufacturer.dart';
import 'package:xscan/brand%20view/models/manufacturer.dart';

import '../models/product.dart';
import '../providers/brand_providers.dart';

class AddNewManufacturerView extends ConsumerWidget {
  AddNewManufacturerView({super.key, required this.brand});
  final quantityController = TextEditingController();
  final selectedManufacturer = StateProvider<Manufacturer?>((ref) => null);
  final selectedProduct = StateProvider<Product?>((ref) => null);
  final Brand brand;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placedText = StateProvider((ref) {
      var manufacturer = ref.watch(selectedManufacturer);
      var item = ref.watch(selectedProduct);
      if (manufacturer == null || item == null) return '';
      return '${manufacturer.name} would produce ${quantityController.text} quantities of ${item.name}';
    });
    ref.listen(sendManuRequestStateProvider, (previous, next) {
      ref.watch(sendManuRequestStateProvider).when(data: (state) {
        if (state == SendManuRequestStateEnum.successful) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Successfully created")));
          Navigator.of(context).pop();
        }
        if (state == SendManuRequestStateEnum.failed) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Failed to  create")));
        }
      }, error: (Object error, StackTrace stackTrace) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Failed to  create")));
      }, loading: () {
        return;
      });
    });
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Add new Manufacturer"),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 8.0, bottom: 8),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  ref.watch(getallManufacturersProvider).when(
                      data: (manufacturers) {
                        return DropdownButtonFormField<Manufacturer>(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            value: ref.watch(selectedManufacturer),
                            hint: const Text("Select manufacturer"),
                            items: [
                              ...List.generate(manufacturers.length, (index) {
                                return DropdownMenuItem(
                                    value: manufacturers[index],
                                    child: Text(manufacturers[index].name));
                              })
                            ],
                            onChanged: (manufacturer) {
                              if (manufacturer != null) {
                                ref.watch(selectedManufacturer.notifier).state =
                                    manufacturer;
                              }
                            });
                      },
                      error: (er, st) => const Text("Error"),
                      loading: () => const Center(
                          child: CircularProgressIndicator.adaptive())),
                  const SizedBox(
                    height: 70,
                  ),
                  DropdownButtonFormField<Product>(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      value: ref.watch(selectedProduct),
                      hint: const Text("Select product"),
                      items: brand.catalog.map((index) {
                        return DropdownMenuItem(
                            value: index, child: Text(index.name));
                      }).toList(),
                      onChanged: (product) {
                        if (product != null) {
                          ref.watch(selectedProduct.notifier).state = product;
                        }
                      }),
                  const SizedBox(
                    height: 70,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: quantityController,
                    onChanged: (_) => ref.invalidate(placedText),
                    decoration: InputDecoration(
                        labelText: 'Enter quantity to be produced',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Text(ref.watch(placedText)),
                  const SizedBox(
                    height: 100,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        var agreement = BrandManufaturer(
                            brandID: brand.id,
                            product: ref.watch(selectedProduct)!,
                            id: const Uuid().v4().toString(),
                            manufacturerID: ref.watch(selectedManufacturer)!.id,
                            productID: ref.watch(selectedProduct)!.id,
                            quantity: int.parse(quantityController.text),
                            manufacturerAgreed: false,
                            dateCreated: DateTime.now(),
                            userCreated: true);
                        ref
                            .watch(sendManuRequestStateProvider.notifier)
                            .sendManufacturerRequest(agreement);
                      },
                      style: ElevatedButton.styleFrom(
                          maximumSize: Size.infinite,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      child: const Text("Create"))
                ],
              ),
            ),
          ),
        ));
  }
}
