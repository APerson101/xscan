import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xscan/manufacturer/providers/manu_providers.dart';

import '../../brand view/models/manufacturer.dart';
import '../models/employee.dart';

class PeopleView extends ConsumerWidget {
  const PeopleView({super.key, required this.data});
  final Manufacturer data;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getEmployees(data.id)).when(data: (employees) {
      return SfDataGrid(
          selectionMode: SelectionMode.single,
          onSelectionChanged: (addedRows, removedRows) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Delete Staff"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            ref.watch(
                                deleteStaff(addedRows[0].getCells()[0].value));
                            Navigator.of(context).pop();
                          },
                          child: const Text("Yes")),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("No")),
                    ],
                  );
                });
          },
          source: _PeopleDataSource(people: employees),
          columns: [
            GridColumn(label: const Text("id"), columnName: 'id'),
            GridColumn(label: const Text("Name"), columnName: 'name'),
            GridColumn(label: const Text("email"), columnName: 'email'),
          ]);
    }, error: (Object error, StackTrace stackTrace) {
      return const Center(
        child: Text("Error loading"),
      );
    }, loading: () {
      return const CircularProgressIndicator.adaptive();
    });
  }
}

class _PeopleDataSource extends DataGridSource {
  _PeopleDataSource({required List<Employee> people}) {
    data = people
        .map((e) => DataGridRow(cells: [
              DataGridCell(columnName: 'id', value: e.id),
              DataGridCell(columnName: 'name', value: e.name),
              DataGridCell(columnName: 'email', value: e.email),
            ]))
        .toList();
  }
  List<DataGridRow> data = [];
  @override
  List<DataGridRow> get rows => data;
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map((e) => Text(e.value)).toList());
  }
}
