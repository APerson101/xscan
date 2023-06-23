import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xscan/user/providers/market_place_provider.dart';

import 'nft_details.dart';

class MarketPlaceView extends ConsumerWidget {
  const MarketPlaceView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text("Market place")),
        body: SafeArea(
            child: Column(children: [
          // Search bar
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: _SearchBar(),
          ),
          // items for sale: /**
          //pics
          //seller stars
          //comments
          //price
          //seller image */
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
                                        MaterialPageRoute(builder: (context) {
                                      return ShowNFTDetails(card: e);
                                    }));
                                  },
                                  child: Card(
                                    child: Stack(children: [
                                      e.productImages.isNotEmpty
                                          ? CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  e.productImages[0]))
                                          : const FlutterLogo(),
                                      Positioned(
                                          bottom: 0,
                                          height: 50,
                                          left: 0,
                                          right: 0,
                                          child: SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: ListTile(
                                                title: Text(e.productName),
                                                trailing:
                                                    Text(e.price.toString()),
                                                subtitle: Text(
                                                    'item code: ${e.itemBarcode}')),
                                          )),
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
  }
}

class _SearchBar extends ConsumerWidget {
  const _SearchBar();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Search for anything',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }
}
