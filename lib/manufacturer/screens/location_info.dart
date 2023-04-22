import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xscan/worker/models/scanmodel.dart';

class LocationInfoView extends ConsumerWidget {
  const LocationInfoView({super.key, required this.data});
  final ScanModel data;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("${data.barcode}"),
          Text("${data.brandName}"),
          Text("${data.id}"),
          Text("${data.productName}"),
          Text(data.timeAdded.toString()),
        ],
      ),
    );
  }
}
