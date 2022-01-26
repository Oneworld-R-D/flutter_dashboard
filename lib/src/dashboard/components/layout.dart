part of components;

EdgeInsetsGeometry kDashboardAppbarPadding = const EdgeInsets.symmetric(
    horizontal: 20, vertical: kToolbarHeight - 45 //(56 - 45 = 11),
    );

EdgeInsetsGeometry kDashboardContentPadding = const EdgeInsets.symmetric(
  horizontal: 10,
  vertical: kToolbarHeight - 50, //(56 - 50 = 6)
);

double kDefaultRadius = 10;

class FlutterDashboard extends GetResponsiveView<FlutterDashboardController> {
  FlutterDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screen.context = context;
    return MouseRegion(
      cursor: FlutterDashboardMaterialApp.of(context)?.config.mouseCursor ??
          MouseCursor.defer,
      child: GetRouterOutlet.builder(
        builder: (BuildContext context, GetDelegate delegate,
            GetNavConfig? currentRoute) {
          controller.delegate = delegate;

          controller.currentRoute(currentRoute?.location ?? '/');

          return Obx(
            () => controller.isScreenLoading.value
                ? Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).indicatorColor,
                      ),
                    ),
                  )
                : _buildBody(context),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    screen.context = context;
    return Scaffold(
      key: controller.drawerKey,
      drawer: screen.isPhone
          ? Card(
              elevation: 10,
              shape: screen.isDesktop
                  ? Theme.of(context).drawerTheme.shape
                  : const RoundedRectangleBorder(),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: EdgeInsets.zero,
              child: _FlutterDashboardDrawer(
                isDesktop: screen.isDesktop,
                drawerIcon: _DrawerCloseIcon(
                  options:
                      FlutterDashboardMaterialApp.of(context)!.drawerOptions,
                ),
              ),
            )
          : null,
      body: screen.isDesktop
          ? Padding(
              padding:
                  FlutterDashboardMaterialApp.of(context)!.config.enableSpacing
                      ? FlutterDashboardMaterialApp.of(context)!.config.theme !=
                                  null ||
                              FlutterDashboardMaterialApp.of(context)!
                                      .config
                                      .darkTheme !=
                                  null
                          ? EdgeInsets.zero
                          : const EdgeInsets.all(16.0)
                      : EdgeInsets.zero,
              child: _buildDesktopView(
                context,
                title: controller.currentPageTitle.value,
                delegate: controller.delegate ?? Get.rootDelegate,
              ),
            )
          : _DashboardBody(),
    );
  }

  Widget _buildDesktopView(
    BuildContext context, {
    required String title,
    required GetDelegate delegate,
  }) {
    return Stack(
      fit: StackFit.expand,
      children: [
        PositionedDirectional(
          top: 0,
          bottom: 0,
          start: 304,
          end: 0,
          child: Material(
            elevation:
                FlutterDashboardMaterialApp.of(context)!.config.enableSpacing
                    ? FlutterDashboardMaterialApp.of(context)!.config.theme !=
                                null ||
                            FlutterDashboardMaterialApp.of(context)!
                                    .config
                                    .darkTheme !=
                                null
                        ? 0
                        : 10
                    : 0,
            shape: FlutterDashboardMaterialApp.of(context)!.config.enableSpacing
                ? screen.isDesktop
                    ? Theme.of(context).drawerTheme.shape
                    : const RoundedRectangleBorder()
                : const RoundedRectangleBorder(),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Theme.of(context).cardTheme.color,
            shadowColor: Theme.of(context).shadowColor,
            child: _DashboardBody(),
          ),
        ),
        PositionedDirectional(
          top: 0,
          bottom: 0,
          start: 0,
          end: controller.expansionController.value == 1
              ? Get.width - 304
              : Get.width - 50,
          child: _FlutterDashboardDrawer(
            isDesktop: screen.isDesktop,
            drawerIcon: const _DrawerIcon(),
          ),
        ),
      ],
    );
  }
}

class _DashboardBody extends GetResponsiveView<FlutterDashboardController> {
  @override
  Widget build(BuildContext context) {
    screen.context = context;
    return NestedScrollView(
      floatHeaderSlivers: true,
      controller: ScrollController(),
      physics: FlutterDashboardMaterialApp.of(context)!.config.hasScrollingBody
          ? const ClampingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      body: GetRouterOutlet(
        initialRoute: controller.dashboardInitialRoute,
        anchorRoute: DashboardRoutes.DASHBOARD,
        key: Get.nestedKey(1),
      ),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: _DashboardAppBar(
              focusNode: controller.focusNode,
              mergeActions: screen.isPhone || screen.isWatch,
              drawerIcon:
                  controller.expansionController.value == 0 || !screen.isDesktop
                      ? const _DrawerIcon()
                      : null,
              innerBoxIsScrolled: innerBoxIsScrolled,
            ),
          ),
        ];
      },
    );
  }
}
