import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

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
      appBar: AppBar(
        centerTitle: true,
        title: Text("Code retreived is: $barcode"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextFormField(
            controller: receiverController,
            decoration: InputDecoration(
                suffix: IconButton(
                    onPressed: () async {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return Scaffold(
                            appBar: AppBar(title: const Text('Scanner')),
                            body: MobileScanner(onDetect: (capture) {
                              final List<Barcode> barcodes = capture.barcodes;
                              for (final barcode in barcodes) {
                                debugPrint(
                                    'Barcode found! ${barcode.rawValue}');
                                barcode.rawValue != null
                                    ? receiverController.text =
                                        barcode.rawValue!
                                    : "nothing received";
                              }
                            }));
                      }));
                    },
                    icon: const Icon(Icons.qr_code_2)),
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
                            receiverController.text,
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
