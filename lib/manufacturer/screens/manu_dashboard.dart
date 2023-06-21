import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 75,
              child: _ActionButtons(data)),
          const Positioned(
              left: 0,
              right: 0,
              top: 100,
              child: Row(
                children: [
                  Expanded(child: Divider()),
                  Text("Your company summary"),
                  Expanded(child: Divider()),
                ],
              )),
          Positioned(
              top: 130,
              left: 0,
              right: 0,
              height: 330,
              child: _StatisticsView(data)),
          const Positioned(
              left: 0,
              right: 0,
              top: 460,
              child: Row(
                children: [
                  Expanded(child: Divider()),
                  Text("Most recently Scanned"),
                  Expanded(child: Divider()),
                ],
              )),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 200,
              child: _MostRecentScanned(data)),
        ],
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
      return ListTile(
        tileColor: const Color.fromRGBO(255, 211, 253, 1),
        title: const Text("Number of employees is "),
        trailing: Text(data.length.toString()),
      );
    }, error: (Object error, StackTrace stackTrace) {
      return const Text("Failed to load");
    }, loading: () {
      return const CircularProgressIndicator.adaptive();
    });
    var todayWidget =
        ref.watch(getThingsProducedToday(manu.id)).when(data: (int data) {
      return ListTile(
        tileColor: const Color.fromRGBO(255, 231, 211, 1),
        title: const Text("Number of things produced today is "),
        trailing: Text(data.toString()),
      );
    }, error: (Object error, StackTrace stackTrace) {
      return const Text("Failed to load");
    }, loading: () {
      return const CircularProgressIndicator.adaptive();
    });
    var pendingWidget = ref.watch(getPendingRequestProvider(manu.id)).when(
        data: (List<ScanModel> data) {
      return ListTile(
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
