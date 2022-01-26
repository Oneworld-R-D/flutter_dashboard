part of '../dashboard.dart';

class DashboardPages {
  DashboardPages._();

  static String get InitialRoute => DashboardRoutes.DASHBOARD;

  static final List<GetPage> _rootPages = [];
  static final List<GetPage> _routes = [];

  static List<GetPage> get routes => _routes;

  static List<GetPage> _pages(FlutterDashboardItem e) {
    if (e.page != null) {
      return [e.page!];
    } else {
      return e.subItems
          .map((e) => _pages(e))
          .expand((element) => element)
          .toList();
    }
  }

  static void setRootPages(List<GetPage> _pages) {
    _rootPages.addAll(_pages);
  }

  static void genarateRoutes(List<FlutterDashboardItem> dashboardItems,
      FlutterDashboardLoginView? loginView) {
    final List<GetPage> _allPages = [
      for (var item in dashboardItems) ..._pages(item),
    ];

    _routes.addAll(
      [
        GetPage(
          participatesInRootNavigator: true,
          preventDuplicates: true,
          name: '/',
          page: () => GetRouterOutlet.builder(
            builder: (BuildContext context, GetDelegate delegate,
                GetNavConfig? current) {
              String _initialRoute = '/';

              if (FlutterDashboardAuthService.to.isAuthenticated) {
                _initialRoute = DashboardRoutes.DASHBOARD;
              } else {
                _initialRoute = DashboardRoutes.LOGIN;
              }

              return GetRouterOutlet(
                initialRoute: _initialRoute,
                delegate: delegate,
              );
            },
          ),
          children: [
            GetPage(
              preventDuplicates: true,
              name: _Paths.LOGIN,
              page: () => loginView ?? FlutterDashboardDefaultLoginView(),
              binding: LoginBinding(),
              middlewares: [
                FlutterDashboardEnsureNotAuthenticated(),
              ],
            ),
            GetPage(
              preventDuplicates: true,
              name: _Paths.DASHBOARD,
              page: () => FlutterDashboard(),
              binding: DashboardBinding(),
              title: null,
              transition: Transition.fadeIn,
              children: [
                ..._allPages,
              ],
              middlewares: [
                FlutterDashboardEnsureAuthenticated(),
              ],
            ),
            ..._rootPages,
          ],
        ),
      ],
    );
  }
}
