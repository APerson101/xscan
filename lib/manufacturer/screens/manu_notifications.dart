import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xscan/brand%20view/models/product.dart';

import '../../brand view/models/brand.dart';
import '../../brand view/models/manufacturer.dart';
import '../providers/accept_offer_provider.dart';
import '../providers/manu_providers.dart';

class ManuNotifications extends ConsumerWidget {
  const ManuNotifications({super.key, required this.data});
  final Manufacturer data;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(acceptOfferProvider, (previous, next) {
      ref.watch(acceptOfferProvider).when(data: (status) {
        if (status == AcceptOfferCreationState.success) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Success")));
        }
      }, error: (Object error, StackTrace stackTrace) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("ERROR")));
      }, loading: () {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("LOADING")));
      });
    });
    return ref.watch(getPendingRequests(data.id)).when(data: (requests) {
      return SingleChildScrollView(
        child: Column(
          children: requests.map((e) {
            var brandName =
                ref.watch(getBrand(e.brandID)).when(data: (Brand data) {
              return data.name;
            }, error: (Object error, StackTrace stackTrace) {
              return 'error';
            }, loading: () {
              return '...';
            });
            var productName =
                ref.watch(getProduct(e.productID)).when(data: (Product? data) {
              return data?.name ?? "";
            }, error: (Object error, StackTrace stackTrace) {
              return 'error';
            }, loading: () {
              return '...';
            });

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(e.dateCreated.toString()),
                    trailing: Text("${e.quantity}"),
                    leading: Text(brandName),
                    subtitle: Text(productName),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      var amountText = TextEditingController();
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Material(
                              child: Column(
                                children: [
                                  SizedBox(
                                      height: 200,
                                      width: 200,
                                      child: TextFormField(
                                        controller: amountText,
                                        decoration: InputDecoration(
                                            labelText: 'Enter amount',
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                      )),
                                  ElevatedButton(
                                      onPressed: () async {
                                        ref.watch(sendQuotationProvider(
                                            int.parse(amountText.text),
                                            e.brandID,
                                            data,
                                            e));
                                      },
                                      child: const Text("confirm"))
                                ],
                              ),
                            );
                          });

                      // ref
                      //     .watch(acceptOfferProvider.notifier)
                      //     .acceptOffer(e.id, e.product, e.manufacturerID);
                    },
                    child: const Text("Send  quotation"))
              ],
            );
          }).toList(),
        ),
      );
    }, error: (er, st) {
      return const Center(
        child: Text("Failed to load pending requests"),
      );
    }, loading: () {
      return const CircularProgressIndicator.adaptive();
    });
  }
}
