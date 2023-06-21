import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xscan/brand%20view/models/brand.dart';
import 'package:xscan/brand%20view/screens/view_pending.dart';

import '../providers/brand_providers.dart';
import 'add_new_manufacturer.dart';
import 'add_new_product.dart';

class BDashboardView extends ConsumerWidget {
  const BDashboardView({super.key, required this.brand});
  final Brand brand;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 80,
              child: _ActionButtons(brand)),
          Positioned(
              top: 80,
              left: 0,
              right: 0,
              child: Row(
                children: const [
                  Expanded(child: Divider()),
                  Text("Actions"),
                  Expanded(child: Divider()),
                ],
              )),
          Positioned(
              top: 100,
              left: 0,
              right: 0,
              height: 250,
              child: _BrandStats(brand: brand)),
          Positioned(
              top: 350,
              left: 0,
              right: 0,
              child: Row(
                children: const [
                  Expanded(child: Divider()),
                  Text("Summary"),
                  Expanded(child: Divider()),
                ],
              )),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 250,
              child: _ManufacturersSummary(brand: brand))
        ],
      ),
    );
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

class _BrandStats extends ConsumerWidget {
  const _BrandStats({required this.brand});
  final Brand brand;
  //// not done yet
  ///but I definitely have to do it
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var verifications = ref.watch(getVerificationsProvider(brand.id)).when(
        data: (data) => ListTile(
              tileColor: const Color.fromRGBO(255, 253, 219, 1),
              title: const Text("Number of verifications made: "),
              trailing: Text(data.length.toString()),
            ),
        error: (er, st) => const Center(child: Text("ERROR")),
        loading: () => const CircularProgressIndicator.adaptive());
    var resold = ref.watch(getOwnershipTransferProvider(brand.id)).when(
        data: (data) => ListTile(
              tileColor: const Color.fromRGBO(208, 255, 254, 1),
              title: const Text("Number of Items resold:"),
              trailing: Text(data.length.toString()),
            ),
        error: (er, st) => const Center(child: Text("ERROR")),
        loading: () => const CircularProgressIndicator.adaptive());
    var pendingApproval =
        ref.watch(getPendingApprovalProvider(brand.name)).when(
            data: (data) {
              return ListTile(
                tileColor: const Color.fromRGBO(228, 255, 222, 1),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return BrandPendingView(
                      data: data,
                      brand: brand,
                    );
                  }));
                },
                title: const Text("Items that need your approval: "),
                trailing: Text(data.length.toString()),
              );
            },
            error: (er, st) => const Center(child: Text("ERROR")),
            loading: () => const CircularProgressIndicator.adaptive());
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [verifications, resold, pendingApproval],
    );
  }
}

class _ManufacturersSummary extends ConsumerWidget {
  const _ManufacturersSummary({required this.brand});
  final Brand brand;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var summaryProvider = ref.watch(getManuSummaryProvider(brand));

    return summaryProvider.when(data: (summaryData) {
      return SingleChildScrollView(
        child: Column(
          children: [
            ...summaryData.map((index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.amber.shade50),
                    child: ListTile(
                      title: Text(index.manufacturerName),
                      subtitle: Text(index.manufacturedProducts),
                      leading: const Icon(Icons.house),
                      trailing: Text(index.numberItemsProduced),
                    )),
              );
            }).toList()
          ],
        ),
      );
    }, error: (Object error, StackTrace stackTrace) {
      return const Center(child: Text("Unable to load data"));
    }, loading: () {
      return const CircularProgressIndicator.adaptive();
    });
  }
}
