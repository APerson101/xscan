import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xscan/brand%20view/providers/notifications_provider.dart';

import '../models/brand.dart';

class BrandNotificationsView extends ConsumerWidget {
  const BrandNotificationsView({super.key, required this.brand});
  final Brand brand;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getNotificationsProvider(brand.id)).when(data: (data) {
      return Scaffold(
          body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...data.map((q) => ListTile(
                    title: Text(q.amount.toString()),
                    subtitle: Text(q.manu.name),
                    trailing: TextButton(
                        onPressed: () async {
                          // accept: begin escrow transfer
                          ref.watch(
                              AcceptQuotationProvider(q, brand, q.transaction));
                        },
                        child: const Text("Accept")),
                  ))
            ],
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
