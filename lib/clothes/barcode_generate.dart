import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class GenerateBarCode extends ConsumerWidget {
  const GenerateBarCode({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
          child: SizedBox(
              height: 250, child: SfBarcodeGenerator(value: '83456ng45347'))),
    );
  }
}
