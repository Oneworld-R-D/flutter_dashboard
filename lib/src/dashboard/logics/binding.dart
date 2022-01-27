part of './logics.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FlutterDashboardController>(() => FlutterDashboardController());
  }
}
