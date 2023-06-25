import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xscan/all/cross_widgets.dart';
import 'package:xscan/brand%20view/models/manufacturer.dart';
import 'package:xscan/manufacturer/screens/pending_approval.dart';

import '../../worker/models/scanmodel.dart';
import '../models/employee.dart';
import '../providers/manu_providers.dart';
import 'location_info.dart';

class ManuDashboard extends ConsumerWidget {
  const ManuDashboard({super.key, required this.data});
  final Manufacturer data;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: 250,
                child: Wallet(
                  accountID: data.accountID,
                  image: data.logoImage,
                  name: data.name,
                  pk: data.privateKey,
                )),
            const SizedBox(
                child: Row(
              children: [
                Expanded(child: Divider()),
                Text("Your company summary"),
                Expanded(child: Divider()),
              ],
            )),
            SizedBox(height: 330, child: _StatisticsView(data)),
            const SizedBox(
                child: Row(
              children: [
                Expanded(child: Divider()),
                Text("Most recently Scanned"),
                Expanded(child: Divider()),
              ],
            )),
            SizedBox(height: 200, child: _MostRecentScanned(data)),
          ],
        ),
      ),
    );
  }
}

class _ActionButtons extends ConsumerWidget {
  const _ActionButtons(this.data);
  final Manufacturer data;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 300,
      height: 200,
      child: ListTile(
        title: Text("welcome: ${data.name}"),
        subtitle: Text(DateTime.now().toString()),
      ),
    );
  }
}

class _StatisticsView extends ConsumerWidget {
  const _StatisticsView(this.manu);
  final Manufacturer manu;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var numberWidget =
        ref.watch(getEmployees(manu.id)).when(data: (List<Employee> data) {
      return Card(
        child: ListTile(
          leading: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.pink.shade300),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.people, color: Colors.white),
            ),
          ),
          tileColor: const Color.fromRGBO(255, 211, 253, 1),
          title: const Text("Number of employees is "),
          trailing: Text(data.length.toString()),
        ),
      );
    }, error: (Object error, StackTrace stackTrace) {
      return const Text("Failed to load");
    }, loading: () {
      return const CircularProgressIndicator.adaptive();
    });
    var todayWidget =
        ref.watch(getThingsProducedToday(manu.id)).when(data: (int data) {
      return Card(
        child: ListTile(
          leading: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromRGBO(112, 63, 23, 1)),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child:
                  Icon(Icons.calendar_view_month_rounded, color: Colors.white),
            ),
          ),
          tileColor: const Color.fromRGBO(255, 231, 211, 1),
          title: const Text("Number of things produced today is "),
          trailing: Text(data.toString()),
        ),
      );
    }, error: (Object error, StackTrace stackTrace) {
      return const Text("Failed to load");
    }, loading: () {
      return const CircularProgressIndicator.adaptive();
    });
    var pendingWidget = ref.watch(getPendingRequestProvider(manu.id)).when(
        data: (List<ScanModel> data) {
      return Card(
        child: ListTile(
          leading: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green.shade400),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.timer, color: Colors.white),
            ),
          ),
          tileColor: const Color.fromRGBO(228, 255, 222, 1),
          onTap: () async {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return ManuPendingApprovalView(
                models: data,
                manufacturer: manu,
              );
            }));
          },
          title: const Text("Items Awaiting your approval:"),
          trailing: Text(data.length.toString()),
        ),
      );
    }, error: (Object error, StackTrace stackTrace) {
      return const Text("Failed to load");
    }, loading: () {
      return const CircularProgressIndicator.adaptive();
    });
    return DecoratedBox(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            todayWidget,
            ListTile(
              leading: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue.shade400),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.house, color: Colors.white),
                ),
              ),
              tileColor: const Color.fromRGBO(208, 255, 254, 1),
              title: const Text("Number of items in productions: "),
              trailing: Text(manu.productions.length.toString()),
            ),
            numberWidget,
            pendingWidget
          ],
        ));
  }
}

class _MostRecentScanned extends ConsumerWidget {
  const _MostRecentScanned(this.data);
  final Manufacturer data;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getAllScannedItems(data.id)).when(
        data: (List<ScanModel> data) {
      return SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(data.length, (index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return LocationInfoView(data: data[index]);
                    }));
                  },
                  tileColor: const Color.fromARGB(255, 176, 237, 254),
                  title: Text("Employee name: ${data[index].scanner!.name}"),
                  subtitle: Text("Product name: ${data[index].productName}"),
                ),
              );
            })
          ],
        ),
      );
    }, error: (Object error, StackTrace stackTrace) {
      return const Center(
        child: Text("Error loading stuff"),
      );
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    });
  }
}
