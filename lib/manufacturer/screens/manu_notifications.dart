import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../brand view/models/brand_manufacturer.dart';
import '../../brand view/models/manufacturer.dart';
import '../../models/Escrow.dart';
import '../providers/accept_offer_provider.dart';

class ManuNotifications extends ConsumerWidget {
  const ManuNotifications(
      {super.key,
      required this.data,
      required this.notifications,
      required this.escrows});
  final Manufacturer data;
  final List<BrandManufaturer> notifications;
  final List<Escrow?> escrows;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(quotationSentProvider, (previous, next) {
      if (previous != next) {
        // show stuff
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Quotation successfully sent")));
        Navigator.of(context).pop();
      }
    });

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(children: [
          const Row(children: [
            Expanded(child: Divider()),
            Text("Required Attention"),
            Expanded(child: Divider()),
          ]),
          ...notifications.map((e) {
            var brandName = e.product.brandOwner;

            var productName = e.product.name;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      subtitle: Text(DateFormat.yMMMEd().format(e.dateCreated)),
                      trailing: Text("Quantity: ${e.quantity}"),
                      leading: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.red),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.notifications),
                        ),
                      ),
                      title: Text(
                          'Product name: $productName\nBrand name: $brandName'),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      var amountText = TextEditingController();
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Scaffold(
                              appBar: AppBar(),
                              persistentFooterButtons: [
                                ElevatedButton(
                                  onPressed: () async {
                                    ref.watch(sendQuotationProvider(
                                        int.parse(amountText.text),
                                        e.brandID,
                                        data,
                                        e));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      minimumSize:
                                          const Size(double.infinity, 60)),
                                  child: const Text("confirm"),
                                )
                              ],
                              body: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Center(
                                    child: SizedBox(
                                        height: 200,
                                        width: 400,
                                        child: TextFormField(
                                          controller: amountText,
                                          decoration: InputDecoration(
                                              labelText: 'Enter amount',
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20))),
                                        )),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    child: const Text("Send  quotation"))
              ],
            );
          }).toList(),
          const Row(children: [
            Expanded(child: Divider()),
            Text("Business history"),
            Expanded(child: Divider()),
          ]),
          ...escrows.map((q) => q == null
              ? Container()
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                  child: Card(
                    child: ExpansionTile(
                      title: Text('Amount (NGN): ${q.amount.toString()}'),
                      subtitle: Text('Brand name: ${q.businessName}'),
                      trailing: Text(q.status),
                      children: [
                        // Escrow information
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                              child: ListTile(
                            leading: DecoratedBox(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
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
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.amberAccent),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.abc, color: Colors.white),
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
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.blueAccent),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.numbers, color: Colors.white),
                              ),
                            ),
                            title: const Text("Notes"),
                            subtitle: Text(q.notes),
                          )),
                        ),
                      ],
                    ),
                  ),
                ))
        ]),
      ),
    );
  }
}

final quotationSentProvider = StateProvider((ref) => 0);
