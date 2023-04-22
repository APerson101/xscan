import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
            }
          },
          error: (Object error, StackTrace stackTrace) {},
          loading: () {});
    });
    return Scaffold(
      appBar: AppBar(),
      body: Column(
          children: models.map((e) {
        return GestureDetector(
          onTap: () async {
            await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: const Text("Approve?"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            ref
                                .watch(manuApprovePendingProvider.notifier)
                                .approvePending(e, e.barcode!, manufacturer);
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
          child: DecoratedBox(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30)),
              child: SizedBox(
                height: 100,
                child: Column(
                  children: [
                    Text(e.brandName!),
                    Text(e.scanner!.name),
                    Text(e.productName!),
                    Text(e.timeAdded.toString()),
                    Text(e.barcode!),
                  ],
                ),
              )),
        );
      }).toList()),
    );
  }
}
