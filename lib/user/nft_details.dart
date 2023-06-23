import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'providers/market_place_provider.dart';

class ShowNFTDetails extends ConsumerWidget {
  ShowNFTDetails({super.key, required this.card});
  final ItemForSale card;
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var images = List.generate(4, (index) => const FlutterLogo());
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .6,
                child: PageView.builder(
                  itemCount: images.length,
                  controller: controller,
                  itemBuilder: (_, index) {
                    return DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: SizedBox(height: 280, child: images[index]));
                  },
                ),
              ),
              SmoothPageIndicator(
                  controller: controller,
                  count: images.length,
                  effect: const WormEffect(
                      dotHeight: 16,
                      dotWidth: 16,
                      type: WormType.thinUnderground)),
              ListTile(
                title: Text(card.productName),
                trailing: Text(card.price.toString()),
                subtitle: Text(card.itemBarcode),
              ),

              // item history
              ExpansionTile(
                title: const Text('Ownership History'),
                children: card.itemHistory.owners
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                              child: ListTile(
                            title: Text(e.accountID),
                            trailing: Text(e.amountPaid),
                          )),
                        ))
                    .toList(),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {},
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 65)),
                  child: const Text("Buy"),
                ),
              )
            ],
          ),
        ));
  }
}

class _NetWorkImages extends ConsumerWidget {
  const _NetWorkImages(this.card);
  final ItemForSale card;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Placeholder();
  }
}
