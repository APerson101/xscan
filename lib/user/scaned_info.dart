import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../brand view/helpers/db.dart';

class ScannedInfo extends ConsumerWidget {
  const ScannedInfo({super.key, required this.barcode});
  final String barcode;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ref.watch(fetchInfo(barcode)).when(
              data: (data) {
                return Text(data);
              },
              error: (er, st) => const Text("error"),
              loading: () => const CircularProgressIndicator.adaptive())
        ],
      ),
    );
  }
}

final fetchInfo = FutureProvider.family<String, String>((ref, barcode) async {
  var db = GetIt.I<DataBase>();
  var fileID = await db.getFileFromBarcode(barcode);
  return await db.getFileContent(fileID);
});
