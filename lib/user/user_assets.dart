import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:xscan/manufacturer/providers/manu_providers.dart';
import 'package:xscan/user/providers/market_place_provider.dart';

class UserAssets extends ConsumerWidget {
  const UserAssets({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getUserFromIdProvider(id)).when(
        data: (user) {
          return ref.watch(loadUserAssetsProvider(user.accountID)).when(
              data: (assets) {
                return Scaffold(
                    appBar: AppBar(
                      centerTitle: true,
                      title: const Text("Your Assets"),
                    ),
                    body: SafeArea(
                        child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ...assets
                              .map((e) => GestureDetector(
                                    onTap: () async {
                                      // show more options
                                      await showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: const Text(
                                                  "put up for sale?"),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      //
                                                      ref.watch(
                                                          putAssetForSaleProvider(
                                                              user,
                                                              10,
                                                              e.tranfer
                                                                  .barcodeID,
                                                              e.tranfer
                                                                  .receiptID));
                                                    },
                                                    child: const Text("yes!")),
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text("no")),
                                              ],
                                            );
                                          });
                                    },
                                    child: Card(
                                      child: ExpansionTile(
                                        title: Text(e.productName),
                                        children: [
                                          Card(
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  ...e.imageLinks
                                                      .map((i) => Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child:
                                                                Image.network(
                                                                    i,
                                                                    width: 200,
                                                                    height:
                                                                        200),
                                                          ))
                                                      .toList()
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Card(
                                                child: ListTile(
                                                    leading: DecoratedBox(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          color: Colors.black),
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        child: Icon(
                                                          Icons.money,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    title: const Text(
                                                        "Cost (hbar)"),
                                                    subtitle: Text(e
                                                        .tranfer.cost
                                                        .toString()))),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Card(
                                                child: ListTile(
                                                    leading: DecoratedBox(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          color: Colors.grey),
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        child: Icon(
                                                          Icons.abc,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    title: const Text(
                                                        "Brand Name"),
                                                    subtitle: ref
                                                        .watch(getBrandProvider(
                                                            e.tranfer.brandID))
                                                        .when(
                                                            data: (value) =>
                                                                Text(
                                                                    value.name),
                                                            error: (er, st) =>
                                                                const Text(
                                                                    "Failed to get name"),
                                                            loading: () =>
                                                                const CircularProgressIndicator
                                                                    .adaptive()))),
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Card(
                                                  child: ListTile(
                                                      leading: DecoratedBox(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            color: Colors
                                                                .greenAccent),
                                                        child: const Padding(
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          child: Icon(
                                                              Icons
                                                                  .calendar_month,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      title: const Text(
                                                          "Date Purchased"),
                                                      subtitle: Text(
                                                          DateFormat.yMMMEd()
                                                              .format(e.tranfer
                                                                  .time))))),
                                          const Row(children: [
                                            Expanded(child: Divider()),
                                            Text("Onwership history"),
                                            Expanded(child: Divider()),
                                          ]),
                                          ...e.ownership.owners.map((e) =>
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Card(
                                                    child: ListTile(
                                                  leading: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color:
                                                            Colors.amberAccent),
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      child: Icon(Icons.person,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  title: Text(
                                                      "Owner account:${e.accountID}"),
                                                  subtitle: Text(
                                                      "Amount paid(hbar): ${e.amountPaid}"),
                                                  trailing: Text(
                                                      "Date: ${DateFormat.yMMMEd().format(e.purchased)}"),
                                                )),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList()
                        ],
                      ),
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
