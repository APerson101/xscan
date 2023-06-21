import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:xscan/brand%20view/helpers/db.dart';

class TestPageView extends ConsumerWidget {
  const TestPageView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
                onPressed: () async {
                  // await GetIt.I<DataBase>().createUser();
                  // await GetIt.I<DataBase>().createBrand();
                  // await GetIt.I<DataBase>().createManufacturers();
                  // await GetIt.I<DataBase>().createPartnerships();
                  // await GetIt.I<DataBase>().createEmployees();
                  await GetIt.I<DataBase>().addScannedItem('abc123');
                  await GetIt.I<DataBase>().addScannedItem('abc123');
                  await GetIt.I<DataBase>().addScannedItem('abc123');
                  await GetIt.I<DataBase>().getBarcodescanhistory('abc123');
                },
                child: const Text("Insha Allah this would work first try")),
            ElevatedButton(
                onPressed: () async {
                  /*
                  var businessaccount =
                      await GetIt.I<DataBase>().createAccount();
                  var businessID = businessaccount['accountID'];
                  var businessKey = businessaccount['privateKey'];
                  var senderAccount = await GetIt.I<DataBase>().createAccount();
                  var senderID = senderAccount['accountID'];
                  var senderKey = senderAccount['privateKey'];
                  var receiverAccount =
                      await GetIt.I<DataBase>().createAccount();
                  var receiverID = receiverAccount['accountID'];
                  var receiverKey = receiverAccount['privateKey'];
                  var manufacturerAccount =
                      await GetIt.I<DataBase>().createAccount();
                  var manuID = receiverAccount['accountID'];
                  var manuKey = receiverAccount['privateKey'];*/

                  // var fileID = await GetIt.I<DataBase>()
                  //     .saveUpdateToFile(manuKey, 'filecreatedsaved,');
                  // await GetIt.I<DataBase>()
                  //     .appendFile(manuKey, fileID, 'manuUpdated,');
                  // await GetIt.I<DataBase>().getFileContent(fileID);

                  /*  var nftID = await GetIt.I<DataBase>()
                      .createNFTReceipt('brand1', 'BND1', senderID);
                  await GetIt.I<DataBase>().transferNFTOwnership(
                      nftID, senderID, receiverID, senderKey);*/
                },
                child: const Text("Hedera stuff"))
          ]),
        ),
      ),
    );
  }
}
