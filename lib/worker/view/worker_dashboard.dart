import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xscan/manufacturer/models/employee.dart';
import 'package:xscan/worker/providers/employee_provider.dart';
import 'package:xscan/worker/view/scanned_barcode_view.dart';

import '../models/scanmodel.dart';

class WorkerDashboardView extends ConsumerWidget {
  const WorkerDashboardView({super.key, required this.employee});
  final Employee employee;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _CompletedScans(employee.id),
          _CameraView(employee),
        ],
      ),
    );
  }
}

class _CameraView extends ConsumerWidget {
  const _CameraView(this.employee);
  final Employee employee;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          String barcodeScanRes;
          try {
            barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                '#ff6666', 'Cancel', false, ScanMode.QR);
            // barcodeScanRes = const Uuid().v4().toString();
            debugPrint('Scanned code is: $barcodeScanRes');
            if (context.mounted) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ScannedBarcodeView(
                  barcode: barcodeScanRes,
                  employee: employee,
                );
              }));
            }
            debugPrint(barcodeScanRes);
          } on PlatformException {
            barcodeScanRes = 'Failed to get platform version.';
          }
        },
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 65)),
        child: const Text("Scan Code"),
      ),
    );
  }
}

class _CompletedScans extends ConsumerWidget {
  const _CompletedScans(this.id);
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var amount =
        ref.watch(getEmpHistoryProvider(id)).when(data: (List<ScanModel> data) {
      return (data.where((element) => element.timeAdded!
              .isBefore(DateTime(DateTime.now().year, DateTime.now().day))))
          .length
          .toString();
    }, error: (Object error, StackTrace stackTrace) {
      return 'error';
    }, loading: () {
      return 'loading';
    });

    return DecoratedBox(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: Column(
          children: [
            Text("Number of completed scans today: $amount"),
          ],
        ));
  }
}
