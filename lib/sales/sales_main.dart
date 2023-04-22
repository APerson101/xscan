import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../brand view/providers/login_provider.dart';
import 'screens/home.dart';

class SalesView extends ConsumerWidget {
  const SalesView({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: ref.watch(_currentIndex) == 0
          ? SalesHome(
              id: id,
            )
          : Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      ref.watch(loginStateProvider.notifier).logout();
                    },
                    child: const Text("logout"))
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (next) {
            ref.watch(_currentIndex.notifier).state = next;
          },
          currentIndex: ref.watch(_currentIndex),
          items: _BnbOptions.values
              .map((e) => BottomNavigationBarItem(
                  label: e == _BnbOptions.home ? 'Home' : "Profile",
                  icon: e == _BnbOptions.home
                      ? const Icon(Icons.home)
                      : const Icon(Icons.person)))
              .toList()),
    );
  }
}

enum _BnbOptions { home, profile }

final _currentIndex = StateProvider((ref) => 0);
