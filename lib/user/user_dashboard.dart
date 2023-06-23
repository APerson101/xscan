import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:xscan/brand%20view/helpers/db2.dart';
import 'package:xscan/brand%20view/providers/login_provider.dart';

import 'scaned_info.dart';

class UserDashboard extends ConsumerWidget {
  const UserDashboard({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {
                ref.watch(userBalancesProvider.notifier).state =
                    await GetIt.I<BaseHelper>()
                        .retreiveBalance(accountID: '0.0.14962704');
              },
              child: const Text("Retrive Balance")),
          ElevatedButton(
              onPressed: () async {
                await ref.watch(loginStateProvider.notifier).logout();
              },
              child: const Text("Log out")),
          ElevatedButton(
              onPressed: () async {
                String barcodeScanRes;
                try {
                  barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                      '#ff6666', 'Cancel', false, ScanMode.BARCODE);

                  if (context.mounted) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const ScannedInfo(
                        barcode: '6d119298-18af-40c3-b4e2-eff8e708961a',
                      );
                    }));
                  }
                } on PlatformException {
                  barcodeScanRes = 'Failed to get platform version.';
                }
              },
              child: const Text("Scan qr code"))
        ]);
  }
}

final userBalancesProvider = StateProvider<BalanceResponse?>((ref) => null);
