part of './flutter_dashboard_navigation.dart';

abstract class DashboardRoutes {
  DashboardRoutes._();

  static const LOGIN = _Paths.LOGIN;

  static String LOGIN_THEN(String afterSuccessfulLogin) =>
      '$LOGIN?then=${Uri.encodeQueryComponent(afterSuccessfulLogin)}';

  static const DASHBOARD = _Paths.DASHBOARD;
}

abstract class _Paths {
  static const LOGIN = '/login';
  static const DASHBOARD = '/dashboard';
}
