part of './logics.dart';

class FlutterDashboardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static FlutterDashboardController get to =>
      Get.find<FlutterDashboardController>();

  GetDelegate? delegate;

  final RxString currentRoute = ''.obs, currentPageTitle = ''.obs;

  final RxBool isScreenLoading = false.obs;

  final ScrollController bodyScrollController = ScrollController();

  late AnimationController expansionController;
  late FocusNode focusNode;

  bool isSelected(FlutterDashboardItem item) {
    return selectedItem.title == item.title;
  }

  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

  String dashboardInitialRoute =
      "${DashboardRoutes.DASHBOARD}${FlutterDashboardMaterialApp.of(Get.context!)!.dashboardItems[0].page!.name}";

  final Map<String, FlutterDashboardItem> _finalRoutes = {};

  FlutterDashboardItem get selectedItem {
    return _finalRoutes[currentPageTitle.value]!;
  }

  void _addRoutes(List<FlutterDashboardItem> _items) {
    for (var item in _items) {
      if (item.subItems.isEmpty) {
        _finalRoutes[item.title] = item;
      } else {
        _addRoutes(item.subItems);
      }
    }
  }

  @override
  void onInit() {
    _addRoutes(FlutterDashboardMaterialApp.of(Get.context!)!.dashboardItems);
    focusNode = FocusNode();
    expansionController = AnimationController(
      vsync: this,
      duration: 250.milliseconds,
      value: 1.0,
    );

    ever(currentRoute, (String location) {
      // print(location);
      if (location == '/' ||
          location == '/dashboard' ||
          location == '/dashboard/') {
        currentPageTitle(_finalRoutes.keys.toList()[0]);
      } else {
        if (_finalRoutes.values
            .map((FlutterDashboardItem e) => (location)
                .startsWith('${DashboardRoutes.DASHBOARD}${e.page!.name}'))
            .isNotEmpty) {
          currentPageTitle(_finalRoutes.values
              .singleWhere((FlutterDashboardItem e) => (location)
                  .startsWith('${DashboardRoutes.DASHBOARD}${e.page!.name}'))
              .title);
        }

        Get.log('Current dashboard route : ${currentPageTitle.value}');
      }
    });

    super.onInit();
  }

  @override
  void onClose() {
    focusNode.dispose();
    expansionController.dispose();
    super.onClose();
  }
}
