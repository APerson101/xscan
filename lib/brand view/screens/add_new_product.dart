import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:xscan/brand%20view/models/brand.dart';
import 'package:xscan/brand%20view/models/product.dart';

import '../providers/create_product_provider.dart';

class AddNewProductView extends ConsumerWidget {
  AddNewProductView({super.key, required this.brand});
  final formKey = GlobalKey<FormState>();
  final productNameController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final selectedManufacturer = StateProvider((ref) => 0);
  final selectedImage = StateProvider<XFile?>((ref) => null);
  final Brand brand;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    pickImage() async {
      var img = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (img != null) {
        ref.watch(selectedImage.notifier).state = img;
      }
    }

    ref.listen(productCreationStateProvider, (previous, next) {
      ref.watch(productCreationStateProvider).when(
          data: (ProductCreationStateEnum data) {
        switch (data) {
          case ProductCreationStateEnum.successful:
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Succesfully created")));
            Navigator.of(context).pop();
            break;
          default:
            null;
        }
      }, error: (Object error, StackTrace stackTrace) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("failed to create")));
      }, loading: () {
        return;
      });
    });

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Add new Product"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: productNameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  TextFormField(
                    controller: productDescriptionController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  ref.watch(selectedImage) == null
                      ? ElevatedButton(
                          onPressed: () async {
                            await pickImage();
                          },
                          child: const Text("select Image"))
                      : Row(children: [
                          ElevatedButton(
                              onPressed: () async {
                                await pickImage();
                              },
                              child: const Text("ChangeImage")),
                          Image.file(
                            File(ref.watch(selectedImage)!.path),
                            width: 250,
                            height: 250,
                            fit: BoxFit.contain,
                          )
                        ]),
                  DropdownButton<int>(
                      value: ref.watch(selectedManufacturer),
                      items: [
                        ...List.generate(
                            5,
                            (index) => DropdownMenuItem(
                                value: index,
                                child: Text("Manufactuer ${index + 1}")))
                      ],
                      onChanged: (newlySelected) {
                        newlySelected != null
                            ? ref.watch(selectedManufacturer.notifier).state =
                                newlySelected
                            : null;
                      }),
                  ElevatedButton(
                      onPressed: () async {
                        // validate and save
                        var product = Product(
                          created: DateTime.now(),
                          brandOwner: brand.name,
                          id: const Uuid().v4().toString(),
                          imageLink: '',
                          name: productNameController.text,
                          notes: '',
                        );
                        ref
                            .watch(productCreationStateProvider.notifier)
                            .createProduct(product, brand.id);
                      },
                      child: const Text("Create new Product"))
                ],
              ),
            ),
          ),
        ));
  }
}
