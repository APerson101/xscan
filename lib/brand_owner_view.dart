import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xscan/all/cross_widgets.dart';

class BrandOwnerView extends ConsumerWidget {
  const BrandOwnerView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(title: const Text("Welcome back Brand A")),
        body: const Column(children: [
          Wallet(
              accountID: "accountID",
              image: "image",
              name: "Brand A",
              pk: "783253786"),
          // statistics
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                  child: ListTile(
                      title: Text("Approved items"), subtitle: Text("43")))),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                  child: ListTile(
                      title: Text("Rejected items"), subtitle: Text("67")))),
        ]));
  }
}

class RejectedView extends ConsumerWidget {
  const RejectedView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Potential Counferfeits"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: List.generate(10, (index) {
              return ExpansionTile(
                title: const Text("Product name"),
                subtitle: const Text("XL pants"),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                          title: const Text("Date"),
                          subtitle: Text(DateTime.now().toIso8601String())),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                          title: Text("barcode"),
                          subtitle: Text("34523894jk89")),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                          title: Text("Location"),
                          subtitle: Text("Location 1s")),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {},
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 65)),
                    child: const Text("Raise claim"),
                  )
                ],
              );
            }),
          ),
        ));
  }
}

class ApprovedView extends ConsumerWidget {
  const ApprovedView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Approved Items"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: List.generate(10, (index) {
              return ExpansionTile(
                title: const Text("Product name"),
                subtitle: const Text("XL pants"),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                          title: const Text("Date"),
                          subtitle: Text(DateTime.now().toIso8601String())),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                          title: Text("barcode"),
                          subtitle: Text("34523894jk89")),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                          title: Text("Location"),
                          subtitle: Text("Location 1s")),
                    ),
                  ),
                ],
              );
            }),
          ),
        ));
  }
}

class NewAddition extends ConsumerWidget {
  const NewAddition({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      persistentFooterButtons: [
        ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
            },
            child: const Text("Create new product shippment"))
      ],
      appBar: AppBar(title: const Text("New Product Addition")),
      body: Column(
        children: [
          // upload xslx
          ElevatedButton(
              onPressed: () async {
                await FilePicker.platform.pickFiles(allowMultiple: false);
              },
              child: const Text("upload barcodes")),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: "Enter product name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton(
                value: ref.watch(selectedLocation),
                items: const [
                  DropdownMenuItem(value: 0, child: Text("CH433")),
                  DropdownMenuItem(value: 1, child: Text("CH45609")),
                  DropdownMenuItem(value: 2, child: Text("CH430")),
                ],
                onChanged: (selected) {
                  if (selected != null) {
                    ref.watch(selectedLocation.notifier).state = selected;
                  }
                },
                borderRadius: BorderRadius.circular(20)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Enter product quantity",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
        ],
      ),
    );
  }
}

class ViewRequests extends ConsumerWidget {
  const ViewRequests({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Customs Requests"),
        ),
        body: SingleChildScrollView(
          child: Column(
              children: List.generate(
                  20,
                  (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                            child: ExpansionTile(
                          title: const Text("Manual Verification Required "),
                          subtitle:
                              Text("Date: ${DateTime.now().toIso8601String()}"),
                          children: [
                            const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: ListTile(
                                    title: Text("barcode"),
                                    subtitle: Text("98345789"))),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: ListTile(
                                  title: Text("Name"),
                                  subtitle: Text("XL Brand Shirt")),
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                },
                                style: ElevatedButton.styleFrom(
                                    minimumSize:
                                        const Size(double.infinity, 50)),
                                child: const Text("Approve"))
                          ],
                        )),
                      ))),
        ));
  }
}

final _selectedFile = StateProvider((ref) => null);
final selectedLocation = StateProvider((ref) => 0);
