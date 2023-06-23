import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xscan/user/providers/market_place_provider.dart';

class UserAssets extends ConsumerWidget {
  const UserAssets({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getUserFromIdProvider(id)).when(
        data: (user) {
          return ref.watch(loadUserAssetsProvider).when(
              data: (assets) {
                return Scaffold(
                    appBar: AppBar(
                      centerTitle: true,
                      title: const Text("Your Assets"),
                    ),
                    body: SafeArea(
                        child: GridView.count(
                      crossAxisCount: 1,
                      children: [
                        ...assets
                            .map((e) => GestureDetector(
                                  onTap: () async {
                                    // show more options
                                    await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content:
                                                const Text("put up for sale?"),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    //
                                                    ref.watch(
                                                        putAssetForSaleProvider(
                                                            user,
                                                            10,
                                                            e.tranfer
                                                                .barcodeID));
                                                  },
                                                  child: const Text("yes!")),
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text("no")),
                                            ],
                                          );
                                        });
                                  },
                                  child: Card(
                                    child: ExpansionTile(
                                      title: Text(e.productName),
                                      children: const [Text("item more info")],
                                    ),
                                  ),
                                ))
                            .toList()
                      ],
                    )));
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              error: (error, stackTrace) {
                debugPrintStack(stackTrace: stackTrace);
                return const Center(child: Text("Error loading assets data"));
              });
        },
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        error: (error, stackTrace) {
          debugPrintStack(stackTrace: stackTrace);
          return const Center(
            child: Text("Failed to load user details"),
          );
        });
  }
}
