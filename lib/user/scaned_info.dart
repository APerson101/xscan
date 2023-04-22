import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScannedInfo extends ConsumerWidget {
  const ScannedInfo({super.key, required this.barcode});
  final String barcode;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: const [
          //
        ],
      ),
    );
  }
}
