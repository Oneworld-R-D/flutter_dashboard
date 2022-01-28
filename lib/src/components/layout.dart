part of './components.dart';

const EdgeInsetsGeometry kDashboardAppbarPadding =
    EdgeInsets.only(bottom: kToolbarHeight - 45 //(56 - 45 = 11),
        );

const EdgeInsetsGeometry kDashboardContentPadding = EdgeInsets.symmetric(
  horizontal: 10,
  vertical: kToolbarHeight - 50, //(56 - 50 = 6)
);

const double kDefaultRadius = 10;

const double kDefaultElevation = 10;

class FlutterDashboardRootView
    extends GetResponsiveView<FlutterDashboardController> {
  FlutterDashboardRootView({Key? key}) : super(key: key);

  FlutterDashboardMaterialApp get dashboard =>
      FlutterDashboardMaterialApp.of(screen.context);

  @override
  Widget build(BuildContext context) {
    screen.context = context;

    return MouseRegion(
      cursor: dashboard.config.mouseCursor ?? MouseCursor.defer,
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
      drawer: !screen.isDesktop
          ? Card(
              elevation: Theme.of(context).drawerTheme.elevation,
              shape: screen.isDesktop
                  ? Theme.of(context).drawerTheme.shape
                  : const RoundedRectangleBorder(),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: EdgeInsets.zero,
              child: _FlutterDashboardDrawer(
                drawerIcon: _DrawerIcon(
                  expansion: controller.expansionController,
                ),
                expansiocController: controller.expansionController,
              ),
            )
          : null,
      body: screen.isDesktop
          ? Padding(
              padding: dashboard.config.enableSpacing
                  ? const EdgeInsets.all(16.0)
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
          child: _DashboardBody(),
        ),
        PositionedDirectional(
          top: 0,
          bottom: 0,
          start: 0,
          end: controller.expansionController.value == 1
              ? Get.width - 304
              : Get.width - 50,
          child: _FlutterDashboardDrawer(
            expansiocController: controller.expansionController,
            drawerIcon: null,
          ),
        ),
      ],
    );
  }
}

class _DashboardBody extends GetResponsiveView<FlutterDashboardController> {
  FlutterDashboardMaterialApp get _dashboard =>
      FlutterDashboardMaterialApp.of(screen.context);

  @override
  Widget build(BuildContext context) {
    screen.context = context;
    return NestedScrollView(
      floatHeaderSlivers: true,
      controller: ScrollController(),
      physics: _dashboard.config.hasScrollingBody
          ? const ClampingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      body: Material(
        shape: _dashboard.config.enableSpacing
            ? screen.isDesktop
                ? _dashboard.config.dashboardContentShape ??
                    Theme.of(context).drawerTheme.shape ??
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                      _dashboard.config.radius,
                    ))
                : const RoundedRectangleBorder()
            : const RoundedRectangleBorder(),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color:
            _dashboard.config.theme != null || _dashboard.config.theme != null
                ? Theme.of(context).scaffoldBackgroundColor
                : Theme.of(context).cardColor,
        shadowColor: Theme.of(context).shadowColor,
        elevation: Theme.of(context).drawerTheme.elevation ?? kDefaultElevation,
        child: GetRouterOutlet(
          initialRoute: controller.dashboardInitialRoute,
          anchorRoute: DashboardRoutes.DASHBOARD,
          key: Get.nestedKey(1),
        ),
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
                      ? _DrawerIcon(
                          expansion: controller.expansionController,
                        )
                      : null,
              innerBoxIsScrolled: innerBoxIsScrolled,
            ),
          ),
        ];
      },
    );
  }
}
