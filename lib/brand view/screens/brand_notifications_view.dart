import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:xscan/all/cross_widgets.dart';
import 'package:xscan/brand%20view/providers/notifications_provider.dart';

import '../models/brand.dart';

class BrandNotificationsView extends ConsumerWidget {
  const BrandNotificationsView({super.key, required this.brand});
  final Brand brand;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getNotificationsProvider(brand.id)).when(data: (data) {
      return Scaffold(
          appBar: AppBar(
              centerTitle: true,
              title: const Text("Manufacturer escrow notifications")),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Row(children: [
                      Expanded(child: Divider()),
                      Text("Business history"),
                      Expanded(child: Divider()),
                    ]),
                    ...data.$2.map((q) => q == null
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 15),
                            child: Card(
                              child: ExpansionTile(
                                title: Text(
                                    'Amount (NGN): ${q.amount.toString()}'),
                                subtitle: Text(
                                    'Manufacturer name: ${q.businessName}'),
                                trailing: Text(q.status),
                                children: [
                                  // Escrow information
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                        child: ListTile(
                                      leading: DecoratedBox(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.greenAccent),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(Icons.calendar_view_month,
                                              color: Colors.white),
                                        ),
                                      ),
                                      title: const Text("Date created"),
                                      subtitle: Text(q.createdAt!.format()),
                                    )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                        child: ListTile(
                                      leading: DecoratedBox(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.amberAccent),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(Icons.abc,
                                              color: Colors.white),
                                        ),
                                      ),
                                      title: const Text("Quantity to Produce"),
                                      subtitle: Text(q.quantity),
                                    )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                        child: ListTile(
                                      leading: DecoratedBox(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.blueAccent),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(Icons.numbers,
                                              color: Colors.white),
                                        ),
                                      ),
                                      title: const Text("Notes"),
                                      subtitle: Text(q.notes),
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    const Row(children: [
                      Expanded(child: Divider()),
                      Text("Business history"),
                      Expanded(child: Divider()),
                    ]),
                    ...data.$1.map((q) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 15),
                          child: Card(
                            child: ExpansionTile(
                              title:
                                  Text('Amount (NGN): ${q.amount.toString()}'),
                              subtitle:
                                  Text('Manufacturer name: ${q.manu.name}'),
                              trailing: TextButton(
                                  onPressed: () async {
                                    await ref.watch(acceptQuotationProvider(
                                            q, brand, q.transaction)
                                        .future);
                                    ref.watch(balanceProvider.notifier).state =
                                        5000;
                                  },
                                  child: const Text("Accept")),
                              children: [
                                // transaction information
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                      child: ListTile(
                                    leading: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.greenAccent),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(Icons.calendar_view_month,
                                            color: Colors.white),
                                      ),
                                    ),
                                    title: const Text("Date created"),
                                    subtitle: Text(DateFormat.yMMMEd()
                                        .format(q.transaction.dateCreated)),
                                  )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                      child: ListTile(
                                    leading: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.amberAccent),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(Icons.abc,
                                            color: Colors.white),
                                      ),
                                    ),
                                    title: const Text("Product Name"),
                                    subtitle: Text(q.transaction.product.name),
                                  )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                      child: ListTile(
                                    leading: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.blueAccent),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(Icons.numbers,
                                            color: Colors.white),
                                      ),
                                    ),
                                    title:
                                        const Text("Quantity to be produced"),
                                    subtitle:
                                        Text(q.transaction.quantity.toString()),
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ));
    }, error: (error, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      return const Center(child: Text("ERROR, FAILED TO LOAD"));
    }, loading: () {
      return const Center(child: CircularProgressIndicator.adaptive());
    });
  }
}
