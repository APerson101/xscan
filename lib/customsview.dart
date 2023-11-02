import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomsView extends ConsumerWidget {
  const CustomsView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MainViewCustoms();
  }
}

final scannedcode = StateProvider((ref) => "");

class CodeView extends ConsumerWidget {
  const CodeView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(ref.watch(scannedcode)),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DecoratedBox(
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(20)),
                child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Expanded(
                        child: Column(children: [
                      Card(
                        child: Icon(
                          Icons.flag,
                        ),
                      ),
                      Text(
                        "Flag item",
                        style: TextStyle(color: Colors.white),
                      )
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
                      Text(
                        "Approve item",
                        style: TextStyle(color: Colors.white),
                      )
                    ])))),
          ],
        )
      ],
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        const Card(
            child: ListTile(
          title: Text("Bar-Stone XLL Shirt"),
          subtitle: Text("Item name"),
        )),
        Card(
          child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            leading: const Icon(Icons.circle_notifications),
            title: const Text("Source"),
            subtitle: const Text("China manufacturing plant"),
            trailing: const Text("Scanner: AA-Plant, Beijing"),
          ),
        ),
        Card(
          child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            leading: const Icon(Icons.circle_notifications),
            title: const Text("Stop 1"),
            subtitle: const Text("Courier Service A"),
            trailing: const Text("Location: location A, Beijing"),
          ),
        ),
        Card(
          child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            leading: const Icon(Icons.circle_notifications),
            title: const Text("Stop 2"),
            subtitle: const Text("Courier Arrivals B"),
            trailing: const Text("Location: Arizona, US"),
          ),
        ),
      ]),
    );
  }
}

class MainViewCustoms extends ConsumerWidget {
  const MainViewCustoms({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        persistentFooterButtons: [
          ElevatedButton(
            onPressed: () async {
              await FlutterBarcodeScanner.scanBarcode(
                  '#ff6666', 'Cancel', false, ScanMode.BARCODE);
              ref.watch(scannedcode.notifier).state = "345249345418sdf7348";
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CodeView()));
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 65)),
            child: const Text("Scan new"),
          )
        ],
        appBar: AppBar(
            centerTitle: true, title: const Text("Welcome back Mr. Smith")),
        body: Column(children: [
          //
          Card(
              child: ListTile(
            title: const Text("Today's scans:"),
            subtitle: const Text("50"),
            trailing: TextButton(
                onPressed: () async {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const _ViewAllScans();
                  }));
                },
                child: const Text("view all")),
          )),
          Card(
              child: ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const _ViewDetailsPage();
                    }));
                  },
                  title: const Text("Most recent scan:"),
                  subtitle: const Text("Brand Name shirt, XL"),
                  trailing: const Text("code: 4523423hj823"))),
        ]));
  }
}

class _ViewDetailsPage extends ConsumerWidget {
  const _ViewDetailsPage();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("896735249")),
      body: Column(children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
                child: ListTile(
              title: const Text("Date"),
              subtitle: Text(DateTime.now().toIso8601String()),
            ))),
        const Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
                child: ListTile(
              title: Text("Location"),
              subtitle: Text("Sample Location"),
            ))),
        const Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
                child: ListTile(
              title: Text("Brand Name"),
              subtitle: Text("Sample Brand"),
            ))),
        const Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
                child: ListTile(
              title: Text("Brand Contact"),
              subtitle: Text("+1 sample number"),
            ))),
        const Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
                child: ListTile(
              title: Text("Item name"),
              subtitle: Text("Sample name"),
            ))),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
                child: ListTile(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const _BrandCommunication();
                }));
              },
              title: const Text("Communicate with Brand"),
            ))),
      ]),
    );
  }
}

class _ViewAllScans extends ConsumerWidget {
  const _ViewAllScans();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("All scans Today"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: List.generate(
                10,
                (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ExpansionTile(
                          title: Text("Brand ${index + 1}, shirt XL"),
                          subtitle: Text(DateTime.now().toUtc().toString()),
                          children: const [
                            Text("History"),
                            ListTile(
                              leading: Icon(Icons.circle_notifications),
                              title: Text("Source"),
                              subtitle: Text("China manufacturing plant"),
                              trailing: Text("Scanner: AA-Plant, Beijing"),
                            ),
                            ListTile(
                              leading: Icon(Icons.circle_notifications),
                              title: Text("Stop 1"),
                              subtitle: Text("Courier Service A"),
                              trailing: Text("Location: location A, Beijing"),
                            ),
                            ListTile(
                              leading: Icon(Icons.circle_notifications),
                              title: Text("Stop 2"),
                              subtitle: Text("Courier Arrivals B"),
                              trailing: Text("Location: Arizona, US"),
                            ),
                          ],
                        ),
                      ),
                    )),
          ),
        ));
  }
}

class _BrandCommunication extends ConsumerWidget {
  const _BrandCommunication();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(),
        persistentFooterButtons: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 65)),
              child: const Text("Send"))
        ],
        body: Column(
          children: [
            DropdownButton(
                borderRadius: BorderRadius.circular(20),
                value: ref.watch(_brandCommunicationReason),
                items: const [
                  DropdownMenuItem(
                      value: 0, child: Text("Rescind product approval")),
                  DropdownMenuItem(
                      value: 1, child: Text("Request manual verification")),
                ],
                onChanged: (newSelected) {
                  if (newSelected != null) {
                    ref.watch(_brandCommunicationReason.notifier).state =
                        newSelected;
                  }
                }),
            TextFormField(
              minLines: 4,
              maxLines: 6,
              decoration: InputDecoration(
                  hintText: "Enter text",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ],
        ));
  }
}

final _brandCommunicationReason = StateProvider((ref) => 0);

// show rejected item due to duplicate

class RejectedView extends ConsumerWidget {
  const RejectedView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(title: const Text("Problem found with this item")),
        body: SingleChildScrollView(
          child: Column(children: [
            const Text("Info found is:"),
            const Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                    child: ListTile(
                        title: Text("XL large Bag 1"),
                        subtitle: Text("Brand B")))),
            const Text("However, Barcode info already exists"),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                    child: ListTile(
                        title: const Text("Date"),
                        subtitle: Text(DateTime.now()
                            .subtract(const Duration(days: 20))
                            .toIso8601String())))),
            const Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                    child: ListTile(
                        title: Text("Location"),
                        subtitle: Text("Location G")))),
            const Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                    child: ListTile(
                        title: Text("Status"), subtitle: Text("Approved")))),
          ]),
        ));
  }
}
