import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:xscan/all/providers/all_providers.dart';

import 'cross_widgets.dart';

class SendHbarView extends ConsumerWidget {
  SendHbarView({super.key, required this.accountID, required this.pk});
  final TextEditingController receiverController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final String accountID;
  final String pk;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      persistentFooterButtons: [
        Card(
          child: ListTile(
            onTap: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Sending.....")));

              if (formkey.currentState!.validate()) {
                ref.watch(sendHbarToReceiverProvider(receiverController.text,
                    accountID, pk, int.parse(amountController.text)));
                ref.invalidate(GetHbarBalanceProvider(accountID));
                Navigator.of(context).pop();
              }
            },
            title: const Text("confirm transfer"),
            leading: const Icon(Icons.send),
          ),
        )
      ],
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formkey,
            child: Column(children: [
              TextFormField(
                controller: receiverController,
                decoration: InputDecoration(
                    hintText: 'Enter receiver address',
                    suffix: IconButton(
                        onPressed: () async {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return Scaffold(
                              appBar: AppBar(title: const Text('Scanner')),
                              body: MobileScanner(
                                onDetect: (capture) {
                                  final List<Barcode> barcodes =
                                      capture.barcodes;
                                  for (final barcode in barcodes) {
                                    debugPrint(
                                        'Barcode found! ${barcode.rawValue}');
                                    barcode.rawValue != null
                                        ? receiverController.text =
                                            barcode.rawValue!
                                        : "nothing received";
                                  }
                                },
                              ),
                            );
                          }));
                        },
                        icon: const Icon(Icons.qr_code)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(height: 75),
              TextFormField(
                controller: amountController,
                validator: (amountEntered) {
                  if (amountEntered != null) {
                    if (int.tryParse(amountController.text) != null) {
                      if (int.tryParse(amountController.text)! >
                          ref.watch(balanceProvider)) {
                        return 'Amount greater than balance';
                      }
                      return 'Enter valid integer';
                    }
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter amount',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
