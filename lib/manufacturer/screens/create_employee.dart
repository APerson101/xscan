import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:xscan/brand%20view/helpers/db.dart';

import '../../brand view/models/manufacturer.dart';
import '../models/employee.dart';
import '../providers/manu_providers.dart';

part 'create_employee.g.dart';

class CreateEmployeePage extends ConsumerWidget {
  CreateEmployeePage({super.key, required this.manufacturer});
  final Manufacturer manufacturer;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      hintText: 'Enter employee name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)))),
              TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: 'Enter employee email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)))),
              TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      hintText: 'Enter employee password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)))),
              ElevatedButton(
                  onPressed: () async {
                    ref.watch(createEmployeeProvider(Employee(
                        email: emailController.text,
                        password: passwordController.text,
                        name: nameController.text,
                        id: const Uuid().v4(),
                        businessID: manufacturer.id)));
                    Navigator.of(context).pop();
                    ref.invalidate(getEmployees(manufacturer.id));
                  },
                  child: const Text("Create employee"))
            ],
          )),
    );
  }
}

@riverpod
FutureOr createEmployee(CreateEmployeeRef ref, Employee employee) async {
  var db = GetIt.I<DataBase>();
  await db.createEmployees(employee.id, employee);
}
