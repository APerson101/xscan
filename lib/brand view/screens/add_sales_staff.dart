import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:xscan/brand%20view/models/brand.dart';
import 'package:xscan/sales/models/sales_model.dart';

import '../helpers/db.dart';

part 'add_sales_staff.g.dart';

class AddSalesStaff extends ConsumerWidget {
  AddSalesStaff({super.key, required this.brand});
  final Brand brand;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(_creationState, (previous, next) {
      if (previous != next && next != null) {
        if (next) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Successfully added employee")));
          Navigator.of(context).pop();
        }
      }
    });
    return Scaffold(
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () async {
            ref.watch(createStaffProvider(SalesModel(
                email: emailController.text,
                password: passwordController.text,
                name: nameController.text,
                id: const Uuid().v4(),
                image: ref.watch(_employeeImage)!.path,
                brandID: brand.id,
                accountID: '',
                brandName: brand.name,
                privateKey: '')));
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 65)),
          child: const Text("Create employee"),
        )
      ],
      appBar: AppBar(),
      body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        hintText: 'Enter staff name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)))),
                TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: 'Enter staff email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)))),
                TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Enter staff password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)))),
                ref.watch(_employeeImage) == null
                    ? ElevatedButton(
                        onPressed: () async {
                          ref.watch(_employeeImage.notifier).state =
                              await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                        },
                        child: const Text("Select employee profile pic"))
                    : CircleAvatar(
                        radius: 100,
                        backgroundImage: FileImage(
                          File(ref.watch(_employeeImage)!.path),
                        )),
              ],
            ),
          )),
    );
  }
}

@riverpod
FutureOr createStaff(CreateStaffRef ref, SalesModel sales) async {
  var db = GetIt.I<DataBase>();
  await db.createSales(sales.id, sales);
  ref.watch(_creationState.notifier).state = true;
}

final _employeeImage = StateProvider<XFile?>((ref) => null);
final _creationState = StateProvider<bool?>((ref) => null);
