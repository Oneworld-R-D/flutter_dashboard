part of '../flutter_dashboard.dart';

class FlutterDashboardMaterialApp<T> extends StatefulWidget {
  final String title;
  final DashboardConfig config;
  final List<FlutterDashboardItem> dashboardItems;
  final DrawerOptions drawerOptions;
  final AppBarOptions appBarOptions;
  final List<T>? rootControllers;
  final FlutterDashboarAuthConfig authConfig;
  final List<Widget> overrideActions;
  final List<GetPage> pages;
  final List<NavigatorObserver>? navigatorObservers;
  final Widget Function(BuildContext, Widget?)? builder;

  FlutterDashboardMaterialApp({
    Key? key,
    required this.title,
    required this.config,
    required this.dashboardItems,
    this.drawerOptions = const DrawerOptions(),
    this.appBarOptions = const AppBarOptions(),
    this.rootControllers,
    this.navigatorObservers,
    required this.authConfig,
    this.overrideActions = const [],
    this.pages = const [],
    this.builder,
  })  : assert(dashboardItems.isNotEmpty),
        super(key: key);

  @override
  State<FlutterDashboardMaterialApp> createState() =>
      _FlutterDashboardMaterialAppState();

  static FlutterDashboardMaterialApp? of(BuildContext context) => context
      .findAncestorStateOfType<_FlutterDashboardMaterialAppState>()
      ?.widget;
}

