import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xscan/brand%20view/providers/login_provider.dart';
import 'package:xscan/user/market_place_view.dart';
import 'package:xscan/user/user_assets.dart';
import 'package:xscan/user/user_dashboard.dart';

class UserMain extends ConsumerWidget {
  const UserMain({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            onTap: (selected) {
              ref.watch(_selectedIndex.notifier).state = selected;
            },
            currentIndex: ref.watch(_selectedIndex),
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.green,
            items: UserNavBar.values
                .map((e) =>
                    BottomNavigationBarItem(icon: e.icon, label: e.label))
                .toList()),
        body: switch (ref.watch(_selectedIndex)) {
          0 => UserDashboard(id: id),
          1 => MarketPlaceView(id: id),
          2 => UserAssets(id: id),
          _ => Center(
              child: ElevatedButton(
                  onPressed: () {
                    ref.watch(loginStateProvider.notifier).logout();
                  },
                  child: const Text("Logout")))
        });
  }
}

enum UserNavBar {
  dashboard('dashboard', Icon(Icons.dashboard)),
  marketplace('market', Icon(Icons.shop)),
  assets('assets', Icon(Icons.receipt)),
  profile('profile', Icon(Icons.person));

  final String label;
  final Widget icon;
  const UserNavBar(this.label, this.icon);
}

final _selectedIndex = StateProvider((ref) => 0);
