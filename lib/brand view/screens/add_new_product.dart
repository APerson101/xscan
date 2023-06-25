import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:xscan/brand%20view/models/brand.dart';
import 'package:xscan/brand%20view/models/product.dart';
import 'package:xscan/brand%20view/providers/login_provider.dart';

import '../providers/create_product_provider.dart';

class AddNewProductView extends ConsumerWidget {
  AddNewProductView({super.key, required this.brand});
  final formKey = GlobalKey<FormState>();
  final productNameController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final selectedImage = StateProvider<List<XFile>?>((ref) => null);
  final Brand brand;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    pickImages() async {
      var img = await ImagePicker().pickMultiImage();
      ref.watch(selectedImage.notifier).update((state) => state = [...img]);
    }

    ref.listen(productCreationStateProvider, (previous, next) {
      ref.watch(productCreationStateProvider).when(
          data: (ProductCreationStateEnum data) {
        switch (data) {
          case ProductCreationStateEnum.successful:
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Succesfully created")));
            Navigator.of(context).pop();
            ref.invalidate(loginStateProvider);
            break;

          default:
            null;
        }
      }, error: (Object error, StackTrace stackTrace) {
        debugPrintStack(stackTrace: stackTrace);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("failed to create")));
      }, loading: () {
        return;
      });
    });

    return Scaffold(
        persistentFooterButtons: [
          ElevatedButton(
            onPressed: () async {
              var product = Product(
                created: DateTime.now(),
                brandOwner: brand.name,
                id: const Uuid().v4().toString(),
                imageLink: ref
                    .watch(selectedImage)!
                    .map<String>((e) => e.path)
                    .toList(),
                name: productNameController.text,
                notes: productDescriptionController.text,
              );
              ref
                  .watch(productCreationStateProvider.notifier)
                  .createProduct(product, brand, ref.watch(selectedImage)!);
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60)),
            child: const Text("Create new Product"),
          )
        ],
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Add new Product"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  controller: productNameController,
                  decoration: InputDecoration(
                      hintText: "Enter product name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                TextFormField(
                  controller: productDescriptionController,
                  decoration: InputDecoration(
                      hintText: "Enter product description",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                ref.watch(selectedImage) == null
                    ? ElevatedButton(
                        onPressed: () async {
                          await pickImages();
                        },
                        child: const Text("Select product Images"))
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: [
                          ElevatedButton(
                              onPressed: () async {
                                await pickImages();
                              },
                              child: const Text("Change Selection")),
                          ...ref
                              .watch(selectedImage)!
                              .map((e) => Image.file(
                                    File(e.path),
                                    width: 250,
                                    height: 250,
                                    fit: BoxFit.contain,
                                  ))
                              .toList()
                        ]),
                      ),
              ],
            ),
          ),
        ));
  }
}
