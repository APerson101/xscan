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
              height: 100,
              child: _BrandStats(brand: brand)),
          Positioned(
              top: 185,
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
              height: 430,
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
    return Row(
      children: [
        ElevatedButton(
            onPressed: () {
              //initialize add product page
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddNewProductView(brand: brand)));
            },
            child: const Center(child: Text("Add New Product"))),
        ElevatedButton(
            onPressed: () {
              //initialize add manufacturer page
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return AddNewManufacturerView(brand: brand);
              }));
            },
            child: const Center(child: Text("Add Manufacturer"))),
      ],
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
        data: (data) => Text(data.length.toString()),
        error: (er, st) => const Center(child: Text("ERROR")),
        loading: () => const CircularProgressIndicator.adaptive());
    var resold = ref.watch(getOwnershipTransferProvider(brand.id)).when(
        data: (data) => Text(data.length.toString()),
        error: (er, st) => const Center(child: Text("ERROR")),
        loading: () => const CircularProgressIndicator.adaptive());
    var pendingApproval =
        ref.watch(getPendingApprovalProvider(brand.name)).when(
            data: (data) {
              return ListTile(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return BrandPendingView(
                      data: data,
                      brand: brand,
                    );
                  }));
                },
                title: Text("need your approval: ${data.length}"),
              );
            },
            error: (er, st) => const Center(child: Text("ERROR")),
            loading: () => const CircularProgressIndicator.adaptive());
    return Column(
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
                child: GestureDetector(
                  onTap: () {
                    //take me to the manufacturer main page
                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (context) {
                    //   return ManufacturerInfoView(data: index.);
                    // }));
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.amber.shade50),
                    child: Column(
                      children: [
                        Text(index.manufacturerName),
                        Text(index.manufacturedProducts),
                        Text(index.manufacturerLocation),
                        Text(index.numberItemsProduced)
                      ],
                    ),
                  ),
                ),
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
