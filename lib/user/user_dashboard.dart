import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xscan/all/cross_widgets.dart';
import 'package:xscan/brand%20view/helpers/db2.dart';
import 'package:xscan/user/providers/market_place_provider.dart';

import 'scaned_info.dart';

class UserDashboard extends ConsumerWidget {
  const UserDashboard({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getUserFromIdProvider(id)).when(data: (user) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Wallet(
                  accountID: user.accountID,
                  image: user.profilePic,
                  name: user.name,
                  pk: user.privateKey),
              ElevatedButton(
                onPressed: () async {
                  String barcodeScanRes = '';
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
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 65)),
                child: const Text("Scan qr code"),
              )
            ]),
      );
    }, error: (Object error, StackTrace stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      return const Center(
        child: Text("Omo, e no dey"),
      );
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    });
  }
}

final userBalancesProvider = StateProvider<BalanceResponse?>((ref) => null);
