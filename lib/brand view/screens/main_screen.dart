import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xscan/sales/sales_main.dart';
import 'package:xscan/worker/view/worker_main.dart';

import '../../manufacturer/screens/main_screen_manufacturer.dart';
import '../providers/login_provider.dart';
import 'brand_home_view.dart';

class MainView extends ConsumerWidget {
  const MainView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var userType = ref.read(userTypeProvider);
    switch (userType) {
      case UserTypesEnum.brand:
        return BrandHomeView(id: FirebaseAuth.instance.currentUser!.uid);
      case UserTypesEnum.manufacturer:
        return MainScreenManufacturer(
            id: FirebaseAuth.instance.currentUser!.uid);
      case UserTypesEnum.admin:
        return const Center();
      case UserTypesEnum.employee:
        return WorkerMain(id: FirebaseAuth.instance.currentUser!.uid);
      case UserTypesEnum.sales:
        return SalesView(id: FirebaseAuth.instance.currentUser!.uid);
      default:
        return Center(
          child: Text(
            "Failed to Fetch user of type: $userType",
          ),
        );
    }
  }
}
