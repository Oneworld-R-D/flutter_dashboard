part of './components.dart';

class DrawerOptions {
  final Color? backgroundColor;
  final DecorationImage? image;
  final Gradient? gradient;
  final List<Widget> headers;
  final Widget? footer;
  final Widget? logo;
  final Widget? closeIcon;
  final bool showCloseButton;
  final Color? selectedItemColor;
  final Color? unSelectedItemColor;
  final Color? selectedTextColor;
  final bool centerHeaderLogo;
  final double? listSpacing;
  final EdgeInsetsGeometry tilePadding;
  final EdgeInsetsGeometry? tileContentPadding;
  final ShapeBorder? tileShape;
  final DrawerSliverPersistentHeaderDelegate? overrideHeader;

  const DrawerOptions({
    this.headers = const [],
    this.footer,
    this.backgroundColor,
    this.image,
    this.gradient,
    this.logo,
    this.showCloseButton = true,
    this.closeIcon,
    this.selectedItemColor,
    this.unSelectedItemColor,
    this.selectedTextColor,
    this.centerHeaderLogo = false,
    this.listSpacing,
    this.tilePadding = EdgeInsets.zero,
    this.tileContentPadding,
    this.tileShape,
    // this.headerHeight,
    this.overrideHeader,
  });
}

typedef DrawerSliverPersistentHeaderDelegate = SliverPersistentHeaderDelegate;

class _DrawerIcon extends GetResponsiveView<FlutterDashboardController> {
  final AnimationController expansion;
  _DrawerIcon({Key? key, required this.expansion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screen.context = context;
    bool hasDrawer = Scaffold.maybeOf(screen.context)?.hasDrawer == true;

    return IconButton(
      onPressed: () {
        if (hasDrawer) {
          var isDrawerOpen = Scaffold.of(screen.context).isDrawerOpen;
          if (!isDrawerOpen) {
            expansion.animateTo(0.0);
            controller.drawerKey.currentState?.openDrawer();
          } else {
            expansion.animateTo(1.0);
            Navigator.of(context).pop();
          }
        } else {
          if (expansion.value == 0 || expansion.value == 1) {
            if (expansion.value == 0) {
              expansion.animateTo(1.0);
            } else {
              expansion.animateTo(0.0);
            }
          }
        }
      },
      padding: EdgeInsets.zero,
      icon: AnimatedIcon(
        icon: AnimatedIcons.close_menu,
        progress:
            Tween(begin: !hasDrawer ? 1.0 : 0.0, end: !hasDrawer ? 0.0 : 1.0)
                .animate(expansion),
      ),
    );
  }
}

abstract class FlutterDashboardDrawerHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  double? height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return build(context, shrinkOffset, overlapsContent);
  }

  @override
  double get maxExtent =>
      height ?? (kToolbarHeight + Get.mediaQuery.padding.bottom);

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

mixin DrawerHeaderMixin {
  double? height;
  Widget? drawerIcon;
  Widget? brandLogo;
}

class _DrawerHeader extends FlutterDashboardDrawerHeaderDelegate {
  final ResponsiveScreen screen;
  final Widget? logo;
  final Widget? drawerIcon;

