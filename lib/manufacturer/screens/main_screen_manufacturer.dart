import 'package:badges/badges.dart' as badges;
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
          return ManuDashboard(data: data.$1);
        case 1:
          return ManuNotifications(
            data: data.$1,
            notifications: data.$2,
            escrows: data.$3,
          );
        case 2:
          return PeopleView(data: data.$1);
        case 3:
          return ManuProfile(data: data.$1);
        default:
          return const Placeholder();
      }
    }, error: (er, st) {
      debugPrintStack(stackTrace: st);
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
          Widget icon = const Icon(Icons.abc);
          String label = '';
          switch (e) {
            case _ManuBottomNavBar.dashboard:
              icon = const Icon(Icons.dashboard);
              label = 'Dashbaord';
              break;
            case _ManuBottomNavBar.pending:
              icon = badges.Badge(
                  showBadge: ref.watch(notificationsNumber) > 0,
                  badgeContent: Text(ref.watch(notificationsNumber).toString()),
                  child: const Icon(Icons.notifications));
              label = 'Notifications';
              break;
            case _ManuBottomNavBar.profile:
              icon = const Icon(Icons.person);
              label = 'Profile';
              break;
            case _ManuBottomNavBar.people:
              icon = const Icon(Icons.people);
              label = 'Employees';
              break;
          }
          return BottomNavigationBarItem(icon: icon, label: label);
        }).toList());
  }
}

enum _ManuBottomNavBar { dashboard, pending, people, profile }

final _selectedIndex = StateProvider((ref) => 0);
final notificationsNumber = StateProvider((ref) => 0);
