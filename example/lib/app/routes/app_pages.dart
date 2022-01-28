import 'package:flutter/material.dart';

import 'package:flutter_dashboard/flutter_dashboard.dart';

import 'package:example/app/modules/home/bindings/home_binding.dart';
import 'package:example/app/modules/home/views/home_view.dart';
import 'package:example/app/modules/page1/bindings/page1_binding.dart';
import 'package:example/app/modules/page1/views/page1_view.dart';
import 'package:example/app/modules/settings/bindings/settings_binding.dart';
import 'package:example/app/modules/settings/views/settings_view.dart';
import 'package:example/app/modules/test_page_one/bindings/test_page_one_binding.dart';
import 'package:example/app/modules/test_page_one/views/test_page_one_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PAGE1,
      page: () => const Page1View(),
      binding: Page1Binding(),
    ),
    GetPage(
      name: _Paths.TEST_PAGE_ONE,
      page: () => const TestPageOneView(),
      binding: TestPageOneBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
  ];

  static List<FlutterDashboardItem> allPages(BuildContext context) => [
        FlutterDashboardItem(
          icon: const Icon(
            Icons.home,
          ),
          selectedIcon: const Icon(
            Icons.home_filled,
          ),
          page: GetPage(
            name: _Paths.HOME,
            page: () => const HomeView(),
            binding: HomeBinding(),
          ),
          title: 'Home',
        ),
        FlutterDashboardItem(
          icon: const Icon(
            Icons.developer_mode,
          ),
          page: GetPage(
            name: _Paths.PAGE1,
            page: () => const Page1View(),
            binding: Page1Binding(),
          ),
          title: 'Page1',
        ),
        FlutterDashboardItem.items(
          icon: const Icon(
            Icons.developer_mode,
          ),
          title: 'Expanded Menu',
          subItems: [
            FlutterDashboardItem(
              icon: const Icon(
                Icons.face,
              ),
              page: GetPage(
                name: _Paths.TEST_PAGE_ONE,
                page: () => const TestPageOneView(),
                binding: TestPageOneBinding(),
              ),
              title: 'Test Page 1',
            ),
          ],
        ),
        FlutterDashboardItem(
          icon: const Icon(
            Icons.settings,
          ),
          page: GetPage(
            name: _Paths.SETTINGS,
            page: () => SettingsView(),
            binding: SettingsBinding(),
          ),
          title: 'Settings',
        ),
      ];
}
