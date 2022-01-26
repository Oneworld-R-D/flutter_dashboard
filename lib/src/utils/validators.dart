part of './utils.dart';

class FlutterDashboardFormValidators {
  static const String emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static const String phonePattern = r'(^[0-9]{10}$)';

  static const String passwordPattern = r"^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}$";
}
