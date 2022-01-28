import 'package:example/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/flutter_dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterDashboardMaterialApp(
      title: 'Admin Panel Example',
      dashboardItems: AppPages.allPages(context),
      config: DashboardConfig(
        debugShowCheckedModeBanner: false,
        // enableSpacing: false,
        // theme: ThemeData.light().copyWith(
        //   drawerTheme: ThemeData.light().drawerTheme.copyWith(
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(15.0),
        //         ),
        //       ),
        // ),
        // darkTheme: ThemeData.dark().copyWith(
        //   drawerTheme: ThemeData.light().drawerTheme.copyWith(
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(15.0),
        //         ),
        //       ),
        // ),
        themeMode: ThemeMode.system,
        hasScrollingBody: false,
      ),
      appBarOptions: const AppBarOptions(
        elevation: 20,
        floating: true,
      ),
      drawerOptions: DrawerOptions(
        footer: Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: Text(
              '\u24B8 Gairick Saha - ${DateTime.now().year}',
              textScaleFactor: Get.textScaleFactor,
              style: GoogleFonts.poppins().copyWith(
                fontSize: 12,
              ),
            ),
          ),
        ),
        // backgroundColor: Colors.red,
        // centerHeaderLogo: true,
        // overrideHeader: CustomDrawerHeader(),
        // headerHeight: Get.context!.isPhone ? 130 : 160,
        listSpacing: 20,
        // selectedItemColor: const Color(0xffDF0019),
        // unSelectedItemColor: Colors.transparent,
        tilePadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        tileShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
