import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xscan/worker/view/worker_history.dart';
import 'package:xscan/worker/view/worker_profile.dart';

import '../providers/employee_provider.dart';
import 'worker_dashboard.dart';

class WorkerMain extends ConsumerWidget {
  const WorkerMain({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getEmployeeFromID(id)).when(data: (employee) {
      var currentView = ref.watch(_selectedIndex);

      return Scaffold(
        appBar: AppBar(),
        body: currentView == 1
            ? WorkerProfileView(employee: employee)
            : currentView == 2
                ? WorkerHistory(employee: employee)
                : WorkerDashboardView(employee: employee),
        bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.blue,
            onTap: (index) {
              ref.watch(_selectedIndex.notifier).state = index;
            },
            currentIndex: currentView,
            items: _BarItems.values.map((e) {
              Widget icon = const Icon(Icons.dashboard);
              String label = "";
              switch (e) {
                case _BarItems.home:
                  label = "Home";
                  break;
                case _BarItems.history:
                  icon = const Icon(Icons.history);
                  label = 'History';
                  break;
                case _BarItems.profile:
                  icon = const Icon(Icons.person);
                  label = "Profile";
                  break;
                default:
              }
              return BottomNavigationBarItem(icon: icon, label: label);
            }).toList()),
      );
    }, error: (Object error, StackTrace stackTrace) {
      return const Text("ERROR");
    }, loading: () {
      return const CircularProgressIndicator.adaptive();
    });
  }
}

enum _BarItems { home, profile, history }

final _selectedIndex = StateProvider((ref) => 0);
