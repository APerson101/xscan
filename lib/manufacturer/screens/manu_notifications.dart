import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../brand view/models/brand_manufacturer.dart';
import '../../brand view/models/manufacturer.dart';
import '../providers/accept_offer_provider.dart';

class ManuNotifications extends ConsumerWidget {
  const ManuNotifications(
      {super.key, required this.data, required this.notifications});
  final Manufacturer data;
  final List<BrandManufaturer> notifications;
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

    return SingleChildScrollView(
      child: Column(
        children: notifications.map((e) {
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                                    BorderRadius.circular(20))),
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
      ),
    );
  }
}

final quotationSentProvider = StateProvider((ref) => 0);
