import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xscan/user/scaned_info.dart';

class UserMain extends ConsumerWidget {
  const UserMain({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(children: [
        ElevatedButton(
            onPressed: () async {
              String barcodeScanRes;
              try {
                barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                    '#ff6666', 'Cancel', false, ScanMode.BARCODE);

                if (context.mounted) {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return ScannedInfo(
                      barcode: barcodeScanRes,
                    );
                  }));
                }
              } on PlatformException {
                barcodeScanRes = 'Failed to get platform version.';
              }
            },
            child: const Text("Scan qr code"))
      ]),
    );
  }
}
