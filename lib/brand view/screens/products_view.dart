import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xscan/brand%20view/models/brand.dart';

import '../models/product.dart';

class ProductsView extends ConsumerWidget {
  const ProductsView({super.key, required this.brand});
  final Brand brand;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.count(
        semanticChildCount: brand.catalog.length,
        crossAxisCount: 2,
        children: [
          ...brand.catalog.map((product) {
            var controller =
                PageController(viewportFraction: 1, keepPage: true);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: GestureDetector(
                  onTap: () async {
                    await showDialog(
                        context: context,
                        builder: (context) {
                          return Scaffold(
                            appBar: AppBar(),
                            body: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ...product.imageLink
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.all(10.0),
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
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          // height: 350,
                          child: PageView.builder(
                            itemCount: product.imageLink.length,
                            controller: controller,
                            itemBuilder: (_, index) {
                              return DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: SizedBox(
                                      height: 250,
                                      child: Image.network(
                                          product.imageLink[index])));
                            },
                          ),
                        ),
                        SmoothPageIndicator(
                            controller: controller,
                            count: product.imageLink.length,
                            effect: const WormEffect(
                                dotHeight: 16,
                                dotWidth: 16,
                                type: WormType.thinUnderground)),
                        Expanded(
                          child: ListTile(
                            title: Text('Product name: ${product.name}'),
                            subtitle: Text(
                                'Date Added: ${DateFormat.yMMMEd().format(product.created)}'),
                          ),
                        )
                      ]),
                ),
              ),
            );
          }).toList()

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
        ]);
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