class _FlutterDashboardMaterialAppState
    extends State<FlutterDashboardMaterialApp> {
  @override
  void initState() {
    DashboardPages.setRootPages(widget.pages);
    DashboardPages.genarateRoutes(
      widget.dashboardItems,
      widget.authConfig.overrideLoginView ?? FlutterDashboardDefaultLoginView(),
    );
    super.initState();
  }

  BuildContext get buildContext => context;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      debugShowCheckedModeBanner: widget.config.debugShowCheckedModeBanner,
      title: widget.title,
      getPages: DashboardPages.routes,
      scaffoldMessengerKey: Get.rootController.scaffoldMessengerKey,
      popGesture: Get.isPopGestureEnable,
      transitionDuration: Get.defaultTransitionDuration,
      // defaultTransition: Get.defaultTransition,
      defaultTransition: Transition.leftToRightWithFade,
      customTransition: Get.customTransition,
      theme: widget.config.theme ??
          ThemeData.light().copyWith(
            appBarTheme: AppBarTheme(
              elevation: 0,
              centerTitle: false,
              // backgroundColor: ThemeData.light().scaffoldBackgroundColor,
              backgroundColor: Colors.transparent,
              titleTextStyle:
                  ThemeData.light().appBarTheme.titleTextStyle?.apply(
                        fontFamily: GoogleFonts.notoSans().fontFamily,
                        color: Colors.black,
                        backgroundColor: Colors.black,
                        decorationColor: Colors.black,
                      ),
              toolbarTextStyle:
                  ThemeData.light().appBarTheme.titleTextStyle?.apply(
                        fontFamily: GoogleFonts.notoSans().fontFamily,
                        color: Colors.black,
                        backgroundColor: Colors.black,
                        decorationColor: Colors.black,
                      ),
              iconTheme: ThemeData.light().iconTheme.copyWith(
                    color: Colors.black,
                  ),
            ),
            textTheme: ThemeData.light().textTheme.apply(
                  fontFamily: GoogleFonts.notoSans().fontFamily,
                  displayColor: Colors.black,
                  bodyColor: Colors.black,
                  decorationColor: Colors.black,
                ),
            primaryTextTheme: ThemeData.light().primaryTextTheme.apply(
                  fontFamily: GoogleFonts.notoSans().fontFamily,
                  displayColor: Colors.black,
                  bodyColor: Colors.black,
                  decorationColor: Colors.black,
                ),
            iconTheme: ThemeData.light().iconTheme.copyWith(
                  color: Colors.black,
                ),
            drawerTheme: DrawerThemeData(
              backgroundColor: const Color(0xffF1F1F2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            cardTheme: const CardTheme(
              color: Color(0xffF1F1F2),
              clipBehavior: Clip.antiAliasWithSaveLayer,
            ),
            inputDecorationTheme:
                ThemeData.light().inputDecorationTheme.copyWith(
                      fillColor: ThemeData.light().drawerTheme.backgroundColor,
                      filled: true,
                    ),
          ),
      darkTheme: widget.config.darkTheme ??
          ThemeData.dark().copyWith(
            appBarTheme: AppBarTheme(
              elevation: 0,
              centerTitle: false,
              backgroundColor: Colors.transparent,
              titleTextStyle:
                  ThemeData.dark().appBarTheme.titleTextStyle?.apply(
                        fontFamily: GoogleFonts.notoSans().fontFamily,
                        color: const Color(0xffF1F1F2),
                        backgroundColor: const Color(0xffF1F1F2),
                        decorationColor: const Color(0xffF1F1F2),
                      ),
              toolbarTextStyle:
                  ThemeData.dark().appBarTheme.titleTextStyle?.apply(
                        fontFamily: GoogleFonts.notoSans().fontFamily,
                        color: const Color(0xffF1F1F2),
                        backgroundColor: const Color(0xffF1F1F2),
                        decorationColor: const Color(0xffF1F1F2),
                      ),
            ),
            textTheme: ThemeData.light().textTheme.apply(
                  fontFamily: GoogleFonts.notoSans().fontFamily,
                  displayColor: const Color(0xffF1F1F2),
                  bodyColor: const Color(0xffF1F1F2),
                  decorationColor: const Color(0xffF1F1F2),
                ),
            primaryTextTheme: ThemeData.light().primaryTextTheme.apply(
                  fontFamily: GoogleFonts.notoSans().fontFamily,
                  displayColor: const Color(0xffF1F1F2),
                  bodyColor: const Color(0xffF1F1F2),
                  decorationColor: const Color(0xffF1F1F2),
                ),
            iconTheme: ThemeData.light().iconTheme.copyWith(
                  color: const Color(0xffF1F1F2),
                ),
            drawerTheme: DrawerThemeData(
              backgroundColor: const Color(0xff242222),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            cardTheme: const CardTheme(
              color: Color(0xff242222),
              clipBehavior: Clip.antiAliasWithSaveLayer,
            ),
            inputDecorationTheme:
                ThemeData.dark().inputDecorationTheme.copyWith(
                      fillColor: ThemeData.dark().drawerTheme.backgroundColor,
                      filled: true,
                    ),
          ),
      themeMode: widget.config.themeMode,
      locale: widget.config.locale ?? Get.deviceLocale,
      localizationsDelegates: widget.config.localizationsDelegates,
      localeListResolutionCallback: widget.config.localeListResolutionCallback,
      localeResolutionCallback: widget.config.localeResolutionCallback,
      fallbackLocale: widget.config.fallbackLocale ?? Get.fallbackLocale,
      supportedLocales: widget.config.supportedLocales,
      textDirection: widget.config.textDirection,
      translations: widget.config.translations,
      translationsKeys: widget.config.translations?.keys ?? Get.translations,
      builder: widget.builder,
      navigatorObservers: widget.navigatorObservers,
      initialBinding: BindingsBuilder(
        () {
          Get.put(FlutterDashboardAuthService(), permanent: true);
          if ((widget.rootControllers ?? []).isNotEmpty) {
            for (var _controller in (widget.rootControllers ?? [])) {
              _controller;
            }
          }
        },
      ),
    );

    // return GetMaterialApp.router(
    //   debugShowCheckedModeBanner: widget.config.debugShowCheckedModeBanner,
    //   title: widget.title,
    //   getPages: DashboardPages.routes,
    //   scaffoldMessengerKey: Get.rootController.scaffoldMessengerKey,
    //   popGesture: Get.isPopGestureEnable,
    //   transitionDuration: Get.defaultTransitionDuration,
    //   // defaultTransition: Get.defaultTransition,
    //   defaultTransition: Transition.leftToRightWithFade,
    //   customTransition: Get.customTransition,
    //   theme: widget.config.theme ??
    //       ThemeData.light().copyWith(
    //         appBarTheme: AppBarTheme(
    //           elevation: 0,
    //           centerTitle: false,
    //           // backgroundColor: ThemeData.light().scaffoldBackgroundColor,
    //           backgroundColor: Colors.transparent,
    //           titleTextStyle:
    //               ThemeData.light().appBarTheme.titleTextStyle?.apply(
    //                     fontFamily: GoogleFonts.notoSans().fontFamily,
    //                     color: Colors.black,
    //                     backgroundColor: Colors.black,
    //                     decorationColor: Colors.black,
    //                   ),
    //           toolbarTextStyle:
    //               ThemeData.light().appBarTheme.titleTextStyle?.apply(
    //                     fontFamily: GoogleFonts.notoSans().fontFamily,
    //                     color: Colors.black,
    //                     backgroundColor: Colors.black,
    //                     decorationColor: Colors.black,
    //                   ),
    //           iconTheme: ThemeData.light().iconTheme.copyWith(
    //                 color: Colors.black,
    //               ),
    //         ),
    //         textTheme: ThemeData.light().textTheme.apply(
    //               fontFamily: GoogleFonts.notoSans().fontFamily,
    //               displayColor: Colors.black,
    //               bodyColor: Colors.black,
    //               decorationColor: Colors.black,
    //             ),
    //         primaryTextTheme: ThemeData.light().primaryTextTheme.apply(
    //               fontFamily: GoogleFonts.notoSans().fontFamily,
    //               displayColor: Colors.black,
    //               bodyColor: Colors.black,
    //               decorationColor: Colors.black,
    //             ),
    //         iconTheme: ThemeData.light().iconTheme.copyWith(
    //               color: Colors.black,
    //             ),
    //         drawerTheme: DrawerThemeData(
    //           backgroundColor: const Color(0xffF1F1F2),
    //           shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(30),
    //           ),
    //         ),
    //         cardTheme: const CardTheme(
    //           color: Color(0xffF1F1F2),
    //           clipBehavior: Clip.antiAliasWithSaveLayer,
    //         ),
    //         inputDecorationTheme:
    //             ThemeData.light().inputDecorationTheme.copyWith(
    //                   fillColor: ThemeData.light().drawerTheme.backgroundColor,
    //                   filled: true,
    //                 ),
    //       ),
    //   darkTheme: widget.config.darkTheme ??
    //       ThemeData.dark().copyWith(
    //         appBarTheme: AppBarTheme(
    //           elevation: 0,
    //           centerTitle: false,
    //           backgroundColor: Colors.transparent,
    //           titleTextStyle:
    //               ThemeData.dark().appBarTheme.titleTextStyle?.apply(
    //                     fontFamily: GoogleFonts.notoSans().fontFamily,
    //                     color: const Color(0xffF1F1F2),
    //                     backgroundColor: const Color(0xffF1F1F2),
    //                     decorationColor: const Color(0xffF1F1F2),
    //                   ),
    //           toolbarTextStyle:
    //               ThemeData.dark().appBarTheme.titleTextStyle?.apply(
    //                     fontFamily: GoogleFonts.notoSans().fontFamily,
    //                     color: const Color(0xffF1F1F2),
    //                     backgroundColor: const Color(0xffF1F1F2),
    //                     decorationColor: const Color(0xffF1F1F2),
    //                   ),
    //         ),
    //         textTheme: ThemeData.light().textTheme.apply(
    //               fontFamily: GoogleFonts.notoSans().fontFamily,
    //               displayColor: const Color(0xffF1F1F2),
    //               bodyColor: const Color(0xffF1F1F2),
    //               decorationColor: const Color(0xffF1F1F2),
    //             ),
    //         primaryTextTheme: ThemeData.light().primaryTextTheme.apply(
    //               fontFamily: GoogleFonts.notoSans().fontFamily,
    //               displayColor: const Color(0xffF1F1F2),
    //               bodyColor: const Color(0xffF1F1F2),
    //               decorationColor: const Color(0xffF1F1F2),
    //             ),
    //         iconTheme: ThemeData.light().iconTheme.copyWith(
    //               color: const Color(0xffF1F1F2),
    //             ),
    //         drawerTheme: DrawerThemeData(
    //           backgroundColor: const Color(0xff242222),
    //           shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(30),
    //           ),
    //         ),
    //         cardTheme: const CardTheme(
    //           color: Color(0xff242222),
    //           clipBehavior: Clip.antiAliasWithSaveLayer,
    //         ),
    //         inputDecorationTheme:
    //             ThemeData.dark().inputDecorationTheme.copyWith(
    //                   fillColor: ThemeData.dark().drawerTheme.backgroundColor,
    //                   filled: true,
    //                 ),
    //       ),
    //   themeMode: Get.rootController.themeMode ?? widget.config.themeMode,
    //   locale: widget.config.locale ?? Get.deviceLocale,
    //   localizationsDelegates: widget.config.localizationsDelegates,
    //   localeListResolutionCallback: widget.config.localeListResolutionCallback,
    //   localeResolutionCallback: widget.config.localeResolutionCallback,
    //   fallbackLocale: widget.config.fallbackLocale ?? Get.fallbackLocale,
    //   supportedLocales: widget.config.supportedLocales,
    //   textDirection: widget.config.textDirection,
    //   translations: widget.config.translations,
    //   translationsKeys: widget.config.translations?.keys ?? Get.translations,

    //   initialBinding: BindingsBuilder(
    //     () {
    //       Get.put(FlutterDashboardAuthService(), permanent: true);

    //       if ((widget.rootControllers ?? []).isNotEmpty) {
    //         for (var _controller in (widget.rootControllers ?? [])) {
    //           _controller;
    //         }
    //       }
    //     },
    //   ),
    // );
  }
}
