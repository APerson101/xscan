import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xscan/manufacturer/models/employee.dart';
import 'package:xscan/manufacturer/providers/new_location_provider.dart';

import '../../brand view/models/manufacturer.dart';

class AddNewManuLocation extends ConsumerWidget {
  AddNewManuLocation({super.key, required this.data});
  final Manufacturer data;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(newEmployeeProvider, (pr, nx) {
      if (pr != nx) {
        ref.watch(newEmployeeProvider).when(data: (state) {
          switch (state) {
            case NewEmployeeCreationState.failure:
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content:
                      Text("Failed to create, try different credentials")));
              break;
            case NewEmployeeCreationState.success:
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                      "Successfully created new employee credentials, they can now login")));
              Navigator.of(context).pop();
              break;
            case NewEmployeeCreationState.loading:
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Trying to create new employee!!")));
              break;
            case NewEmployeeCreationState.idle:
              null;
              break;
          }
        }, error: (er, st) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Failed to create, try again later")));
        }, loading: () {
          null;
        });
      }
    });
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                ),
                TextFormField(
                  controller: passwordController,
                ),
                TextFormField(
                  controller: nameController,
                ),
                ElevatedButton(
                    onPressed: () {
                      var employee = Employee(
                          email: emailController.text,
                          password: passwordController.text,
                          name: nameController.text,
                          id: '',
                          businessID: data.id);
                      // use async notifier provider
                      ref
                          .watch(newEmployeeProvider.notifier)
                          .attemptCreation(employee, data.id);
                    },
                    child: const Text("Create new production line")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
