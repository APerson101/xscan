import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:xscan/brand%20view/models/manufacturer.dart';
import 'package:xscan/worker/models/scanmodel.dart';

import '../providers/manu_providers.dart';

class ManuPendingApprovalView extends ConsumerWidget {
  const ManuPendingApprovalView(
      {super.key, required this.models, required this.manufacturer});
  final List<ScanModel> models;
  final Manufacturer manufacturer;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(manuApprovePendingProvider, (previous, next) {
      ref.watch(manuApprovePendingProvider).when(
          data: (status) {
            if (status == ManuApprovePendingEnum.success) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Successful!")));
              Navigator.of(context).pop();
              ref.invalidate(getPendingRequestProvider);
            }
          },
          error: (Object error, StackTrace stackTrace) {},
          loading: () {});
    });
    return Scaffold(
      appBar: AppBar(),
      body: Column(
          children: models.map((e) {
        return DecoratedBox(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child: ExpansionTile(
              title: Card(
                  child: ListTile(
                      title: const Text("Scanned item"),
                      leading: TextButton(
                          onPressed: () async {
                            await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: const Text("Approve?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            ref
                                                .watch(
                                                    manuApprovePendingProvider
                                                        .notifier)
                                                .approvePending(e, e.barcode!,
                                                    manufacturer);
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("yes")),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("no")),
                                    ],
                                  );
                                });
                          },
                          child: const Text("accept")))),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      child: ListTile(
                    leading: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.teal),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.business,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    subtitle: Text(e.brandName!),
                    title: const Text("Brand name"),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      child: ListTile(
                          leading: DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.purple.shade300),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          subtitle: Text(e.scanner!.name),
                          title: const Text('"Employee name'))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      leading: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.teal),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.abc,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      subtitle: Text(e.productName!),
                      title: const Text("Product name"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                        leading: DecoratedBox(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.purple.shade300),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.calendar_month,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        title: const Text("Date Added"),
                        subtitle:
                            Text(DateFormat.yMMMEd().format(e.timeAdded!))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      leading: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.teal),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.qr_code,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      subtitle: Text(e.barcode!),
                      title: const Text("Scanned code"),
                    ),
                  ),
                ),
              ],
            ));
      }).toList()),
    );
  }
}
