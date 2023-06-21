import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xscan/brand%20view/models/brand.dart';

import '../models/product.dart';
import 'add_new_manufacturer.dart';
import 'add_new_product.dart';

class ProductsView extends ConsumerWidget {
  const ProductsView({super.key, required this.brand});
  final Brand brand;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
        child: Column(
      children: [
        _ActionButtons(brand),
        SfDataGrid(
          columnWidthMode: ColumnWidthMode.auto,
          columns: [
            GridColumn(columnName: 'id', label: const Text("ID")),
            GridColumn(columnName: 'name', label: const Text("name")),
            // GridColumn(
            //     columnName: 'quantity made',
            //     label: const Text("quantity made")),
            GridColumn(
                columnName: 'manufacturer', label: const Text("manufacturer")),
          ],
          source: _ProductsDataSource(products: brand.catalog),
        )
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

class _ActionButtons extends ConsumerWidget {
  const _ActionButtons(this.brand);
  final Brand brand;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddNewProductView(brand: brand)));
            },
            child: SizedBox(
                height: 70,
                width: 150,
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(15)),
                    child: const Center(child: Text("Add Product")))),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return AddNewManufacturerView(brand: brand);
              }));
            },
            child: SizedBox(
                height: 70,
                width: 150,
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(15)),
                    child: const Center(child: Text("Request Manufacturer")))),
          ),
          // ElevatedButton(
          //     onPressed: () async {
          //       var db = GetIt.I<DataBase>();
          //       var empID = await db.getFileContent('0.0.4350922');

          //       return;
          //       var brandID = await db.createFakeUser('m2@x.com', '11111111');
          //       await db.storeFakeUser(brandID, 'manufacturer');
          //       var account = await db.createAccount();
          //       String accID = account['accountID'];
          //       String pk = account['privateKey'];
          //       await db.createManufacturers(
          //           manu: Manufacturer(
          //               name: 'manufacturer name',
          //               location: 'Wuse',
          //               notes: 'Notes about this guy',
          //               id: brandID,
          //               productions: [],
          //               accountID: accID,
          //               privateKey: pk));
          //     },
          //     child: const Text("Create second manufacturer"))
        ],
      ),
    );
  }
}
