import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xscan/manufacturer/screens/manu_dashboard.dart';
import 'package:xscan/manufacturer/screens/manu_profile.dart';
import 'package:xscan/manufacturer/screens/people_view.dart';

import '../providers/manu_providers.dart';
import 'manu_notifications.dart';

class MainScreenManufacturer extends ConsumerWidget {
  const MainScreenManufacturer({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox.expand(child: _MainBody(id)),
        bottomNavigationBar: const _BottomNavBar(),
      ),
    );
  }
}

class _MainBody extends ConsumerWidget {
  const _MainBody(this.id);
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(loadManuInfoProvider(id)).when(data: (data) {
      var index = ref.watch(_selectedIndex);
      switch (index) {
        case 0:
          return ManuDashboard(data: data);
        case 1:
          return ManuNotifications(data: data);
        case 2:
          return PeopleView(data: data);
        case 3:
          return ManuProfile(data: data);
        default:
          return const Placeholder();
      }
    }, error: (er, st) {
      return const Center(child: Text("Failed to load"));
    }, loading: () {
      return const Center(child: CircularProgressIndicator.adaptive());
    });
  }
}

class _BottomNavBar extends ConsumerWidget {
  const _BottomNavBar();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: ref.watch(_selectedIndex),
        onTap: (index) {
          ref.watch(_selectedIndex.notifier).state = index;
        },
        items: _ManuBottomNavBar.values.map((e) {
          IconData icon = Icons.abc;
          String label = '';
          switch (e) {
            case _ManuBottomNavBar.dashboard:
              icon = Icons.dashboard;
              label = 'Dashbaord';
              break;
            case _ManuBottomNavBar.pending:
              icon = Icons.notifications;
              label = 'Notifications';
              break;
            case _ManuBottomNavBar.profile:
              icon = Icons.person;
              label = 'Profile';
              break;
            case _ManuBottomNavBar.people:
              icon = Icons.people;
              label = 'Employees';
              break;
          }
          return BottomNavigationBarItem(icon: Icon(icon), label: label);
        }).toList());
  }
}

enum _ManuBottomNavBar { dashboard, pending, people, profile }

final _selectedIndex = StateProvider((ref) => 0);
