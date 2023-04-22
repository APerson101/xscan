import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/sales_providers.dart';
import 'confirm_sales.dart';

class SalesHome extends ConsumerWidget {
  const SalesHome({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getSalesInfoProvider(id)).when(
        data: (salesInfo) {
          return SizedBox.expand(
            child: SingleChildScrollView(
              child: Column(children: [
                ElevatedButton(
                    onPressed: () async {
                      String barcodeScanRes;
                      try {
                        barcodeScanRes =
                            await FlutterBarcodeScanner.scanBarcode(
                                '#ff6666', 'Cancel', false, ScanMode.BARCODE);
                        barcodeScanRes = "32f922cd-d304-4c1c-9102-58d68022e94a";
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ConfirmSaleView(
                            barcode: barcodeScanRes,
                            staff: salesInfo,
                          );
                        }));
                        debugPrint(barcodeScanRes);
                      } on PlatformException {
                        barcodeScanRes = 'Failed to get platform version.';
                      }
                    },
                    child: const Text("Scan barcode")),
              ]),
            ),
          );
        },
        error: (e, s) {
          return const Center(child: Text("Failed to load info,"));
        },
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()));
  }
}
