part of 'middlewares.dart';

class FlutterDashboardEnsureAuthenticated extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    FlutterDashboardAuthService.to.readAuthToken();
    if (!FlutterDashboardAuthService.to.isAuthenticated) {
      final newRoute = DashboardRoutes.LOGIN_THEN(route.location!);
      return GetNavConfig.fromRoute(newRoute);
    }
    return await super.redirectDelegate(route);
  }
}

class FlutterDashboardEnsureNotAuthenticated extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    if (FlutterDashboardAuthService.to.isAuthenticated) {
      const newRoute = DashboardRoutes.DASHBOARD;
      return GetNavConfig.fromRoute(newRoute);
    }
    return await super.redirectDelegate(route);
  }
}
