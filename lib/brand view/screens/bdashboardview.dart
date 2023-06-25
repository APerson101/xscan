import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xscan/all/cross_widgets.dart';
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: 250,
                child: Wallet(
                    accountID: brand.accountID,
                    image: brand.logoImage,
                    pk: brand.privateKey,
                    name: brand.name)),
            SizedBox(height: 170, child: _ActionButtons(brand)),
            SizedBox(height: 200, child: _BrandStats(brand: brand)),
            const Row(
              children: [
                Expanded(child: Divider()),
                Text("Manufacturers Activity Summary"),
                Expanded(child: Divider()),
              ],
            ),
            SizedBox(height: 250, child: _ManufacturersSummary(brand: brand))
          ],
        ),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Card(
              child: ListTile(
                  leading: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.add, color: Colors.white),
                      )),
                  subtitle: const Text("Number of products: "),
                  trailing: Text(brand.catalog.length.toString()),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddNewProductView(brand: brand)));
                  },
                  title: const Text("Add New Product"))),
          Card(
              child: ListTile(
                  title: const Text("Request new manufacturer"),
                  leading: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.amber),
                    child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.business, color: Colors.white)),
                  ),
                  subtitle: const Text("click to start a new agreement"),
                  onTap: () => Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return AddNewManufacturerView(brand: brand);
                      }))))
        ],
      ),
    );
  }
}

class _BrandStats extends ConsumerWidget {
  const _BrandStats({required this.brand});
  final Brand brand;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var resold = ref.watch(getOwnershipTransferProvider(brand.id)).when(
        data: (data) => Card(
              child: ListTile(
                title: const Text("Number of Items resold:"),
                trailing: Text(data.length.toString()),
              ),
            ),
        error: (er, st) => const Center(child: Text("ERROR")),
        loading: () => const CircularProgressIndicator.adaptive());
    var pendingApproval =
        ref.watch(getPendingApprovalProvider(brand.name)).when(
            data: (data) {
              return Card(
                child: ListTile(
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
                ),
              );
            },
            error: (er, st) => const Center(child: Text("ERROR")),
            loading: () => const CircularProgressIndicator.adaptive());
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [resold, pendingApproval],
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
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      title: Text('Name: ${index.manufacturerName}'),
                      subtitle: Text(
                          'Number of products: ${index.manufacturedProducts}'),
                      leading: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.brown,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.house, color: Colors.white),
                        ),
                      ),
                      trailing:
                          Text('Total output: ${index.numberItemsProduced}'),
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
