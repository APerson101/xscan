import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManufacturerInfoView extends ConsumerWidget {
  const ManufacturerInfoView({super.key, required this.manufacturerID});
  final String manufacturerID;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: const Placeholder(),
    );
  }
}
