import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class Wallet extends ConsumerWidget {
  const Wallet(
      {super.key,
      required this.accountID,
      required this.image,
      required this.name,
      required this.pk});
  final String accountID;
  final String image;
  final String pk;
  final String name;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DecoratedBox(
        decoration: BoxDecoration(
            image: const DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  'assets/images/back.png',
                )),
            borderRadius: BorderRadius.circular(20)),
        child: ClipRect(
            child: BackdropFilter(
                filter: ImageFilter.blur(),
                child: DecoratedBox(
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(0)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 8),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * .3,
                        child: Column(
                          children: [
                            ListTile(
                                title: Text("Hello, $name",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                trailing: CircleAvatar(
                                  radius: 48,
                                  backgroundImage: NetworkImage(image),
                                )),
                            const _BalanceWidget(data: 1000),
                            const SizedBox(
                              height: 10,
                            ),
                            // Row(
                            //   mainAxisAlignment:
                            //       MainAxisAlignment.spaceEvenly,
                            //   children: _IconButtons.values
                            //       .map((e) => _IconButton(
                            //           onTap: () {
                            //             Navigator.of(context).push(
                            //                 MaterialPageRoute(
                            //                     builder: (context) {
                            //               switch (e) {
                            //                 case _IconButtons.buy:
                            //                   return const ViewHistoryView();
                            //                 case _IconButtons.send:
                            //                   return SendHbarView(
                            //                     accountID: accountID,
                            //                     pk: pk,
                            //                   );
                            //                 case _IconButtons.view:
                            //                   return QRWallet(
                            //                       accountID: accountID);
                            //                 default:
                            //                   return const Center(
                            //                       child: Text(
                            //                           "do nothing, this is default"));
                            //               }
                            //             }));
                            //           },
                            //           button: e))
                            //       .toList(),
                            // ),
                          ],
                        ),
                      ),
                    )))));
  }
}

class _BalanceWidget extends ConsumerWidget {
  const _BalanceWidget({required this.data});
  final int data;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DecoratedBox(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text(
                              'NGN: ${ref.watch(balanceProvider)}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40),
                            ),
                          ),
                        ),
                      ]),
                ])));
  }
}

class _IconButton extends ConsumerWidget {
  const _IconButton({required this.onTap, required this.button});
  final void Function()? onTap;
  final _IconButtons button;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GlassContainer(
      borderRadius: BorderRadius.circular(20),
      color: ThemeData.dark().cardColor.withOpacity(.4),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4.0),
          child: GestureDetector(
              onTap: onTap,
              child: Expanded(
                  child: Column(children: [
                DecoratedBox(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: button.icon,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  child: Text(button.text,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                )
              ])))),
    );
  }
}

enum _IconButtons {
  buy(text: "View History", icon: Icon(Icons.history, color: Colors.white)),
  send(text: "Send Hbar", icon: Icon(Icons.send, color: Colors.white)),
  view(text: "View Address", icon: Icon(Icons.qr_code, color: Colors.white));

  const _IconButtons({
    required this.text,
    required this.icon,
  });
  final String text;
  final Widget icon;
}

final balanceProvider = StateProvider((ref) => 10000);
