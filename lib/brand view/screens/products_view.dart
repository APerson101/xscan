import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xscan/brand%20view/models/brand.dart';

import '../models/product.dart';

class ProductsView extends ConsumerWidget {
  const ProductsView({super.key, required this.brand});
  final Brand brand;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
        child: Column(
      children: [
        ...brand.catalog
            .map((e) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return Scaffold(
                              body: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ...e.imageLink
                                        .map((e) => Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Image.network(e,
                                                  width: 200, height: 200),
                                            ))
                                        .toList()
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    title: Text(e.name),
                    subtitle: Text(e.notes),
                  ),
                ))
            .toList()
        // SfDataGrid(
        //   columnWidthMode: ColumnWidthMode.auto,
        //   onSelectionChanged: (sel, ch){

        //   },
        //   columns: [
        //     GridColumn(columnName: 'id', label: const Text("ID")),
        //     GridColumn(columnName: 'name', label: const Text("name")),
        //     // GridColumn(
        //     //     columnName: 'quantity made',
        //     //     label: const Text("quantity made")),
        //     GridColumn(
        //         columnName: 'manufacturer', label: const Text("manufacturer")),
        //   ],
        //   source: _ProductsDataSource(products: brand.catalog),
        // )
      ],
    ));
  }
}

class _ProductsDataSource extends DataGridSource {
  _ProductsDataSource({required List<Product> products}) {
    _productsdata = products
        .map((e) => DataGridRow(cells: [
              DataGridCell(columnName: 'id', value: e.id),
              DataGridCell(columnName: 'name', value: e.name),
              // DataGridCell(columnName: 'quantity made', value: e.created),
              DataGridCell(columnName: 'manufacturer', value: e.notes),
            ]))
        .toList();
  }

  List<DataGridRow> _productsdata = [];

  @override
  List<DataGridRow> get rows => _productsdata;
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map((e) => Text(e.value)).toList());
  }
}
