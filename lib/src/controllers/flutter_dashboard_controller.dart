part of './controllers.dart';

class FlutterDashboardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static FlutterDashboardController get to =>
      Get.put(FlutterDashboardController());

  final FlutterDashboardNavService _navService = FlutterDashboardNavService.to;

  GetDelegate? delegate;

  final RxString currentRoute = ''.obs, currentPageTitle = ''.obs;

  final RxBool isScreenLoading = false.obs,
      isDrawerOpen = false.obs,
      isTileExpantionChanged = false.obs;

  late AnimationController expansionController;
  late FocusNode focusNode;

  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

  String dashboardInitialRoute =
      "${DashboardRoutes.DASHBOARD}${FlutterDashboardMaterialApp.of(Get.context!).dashboardItems[0].page!.name}";

  final RxMap<String, FlutterDashboardItem> finalRoutes =
      RxMap<String, FlutterDashboardItem>();

  FlutterDashboardItem get selectedDrawerItem {
    if (finalRoutes.containsKey(currentPageTitle.value)) {
      return finalRoutes[currentPageTitle.value]!;
    } else {
      return _navService.rawRoutes.first;
    }
  }

  void _addRoutes(List<FlutterDashboardItem> _items) {
    for (var item in _items) {
      if (item.subItems.isEmpty) {
        finalRoutes[item.title] = item;
      } else {
        _addRoutes(item.subItems);
      }
    }
  }

  final List<GetPage> _allPagesWithChildrens = [];

  void _addChildrenRoutes(List<GetPage> pages) {
    for (var _page in pages) {
      if (_page.children.isNotEmpty) {
        if (!_allPagesWithChildrens.contains(_page)) {
          _allPagesWithChildrens.add(_page);
        }

        _addChildrenRoutes(_page.children);
      } else {
        _allPagesWithChildrens.add(_page);
      }
    }
  }

  List<FlutterDashboardItem> expandItems(List<FlutterDashboardItem> items) {
    return items
        .expand((FlutterDashboardItem element) => element.subItems.isEmpty
            ? [element]
            : expandItems(element.subItems))
        .toList();
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      _addRoutes(_navService.rawFooterRoutes);
      _addRoutes(_navService.finalRoutes);
      _addChildrenRoutes(
          _navService.finalRoutes.map((element) => element.page!).toList());
      _addChildrenRoutes(
          _navService.rawFooterRoutes.map((element) => element.page!).toList());
    });

    isScreenLoading(true);

    focusNode = FocusNode();
    expansionController = AnimationController(
      vsync: this,
      duration: 250.milliseconds,
      value: 1.0,
    );

    // ever(currentRoute, (String location) {
    //   String _location = location.split('/').last.toLowerCase();

    //   if (_location.isEmpty || _location == 'dashboard') {
    //     currentPageTitle(_navService.rawRoutes.first.title);
    //   } else {
    //     // print(_location);
    //     // print(finalRoutes);
    //     // print(finalRoutes);
    //     // print(finalRoutes.entries.map((element) =>
    //     //     _location == element.value.page?.name.split('/').last));

    //     // print(finalRoutes.values.where((FlutterDashboardItem element) =>
    //     //     _location.contains('${element.page?.name.split('/').last}')));

    //     WidgetsBinding.instance?.addPersistentFrameCallback((_) {
    //       if (finalRoutes.values.where((FlutterDashboardItem element) => _location.contains('${element.page?.name.split('/').last}')).isNotEmpty) {
    //         // if (finalRoutes.entries
    //         //     .where((element) =>
    //         //         _location == element.value.page?.name.split('/').last)
    //         //     .isNotEmpty) {
    //         //   currentPageTitle(finalRoutes.entries
    //         //       .singleWhere((element) =>
    //         //           _location == element.value.page?.name.split('/').last)
    //         //       .key);
    //         // } else {
    //         //   currentPageTitle("404");
    //         //   delegate?.toNamed(DashboardRoutes.ERROR404);
    //         // }
    //         currentPageTitle(
    //             finalRoutes.values.singleWhere((FlutterDashboardItem element) => _location.contains('${element.page?.name.split('/').last}')).title);
    //       } else {
    //         currentPageTitle("404");
    //         delegate?.toNamed(DashboardRoutes.ERROR404);
    //       }
    //     });

    //     // Get.log('Current dashboard route : ${currentPageTitle.value}');
    //   }
    // });
    ever(currentRoute, (String location) {
      // String _location = location.split('/').last.toLowerCase();

      if (location.isEmpty ||
          location.split('/').last == 'dashboard' ||
          location == '/' ||
          location == '/index' ||
          location == '/index.html') {
        currentPageTitle(_navService.rawRoutes.first.title);
      } else {
        if (location != DashboardRoutes.DASHBOARD) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _allPagesWithChildrens.map((e) {
              return location.startsWith(DashboardRoutes.DASHBOARD + e.name);
            }).toList();
            // print(_allPagesWithChildrens.firstWhere((element) =>
            //     location.contains(DashboardRoutes.DASHBOARD + element.name)));
            if (_allPagesWithChildrens
                .where((element) => location
                    .startsWith(DashboardRoutes.DASHBOARD + element.name))
                .isNotEmpty) {
              if (_allPagesWithChildrens
                  .firstWhere((element) => location
                      .startsWith(DashboardRoutes.DASHBOARD + element.name))
                  .name
                  .contains(location.split('/').last)) {
                currentPageTitle(finalRoutes.entries
                    .toList()
                    .firstWhere((element) =>
                        element.value.page!.name ==
                        _allPagesWithChildrens
                            .firstWhere((element) => location.startsWith(
                                DashboardRoutes.DASHBOARD + element.name))
                            .name)
                    .value
                    .title);
              } else {
                // Need to check later
                if (_allPagesWithChildrens.any((element) =>
                    element.name == '/${location.split('/').last}')) {
                  currentPageTitle(finalRoutes.entries
                      .toList()
                      .firstWhere((element) =>
                          element.value.page!.name ==
                          _allPagesWithChildrens
                              .firstWhere((element) => location.startsWith(
                                  DashboardRoutes.DASHBOARD + element.name))
                              .name)
                      .value
                      .title);
                } else {
                  currentPageTitle("404");
                  delegate?.toNamed(DashboardRoutes.ERROR404);
                }
              }
            } else {
              currentPageTitle("404");
              delegate?.toNamed(DashboardRoutes.ERROR404);
            }

            Get.log('Current dashboard route : ${currentPageTitle.value}');
          });
        }

        // _location.startsWith(pattern);
        // WidgetsBinding.instance?.addPostFrameCallback((_) {
        // for (var item in finalRoutes.entries.toList()) {
        //   print(item.value.page!.name);
        // }

        // });
        // print(_location);
        // print(finalRoutes);
        // print(finalRoutes);
        // print(finalRoutes.entries.map((element) =>
        //     _location == element.value.page?.name.split('/').last));

        // print(finalRoutes.values.where((FlutterDashboardItem element) =>
        //     _location.contains('${element.page?.name.split('/').last}')));

        // WidgetsBinding.instance?.addPostFrameCallback((_) {
        //   if (finalRoutes.values
        //       .where((FlutterDashboardItem element) =>
        //           _location.startsWith('${element.page?.name.split('/').last}'))
        //       .isNotEmpty) {
        // if (finalRoutes.entries
        //     .where((element) =>
        //         _location == element.value.page?.name.split('/').last)
        //     .isNotEmpty) {
        //   currentPageTitle(finalRoutes.entries
        //       .singleWhere((element) =>
        //           _location == element.value.page?.name.split('/').last)
        //       .key);
        // } else {
        //   currentPageTitle("404");
        //   delegate?.toNamed(DashboardRoutes.ERROR404);
        // }
        // currentPageTitle(finalRoutes.values
        //     .singleWhere((FlutterDashboardItem element) => _location
        //         .startsWith('${element.page?.name.split('/').last}'))
        //     .title);
        //   } else {
        //     currentPageTitle("404");
        //     delegate?.toNamed(DashboardRoutes.ERROR404);
        //   }
        // });

      }
    });

    super.onInit();
  }

  @override
  void onReady() {
    isScreenLoading(false);
    super.onReady();
  }

  @override
  void onClose() {
    focusNode.dispose();
    expansionController.dispose();
    super.onClose();
  }
}
