import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xscan/brand%20view/providers/brand_providers.dart';
import 'package:xscan/brand%20view/screens/products_view.dart';
import 'package:xscan/brand%20view/screens/profile_view.dart';

import 'bdashboardview.dart';

class BrandHomeView extends ConsumerWidget {
  const BrandHomeView({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        bottomNavigationBar: const BrandBottomNavBar(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Welcome back!"),
        ),
        body: SizedBox.expand(child: _CurrentView(id: id)));
  }
}

class _CurrentView extends ConsumerWidget {
  const _CurrentView({required this.id});
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getBrandInfoProvider(id)).when(data: (brand) {
      switch (ref.watch(_brandDashboardcurrentIndex)) {
        case 0:
          return BDashboardView(brand: brand);
        case 1:
          return ProductsView(brand: brand);
        case 2:
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
          IconData icon = Icons.abc_outlined;
          String label = '';
          switch (e) {
            case _BottomNavBarItems.dashboard:
              icon = Icons.dashboard;
              label = 'Dashboard';
              break;
            case _BottomNavBarItems.profile:
              icon = Icons.person;
              label = 'Profle';
              break;
            case _BottomNavBarItems.products:
              icon = Icons.adjust;
              label = 'Products';
              break;
          }
          return BottomNavigationBarItem(icon: Icon(icon), label: label);
        }).toList());
  }
}

enum _BottomNavBarItems { dashboard, products, profile }

final _brandDashboardcurrentIndex = StateProvider((ref) => 0);
