import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xscan/manufacturer/providers/manu_providers.dart';
import 'package:xscan/user/providers/market_place_provider.dart';

import 'nft_details.dart';

class MarketPlaceView extends ConsumerWidget {
  const MarketPlaceView({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getUserFromIdProvider(id)).when(
        data: (user) {
          return Scaffold(
              appBar:
                  AppBar(centerTitle: true, title: const Text("Market place")),
              body: SafeArea(
                  child: Column(children: [
                ref.watch(marketPlaceProvider).when(
                    data: (data) {
                      List<ItemForSale> items = data;
                      return Expanded(
                          child: GridView.count(
                              crossAxisCount: 2,
                              children: items
                                  .map((e) => GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return ShowNFTDetails(
                                                card: e, user: user);
                                          }));
                                        },
                                        child: Card(
                                          child: Stack(children: [
                                            e.productImages.isNotEmpty
                                                ? Positioned(
                                                    left: 0,
                                                    right: 0,
                                                    top: 0,
                                                    child: Image.network(
                                                      e.productImages[0],
                                                      width: 150,
                                                      height: 150,
                                                    ),
                                                  )
                                                : const FlutterLogo(size: 48),
                                            Positioned(
                                                bottom: 1,
                                                height: 60,
                                                left: 0,
                                                right: 0,
                                                child: SizedBox(
                                                    height: 50,
                                                    width: 50,
                                                    child: ListTile(
                                                      title:
                                                          Text(e.productName),
                                                      trailing: Text(
                                                          e.price.toString()),
                                                      subtitle: ref
                                                          .watch(
                                                              getBrandProvider(e
                                                                  .itemHistory
                                                                  .brandID))
                                                          .when(
                                                              data: (data) =>
                                                                  Text(data
                                                                      .name),
                                                              error: (er, st) {
                                                                debugPrintStack(
                                                                    stackTrace:
                                                                        st);
                                                                return const Center(
                                                                    child: Text(
                                                                        "Failed to fetch"));
                                                              },
                                                              loading: () =>
                                                                  const CircularProgressIndicator
                                                                      .adaptive()),
                                                    ))),
                                          ]),
                                        ),
                                      ))
                                  .toList()));
                    },
                    error: ((error, stackTrace) {
                      debugPrintStack(stackTrace: stackTrace);
                      return const Center(child: Text("Failed to load"));
                    }),
                    loading: () => const CircularProgressIndicator.adaptive())
              ])));
        },
        error: (er, st) {
          debugPrintStack(stackTrace: st);
          return const Center(
            child: Text("Error"),
          );
        },
        loading: () => const CircularProgressIndicator.adaptive());
  }
}
