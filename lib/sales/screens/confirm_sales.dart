import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/sales_model.dart';
import '../providers/sales_providers.dart';

class ConfirmSaleView extends ConsumerWidget {
  ConfirmSaleView({super.key, required this.barcode, required this.staff});
  final SalesModel staff;
  final String barcode;
  final receiverController = TextEditingController();
  final costController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(confirmSaleProvider, (previous, next) {
      ref.watch(confirmSaleProvider).when(
          data: (state) {
            if (state == ConfirmSaleEnum.successful) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Sale Confirmed")));
            }
          },
          error: (Object error, StackTrace stackTrace) {},
          loading: () {});
    });
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(barcode),
          TextFormField(
            controller: receiverController,
            decoration: InputDecoration(
                hintText: 'enter receiver',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
          ),
          TextFormField(
            controller: costController,
            decoration: InputDecoration(
                hintText: 'enter cost',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
          ),
          ref.watch(getItemInfoProvider(barcode)).when(data: (data) {
            return SizedBox(
                height: 70,
                child: ListTile(
                  title: Text(data.brandName!),
                  subtitle: Text(data.productName!),
                  trailing: TextButton(
                      onPressed: () {
                        ref.watch(confirmSaleProvider.notifier).tryConfirmSale(
                            staff,
                            barcode,
                            '0.0.14962704',
                            data,
                            double.parse(costController.text));
                      },
                      child: const Text("Confirm sale")),
                ));
          }, error: (Object error, StackTrace stackTrace) {
            return const Text("error");
          }, loading: () {
            return const CircularProgressIndicator.adaptive();
          })
        ],
      ),
    );
  }
}
