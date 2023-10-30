import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomsView extends ConsumerWidget {
  const CustomsView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              await FlutterBarcodeScanner.scanBarcode(
                  '#ff6666', 'Cancel', false, ScanMode.BARCODE);
              ref.watch(scannedcode.notifier).state = "345249345418sdf7348";
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CodeView()));
            },
            child: const Text("Scan new")),
      ),
    );
  }
}

final scannedcode = StateProvider((ref) => "");

class CodeView extends ConsumerWidget {
  const CodeView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Text(ref.watch(scannedcode)),
        const Text("Bar-Stone XLL Shirt"),
        const ListTile(
          leading: Icon(Icons.circle_notifications),
          title: Text("Source"),
          subtitle: Text("China manufacturing plant"),
          trailing: Text("Scanner: AA-Plant, Beijing"),
        ),
        const ListTile(
          leading: Icon(Icons.circle_notifications),
          title: Text("Stop 1"),
          subtitle: Text("Courier Service A"),
          trailing: Text("Location: location A, Beijing"),
        ),
        const ListTile(
          leading: Icon(Icons.circle_notifications),
          title: Text("Stop 2"),
          subtitle: Text("Courier Arrivals B"),
          trailing: Text("Location: Arizona, US"),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DecoratedBox(
                decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.circular(20)),
                child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Expanded(
                        child: Column(children: [
                      Card(
                        child: Icon(Icons.flag),
                      ),
                      Text("Flag item")
                    ])))),
            DecoratedBox(
                decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.circular(20)),
                child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Expanded(
                        child: Column(children: [
                      Card(
                        child: Icon(Icons.check),
                      ),
                      Text("Approve item")
                    ])))),
          ],
        )
      ]),
    );
  }
}
