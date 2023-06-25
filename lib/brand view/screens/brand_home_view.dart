import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xscan/brand%20view/providers/brand_providers.dart';
import 'package:xscan/brand%20view/screens/products_view.dart';
import 'package:xscan/brand%20view/screens/profile_view.dart';

import 'bdashboardview.dart';
import 'brand_notifications_view.dart';

class BrandHomeView extends ConsumerWidget {
  const BrandHomeView({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        bottomNavigationBar: const BrandBottomNavBar(),
        body: SafeArea(child: SizedBox.expand(child: _CurrentView(id: id))));
  }
}

class _CurrentView extends ConsumerWidget {
  const _CurrentView({required this.id});
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getBrandInfoProviderProvider(id)).when(data: (data) {
      var (brand, notifications) = data;
      debugPrint(notifications.length.toString());
      switch (ref.watch(_brandDashboardcurrentIndex)) {
        case 0:
          return BDashboardView(brand: brand);
        case 1:
          return ProductsView(brand: brand);
        case 2:
          return BrandNotificationsView(brand: brand);
        case 3:
          return ProfileView(brand: brand);
        default:
          return const Placeholder();
      }
    }, error: (er, st) {
      return const Center(
        child: Text("Failed to fetch"),
      );
    }, loading: () {
      return const Center(child: CircularProgressIndicator.adaptive());
    });
  }
}

class BrandBottomNavBar extends ConsumerWidget {
  const BrandBottomNavBar({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
        onTap: (index) {
          ref.watch(_brandDashboardcurrentIndex.notifier).state = index;
        },
        currentIndex: ref.watch(_brandDashboardcurrentIndex),
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue,
        items: _BottomNavBarItems.values.map((e) {
          Widget icon = const Icon(Icons.abc_outlined);
          String label = '';
          switch (e) {
            case _BottomNavBarItems.dashboard:
              icon = const Icon(Icons.dashboard);
              label = 'Dashboard';
              break;
            case _BottomNavBarItems.profile:
              icon = const Icon(Icons.person);
              label = 'Profle';
              break;
            case _BottomNavBarItems.products:
              icon = const Icon(Icons.adjust);
              label = 'Products';

            case _BottomNavBarItems.notifications:
              icon = badges.Badge(
                badgeContent: Text(ref.watch(notLength).toString()),
                showBadge: ref.watch(notLength) != null,
                child: const Icon(Icons.notifications),
              );
              label = 'Notifications';
              break;
          }
          return BottomNavigationBarItem(icon: icon, label: label);
        }).toList());
  }
}

final notLength = StateProvider<int?>((ref) => null);

enum _BottomNavBarItems { dashboard, products, notifications, profile }

final _brandDashboardcurrentIndex = StateProvider.autoDispose((ref) => 0);
