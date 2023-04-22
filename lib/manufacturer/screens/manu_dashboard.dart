import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xscan/brand%20view/models/manufacturer.dart';
import 'package:xscan/manufacturer/screens/add_new_location.dart';
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
              height: 150,
              child: _ActionButtons(data)),
          Positioned(
              top: 150,
              left: 0,
              right: 0,
              height: 150,
              child: _StatisticsView(data)),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 250,
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
    return Row(
      children: [
        SizedBox(
          width: 300,
          height: 200,
          child: ListTile(
            title: Text("welcome ${data.name}"),
            subtitle: Text(DateTime.now().toString()),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return AddNewManuLocation(data: data);
              }));
            },
            child: const Text("Add new Employee"))
      ],
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
      return Text("Number of employees is ${data.length}");
    }, error: (Object error, StackTrace stackTrace) {
      return const Text("Failed to load");
    }, loading: () {
      return const CircularProgressIndicator.adaptive();
    });
    var todayWidget =
        ref.watch(getThingsProducedToday(manu.id)).when(data: (int data) {
      return Text("Number of things produced today is $data");
    }, error: (Object error, StackTrace stackTrace) {
      return const Text("Failed to load");
    }, loading: () {
      return const CircularProgressIndicator.adaptive();
    });
    var pendingWidget = ref.watch(getPendingRequestProvider(manu.id)).when(
        data: (List<ScanModel> data) {
      return ListTile(
          onTap: () async {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return ManuPendingApprovalView(
                models: data,
                manufacturer: manu,
              );
            }));
          },
          title: Text("Items Awaiting your approval: ${data.length}"));
    }, error: (Object error, StackTrace stackTrace) {
      return const Text("Failed to load");
    }, loading: () {
      return const CircularProgressIndicator.adaptive();
    });
    return DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(30)),
        child: Column(
          children: [
            todayWidget,
            Text("Number of items in productions: ${manu.productions.length}"),
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
                  tileColor: Colors.grey.shade50,
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