  _DrawerHeader({
    required this.screen,
    required this.logo,
    required this.drawerIcon,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    DrawerOptions _dashboardDrawerOptions =
        FlutterDashboardMaterialApp.of(screen.context).drawerOptions;

    return DrawerHeader(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment:
            screen.isDesktop && _dashboardDrawerOptions.centerHeaderLogo
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Get.rootDelegate
                  .toNamed(FlutterDashboardController.to.dashboardInitialRoute);
            },
            child: Align(
              alignment:
                  screen.isDesktop && _dashboardDrawerOptions.centerHeaderLogo
                      ? AlignmentDirectional.center
                      : AlignmentDirectional.centerStart,
              child: logo ??
                  FlutterLogo(
                    textColor: Theme.of(context).primaryColor,
                  ),
            ),
          ),
          const SizedBox(width: 10),
          drawerIcon ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class _FlutterDashboardDrawer
    extends GetResponsiveView<FlutterDashboardController> {
  final Widget? drawerIcon;
  final AnimationController expansiocController;
  _FlutterDashboardDrawer({
    Key? key,
    required this.drawerIcon,
    required this.expansiocController,
  }) : super(key: key);

  FlutterDashboardMaterialApp get _dashboard =>
      FlutterDashboardMaterialApp.of(screen.context);

  DrawerOptions get _dashboardDrawer => _dashboard.drawerOptions;

  @override
  Widget build(BuildContext context) {
    screen.context = context;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _dashboardDrawer.backgroundColor,
        image: _dashboardDrawer.image,
        gradient: _dashboardDrawer.gradient,
      ),
      child: Material(
        elevation: _dashboard.config.theme != null ||
                _dashboard.config.darkTheme != null
            ? Get.theme.drawerTheme.elevation ??
                Theme.of(context).drawerTheme.elevation ??
                (Get.isDarkMode
                    ? _dashboard.config.darkTheme?.drawerTheme.elevation
                    : _dashboard.config.theme?.drawerTheme.elevation) ??
                10
            : _dashboard.config.enableSpacing
                ? 20
                : 10,
        shape: _dashboard.config.enableSpacing
            ? screen.isDesktop
                ? Theme.of(context).drawerTheme.shape ??
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                      _dashboard.config.radius,
                    ))
                : const RoundedRectangleBorder()
            : const RoundedRectangleBorder(),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Theme.of(context).drawerTheme.backgroundColor,
        child: Drawer(
          elevation: _dashboard.config.theme != null ||
                  _dashboard.config.darkTheme != null
              ? Get.theme.drawerTheme.elevation ??
                  Theme.of(context).drawerTheme.elevation ??
                  (Get.isDarkMode
                      ? _dashboard.config.darkTheme?.drawerTheme.elevation
                      : _dashboard.config.theme?.drawerTheme.elevation) ??
                  10
              : _dashboard.config.enableSpacing
                  ? 20
                  : 10,
          shape: _dashboard.config.enableSpacing
              ? screen.isDesktop
                  ? Theme.of(context).drawerTheme.shape
                  : const RoundedRectangleBorder()
              : const RoundedRectangleBorder(),
          backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
          child: CustomScrollView(
            controller: ScrollController(),
            clipBehavior: Clip.hardEdge,
            slivers: [
              SliverPersistentHeader(
                delegate: _dashboard.drawerOptions.overrideHeader ??
                    _DrawerHeader(
                      logo:
                          _dashboard.config.brandLogo ?? _dashboardDrawer.logo,
                      drawerIcon: !screen.isDesktop ? drawerIcon : null,
                      screen: screen,
                    ),
              ),
              SliverToBoxAdapter(
                child: Divider(
                  color: Colors.transparent,
                  height: _dashboardDrawer.listSpacing ?? 0,
                ),
              ),
              _DrawerList(),
              if (_dashboardDrawer.footer != null)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _dashboardDrawer.footer ?? const SizedBox.shrink(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerList extends GetResponsiveView<FlutterDashboardController> {
  _DrawerList({Key? key}) : super(key: key);

  List<FlutterDashboardItem> _expanded(List<FlutterDashboardItem> items) {
    return items
        .expand((FlutterDashboardItem element) =>
            element.subItems.isEmpty ? [element] : _expanded(element.subItems))
        .toList();
  }

  FlutterDashboardMaterialApp get _dashboard =>
      FlutterDashboardMaterialApp.of(screen.context);

  @override
  Widget build(BuildContext context) {
    screen.context = context;

    return SliverList(
      delegate: SliverChildListDelegate(
        [
          if (FlutterDashboardMaterialApp.of(context)
              .drawerOptions
              .headers
              .isNotEmpty)
            ...FlutterDashboardMaterialApp.of(context)
                .drawerOptions
                .headers
                .map(
                  (e) => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      e,
                      const Divider(
                        height: 50,
                      ),
                    ],
                  ),
                ),
          for (var _item in _dashboard.dashboardItems)
            Obx(
              () => _buildList(
                item: _item,
                isFirstItem:
                    _dashboard.dashboardItems.first.title == _item.title,
                selectedItem: controller.selectedDrawerItem,
                expanded: _expanded(_dashboard.dashboardItems),
                isSubItem: false,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildList({
    required FlutterDashboardItem item,
    required FlutterDashboardItem selectedItem,
    required bool isFirstItem,
    required List<FlutterDashboardItem> expanded,
    required bool isSubItem,
  }) {
    return Padding(
      padding: isFirstItem && isSubItem
          ? EdgeInsets.only(
              left: _dashboard.drawerOptions.tilePadding.horizontal -
                  (_dashboard.drawerOptions.tilePadding.horizontal / 2),
              right: _dashboard.drawerOptions.tilePadding.horizontal -
                  (_dashboard.drawerOptions.tilePadding.horizontal / 2),
              bottom: _dashboard.drawerOptions.tilePadding.vertical -
                  (_dashboard.drawerOptions.tilePadding.vertical / 2),
            )
          : isSubItem
              ? EdgeInsets.zero
              : _dashboard.drawerOptions.tilePadding,
      child: Theme(
        data: Theme.of(screen.context).copyWith(
          iconTheme: IconThemeData(
            color: Theme.of(screen.context)
                .textTheme
                .button
                ?.copyWith(
                    color: _dashboard.drawerOptions.selectedTextColor ??
                        (item == selectedItem || item == selectedItem
                            ? Get.isDarkMode
                                ? Theme.of(screen.context)
                                    .textTheme
                                    .button
                                    ?.color
                                : Theme.of(screen.context)
                                    .scaffoldBackgroundColor
                            : Theme.of(screen.context).disabledColor))
                .color,
          ),
          listTileTheme: ListTileThemeData(
            horizontalTitleGap: 0.0,
            shape: _dashboard.drawerOptions.tileShape,
            tileColor: item == selectedItem || item == selectedItem
                ? (_dashboard.drawerOptions.selectedItemColor ??
                    Theme.of(screen.context).drawerTheme.backgroundColor)
                : ((_dashboard.drawerOptions.unSelectedItemColor ==
                            Colors.transparent
                        ? Theme.of(screen.context).drawerTheme.backgroundColor
                        : _dashboard.drawerOptions.unSelectedItemColor) ??
                    Theme.of(screen.context).drawerTheme.backgroundColor),
            selectedColor: item == selectedItem || item == selectedItem
                ? (Theme.of(screen.context)
                        .textTheme
                        .button
                        ?.copyWith(
                            color: _dashboard.drawerOptions.selectedTextColor ??
                                (item == selectedItem || item == selectedItem
                                    ? Get.isDarkMode
                                        ? Theme.of(screen.context)
                                            .textTheme
                                            .button
                                            ?.color
                                        : Theme.of(screen.context)
                                            .scaffoldBackgroundColor
                                    : Theme.of(screen.context).disabledColor))
                        .color ??
                    Theme.of(screen.context).primaryColor)
                : (_dashboard.drawerOptions.unSelectedItemColor ??
                    Theme.of(screen.context).listTileTheme.selectedColor),
            selectedTileColor: item == selectedItem || item == selectedItem
                ? (_dashboard.drawerOptions.selectedItemColor ??
                    Theme.of(screen.context).primaryColor)
                : (_dashboard.drawerOptions.unSelectedItemColor ??
                    Theme.of(screen.context).listTileTheme.selectedTileColor),
            textColor: Theme.of(screen.context)
                .textTheme
                .button
                ?.copyWith(
                    color: _dashboard.drawerOptions.selectedTextColor ??
                        (item == selectedItem || item == selectedItem
                            ? Get.isDarkMode
                                ? Theme.of(screen.context)
                                    .textTheme
                                    .button
                                    ?.color
                                : Theme.of(screen.context)
                                    .scaffoldBackgroundColor
                            : Theme.of(screen.context).disabledColor))
                .color,
            iconColor: Theme.of(screen.context)
                .textTheme
                .button
                ?.copyWith(
                    color: _dashboard.drawerOptions.selectedTextColor ??
                        (item == selectedItem || item == selectedItem
                            ? Get.isDarkMode
                                ? Theme.of(screen.context)
                                    .textTheme
                                    .button
                                    ?.color
                                : Theme.of(screen.context)
                                    .scaffoldBackgroundColor
                            : Theme.of(screen.context).disabledColor))
                .color,
          ),
          dividerColor: Colors.transparent,
        ),
        child: item.subItems.isNotEmpty
            ? ExpansionTile(
                title: Text(item.title),
                initiallyExpanded: _expanded(item.subItems)
                    .any((element) => element == selectedItem),
                leading: item.icon,
                tilePadding: _dashboard.drawerOptions.tileContentPadding,
                childrenPadding: EdgeInsets.zero,
                expandedAlignment: Alignment.center,
                expandedCrossAxisAlignment: CrossAxisAlignment.center,
                controlAffinity: ListTileControlAffinity.platform,
                collapsedTextColor: Theme.of(screen.context)
                    .textTheme
                    .button
                    ?.copyWith(
                        color: _dashboard.drawerOptions.selectedTextColor ??
                            (item == selectedItem || item == selectedItem
                                ? Get.isDarkMode
                                    ? Theme.of(screen.context)
                                        .textTheme
                                        .button
                                        ?.color
                                    : Theme.of(screen.context)
                                        .scaffoldBackgroundColor
                                : Theme.of(screen.context).disabledColor))
                    .color,
                collapsedIconColor: Theme.of(screen.context)
                    .textTheme
                    .button
                    ?.copyWith(
                        color: _dashboard.drawerOptions.selectedTextColor ??
                            (item == selectedItem || item == selectedItem
                                ? Get.isDarkMode
                                    ? Theme.of(screen.context)
                                        .textTheme
                                        .button
                                        ?.color
                                    : Theme.of(screen.context)
                                        .scaffoldBackgroundColor
                                : Theme.of(screen.context).disabledColor))
                    .color,
                iconColor: _dashboard.drawerOptions.selectedItemColor ??
                    Theme.of(screen.context).indicatorColor,
                textColor: _dashboard.drawerOptions.selectedItemColor ??
                    Theme.of(screen.context).indicatorColor,
                backgroundColor: item == selectedItem || item == selectedItem
                    ? (_dashboard.drawerOptions.selectedItemColor ??
                        Theme.of(screen.context).drawerTheme.backgroundColor)
                    : ((_dashboard.drawerOptions.unSelectedItemColor ==
                                Colors.transparent
                            ? Theme.of(screen.context)
                                .drawerTheme
                                .backgroundColor
                            : _dashboard.drawerOptions.unSelectedItemColor) ??
                        Theme.of(screen.context).drawerTheme.backgroundColor),
                children: [
                  for (var subItem in item.subItems)
                    _buildList(
                      selectedItem: selectedItem,
                      isFirstItem: isFirstItem,
                      item: subItem,
                      expanded: expanded,
                      isSubItem: true,
                    ),
                ],
              )
            : ListTile(
                shape: _dashboard.drawerOptions.tileShape,
                contentPadding: _dashboard.drawerOptions.tileContentPadding,
                onTap: () {
                  if (!screen.isDesktop) {
                    Navigator.of(screen.context).pop();
                  }
                  if (selectedItem.title != item.title) {
                    FlutterDashboardController.to.delegate?.toNamed(
                      "${DashboardRoutes.DASHBOARD}${item.page!.name}",
                    );
                  }
                },
                selected: item == selectedItem || item == selectedItem,
                leading: item == selectedItem || item == selectedItem
                    ? (item.selectedIcon ?? item.icon)
                    : item.icon,
                title: Text(
                  item.title,
                  textScaleFactor: Get.textScaleFactor,
                ),
              ),
      ),
    );
  }
}
