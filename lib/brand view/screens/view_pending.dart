import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xscan/worker/models/scanmodel.dart';

import '../models/brand.dart';
import '../providers/brand_providers.dart';

class BrandPendingView extends ConsumerWidget {
  const BrandPendingView({super.key, required this.data, required this.brand});
  final List<ScanModel> data;
  final Brand brand;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(approveProductStateProvider, (pr, nx) {
      ref.watch(approveProductStateProvider).when(
          data: (state) {
            if (state == ApproveProductStateEnum.successful) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Success")));
            }
          },
          error: (er, st) {},
          loading: () {});
    });
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ...data.map((item) => SizedBox(
                height: 100,
                child: ListTile(
                    onTap: () async {
                      //
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: const Text("Approve?"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      ref
                                          .watch(approveProductStateProvider
                                              .notifier)
                                          .approveProductFromManu(
                                              item.barcode!, brand);
                                    },
                                    child: const Text("Ok!")),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Cancel"))
                              ],
                            );
                          });
                    },
                    title: Text(item.productName!),
                    subtitle: Text(item.timeAdded.toString()),
                    trailing: ref
                        .watch(
                            getBusinessNameFromString(item.scanner!.businessID))
                        .when(
                            data: (data) {
                              return Text(data);
                            },
                            error: (er, st) => const Text("ERROR"),
                            loading: () => const Text("..."))),
              ))
        ],
      ),
    );
  }
}
