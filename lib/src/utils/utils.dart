library flutter_dashboard_utils;

import 'package:intl/intl.dart';

part './validators.dart';

class FlutterDashboardUtility {
  static const String noImg =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png";

  static String dateFortter1(DateTime value) =>
      DateFormat('yyyy-MM-dd').format(value);

  static String dateFortter2(DateTime value) =>
      DateFormat('dd MMM, yyyy').format(value);

  static String timeFormatter(DateTime value) =>
      DateFormat('h:mm a').format(value);
}
