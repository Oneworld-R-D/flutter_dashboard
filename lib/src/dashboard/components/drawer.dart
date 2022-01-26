part of 'components.dart';

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
  final FlutterDashboardDrawerHeader? overrideHeader;
  final double? listSpacing;
  final EdgeInsetsGeometry tilePadding;
  final EdgeInsetsGeometry? tileContentPadding;
  final ShapeBorder? tileShape;

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
    this.overrideHeader,
    this.listSpacing,
    this.tilePadding = EdgeInsets.zero,
    this.tileContentPadding,
    this.tileShape,
  });
}

class _DrawerIcon extends StatelessWidget {
  const _DrawerIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        bool isDrawerOpen =
            FlutterDashboardController.to.drawerKey.currentState!.isDrawerOpen;
        if (!isDrawerOpen) {
          FlutterDashboardController.to.drawerKey.currentState?.openDrawer();
        } else {
          Navigator.of(context).pop();
        }
      },
      icon: Icon(
        Icons.menu_rounded,
        color: Theme.of(context).iconTheme.color,
      ),
    );
  }
}

class _DrawerCloseIcon extends StatelessWidget {
  final DrawerOptions options;
  const _DrawerCloseIcon({
    Key? key,
    required this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        bool isDrawerOpen =
            FlutterDashboardController.to.drawerKey.currentState!.isDrawerOpen;
        if (!isDrawerOpen) {
          FlutterDashboardController.to.drawerKey.currentState?.openDrawer();
        } else {
          Navigator.of(context).pop();
        }
      },
      padding: EdgeInsets.zero,
      icon: options.closeIcon ??
          Icon(
            Icons.clear,
            color: Theme.of(context).iconTheme.color,
          ),
    );
  }
}

abstract class FlutterDashboardDrawerHeader
    extends SliverPersistentHeaderDelegate {
  double? height;

  VoidCallback? onBrandLogoPressed;

  String get homeRoute => FlutterDashboardController.to.dashboardInitialRoute;

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
    return false;
  }
}

class _DrawerHeader extends FlutterDashboardDrawerHeader {
  final Widget? logo;
  final Widget? drawerIcon;
  final double statusBar;
  final bool isDesktop;

  _DrawerHeader({
    this.logo,
    this.drawerIcon,
    required this.statusBar,
    required this.isDesktop,
  });

  @override
  VoidCallback? get onBrandLogoPressed => () {
        Get.rootDelegate
            .toNamed(FlutterDashboardController.to.dashboardInitialRoute);
      };

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return DrawerHeader(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: isDesktop &&
                FlutterDashboardMaterialApp.of(context)!
                    .drawerOptions
                    .centerHeaderLogo
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onBrandLogoPressed,
            child: Align(
              alignment: isDesktop &&
                      FlutterDashboardMaterialApp.of(context)!
                          .drawerOptions
                          .centerHeaderLogo
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

class _FlutterDashboardDrawer extends StatelessWidget {
  final bool isDesktop;
  final Widget drawerIcon;

  const _FlutterDashboardDrawer({
    Key? key,
    required this.isDesktop,
    required this.drawerIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DrawerOptions _dashboardDrawer =
        FlutterDashboardMaterialApp.of(context)!.drawerOptions;

    final Widget? _brandLogo =
        FlutterDashboardMaterialApp.of(context)!.config.brandLogo;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: _dashboardDrawer.backgroundColor,
        image: _dashboardDrawer.image,
        gradient: _dashboardDrawer.gradient,
      ),
      child: Material(
        elevation:
            FlutterDashboardMaterialApp.of(context)!.config.theme != null ||
                    FlutterDashboardMaterialApp.of(context)!.config.darkTheme !=
                        null
                ? 0
                : FlutterDashboardMaterialApp.of(context)!.config.enableSpacing
                    ? 20
                    : 10,
        shape: FlutterDashboardMaterialApp.of(context)!.config.enableSpacing
            ? isDesktop
                ? Theme.of(context).drawerTheme.shape
                : const RoundedRectangleBorder()
            : const RoundedRectangleBorder(),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Theme.of(context).drawerTheme.backgroundColor,
        shadowColor: Theme.of(context).shadowColor,
        child: Drawer(
          elevation: FlutterDashboardMaterialApp.of(context)!.config.theme !=
                      null ||
                  FlutterDashboardMaterialApp.of(context)!.config.darkTheme !=
                      null
              ? 0
              : 10,
          backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
          shape: FlutterDashboardMaterialApp.of(context)!.config.enableSpacing
              ? isDesktop
                  ? Theme.of(context).drawerTheme.shape
                  : const RoundedRectangleBorder()
              : const RoundedRectangleBorder(),
          child: CustomScrollView(
            controller: ScrollController(),
            slivers: [
              SliverPersistentHeader(
                delegate: _dashboardDrawer.overrideHeader ??
                    _DrawerHeader(
                      logo: _brandLogo ?? _dashboardDrawer.logo,
                      statusBar: Get.mediaQuery.padding.top,
                      drawerIcon: !isDesktop ? drawerIcon : null,
                      isDesktop: isDesktop,
                    ),
              ),
              SliverToBoxAdapter(
                child: Divider(
                  color: Colors.transparent,
                  height: _dashboardDrawer.overrideHeader != null
                      ? _dashboardDrawer.listSpacing
                      : (_dashboardDrawer.listSpacing ?? 1),
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

List<FlutterDashboardItem> _expanded(List<FlutterDashboardItem> items) {
  return items
      .expand((FlutterDashboardItem element) =>
          element.subItems.isEmpty ? [element] : _expanded(element.subItems))
      .toList();
}

class _DrawerList extends GetResponsiveView<FlutterDashboardController> {
  _DrawerList();

  @override
  Widget build(BuildContext context) {
    screen.context = context;
    final List<FlutterDashboardItem> _items =
        FlutterDashboardMaterialApp.of(context)!.dashboardItems;

    final List<FlutterDashboardItem> _rootItems = _expanded(_items);

    return SliverList(
      delegate: SliverChildListDelegate(
        [
          if (FlutterDashboardMaterialApp.of(context)!
              .drawerOptions
              .headers
              .isNotEmpty)
            ...FlutterDashboardMaterialApp.of(context)!
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
          for (var _item in _items)
            Obx(
              () => _DrawerListTile(
                isFirstItem: _items.first.title == _item.title,
                item: _item,
                selectedItem: controller.selectedItem,
                expanded: _rootItems,
                isDesktop: screen.isDesktop,
                isSubItem: false,
              ),
            ),
        ],
      ),
    );
  }
}

class _DrawerListTile extends StatelessWidget {
  const _DrawerListTile({
    Key? key,
    required this.selectedItem,
    required this.isFirstItem,
    required this.item,
    required this.expanded,
    required this.isDesktop,
    required this.isSubItem,
  }) : super(key: key);

  final FlutterDashboardItem selectedItem;
  final bool isFirstItem;
  final FlutterDashboardItem item;
  final List<FlutterDashboardItem> expanded;
  final bool isDesktop;
  final bool isSubItem;

  List<FlutterDashboardItem> _expanded(List<FlutterDashboardItem> items) {
    return items
        .expand((FlutterDashboardItem element) =>
            element.subItems.isEmpty ? [element] : _expanded(element.subItems))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isFirstItem && isSubItem
          ? EdgeInsets.only(
              left: FlutterDashboardMaterialApp.of(context)!
                      .drawerOptions
                      .tilePadding
                      .horizontal -
                  (FlutterDashboardMaterialApp.of(context)!
                          .drawerOptions
                          .tilePadding
                          .horizontal /
                      2),
              right: FlutterDashboardMaterialApp.of(context)!
                      .drawerOptions
                      .tilePadding
                      .horizontal -
                  (FlutterDashboardMaterialApp.of(context)!
                          .drawerOptions
                          .tilePadding
                          .horizontal /
                      2),
              bottom: FlutterDashboardMaterialApp.of(context)!
                      .drawerOptions
                      .tilePadding
                      .vertical -
                  (FlutterDashboardMaterialApp.of(context)!
                          .drawerOptions
                          .tilePadding
                          .vertical /
                      2),
            )
          : isSubItem
              ? EdgeInsets.zero
              : FlutterDashboardMaterialApp.of(context)!
                  .drawerOptions
                  .tilePadding,
      child: Material(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: FlutterDashboardMaterialApp.of(context)!.drawerOptions.tileShape,
        child: Theme(
          data: Theme.of(context).copyWith(
            iconTheme: IconThemeData(
              color: Theme.of(context)
                  .textTheme
                  .button
                  ?.copyWith(
                      color: FlutterDashboardMaterialApp.of(context)!
                              .drawerOptions
                              .selectedTextColor ??
                          (item == selectedItem || item == selectedItem
                              ? Get.isDarkMode
                                  ? Theme.of(context).textTheme.button?.color
                                  : Theme.of(context).scaffoldBackgroundColor
                              : Theme.of(context).disabledColor))
                  .color,
            ),
            listTileTheme: ListTileThemeData(
              horizontalTitleGap: 0.0,
              tileColor: item == selectedItem || item == selectedItem
                  ? (FlutterDashboardMaterialApp.of(context)!
                          .drawerOptions
                          .selectedItemColor ??
                      Theme.of(context).drawerTheme.backgroundColor)
                  : ((FlutterDashboardMaterialApp.of(context)!
                                  .drawerOptions
                                  .unSelectedItemColor ==
                              Colors.transparent
                          ? Theme.of(context).drawerTheme.backgroundColor
                          : FlutterDashboardMaterialApp.of(context)!
                              .drawerOptions
                              .unSelectedItemColor) ??
                      Theme.of(context).drawerTheme.backgroundColor),
              selectedColor: item == selectedItem || item == selectedItem
                  ? (Theme.of(context)
                          .textTheme
                          .button
                          ?.copyWith(
                              color: FlutterDashboardMaterialApp.of(context)!
                                      .drawerOptions
                                      .selectedTextColor ??
                                  (item == selectedItem || item == selectedItem
                                      ? Get.isDarkMode
                                          ? Theme.of(context)
                                              .textTheme
                                              .button
                                              ?.color
                                          : Theme.of(context)
                                              .scaffoldBackgroundColor
                                      : Theme.of(context).disabledColor))
                          .color ??
                      Theme.of(context).primaryColor)
                  : (FlutterDashboardMaterialApp.of(context)!
                          .drawerOptions
                          .unSelectedItemColor ??
                      Theme.of(context).listTileTheme.selectedColor),
              selectedTileColor: item == selectedItem || item == selectedItem
                  ? (FlutterDashboardMaterialApp.of(context)!
                          .drawerOptions
                          .selectedItemColor ??
                      Theme.of(context).primaryColor)
                  : (FlutterDashboardMaterialApp.of(context)!
                          .drawerOptions
                          .unSelectedItemColor ??
                      Theme.of(context).listTileTheme.selectedTileColor),
              textColor: Theme.of(context)
                  .textTheme
                  .button
                  ?.copyWith(
                      color: FlutterDashboardMaterialApp.of(context)!
                              .drawerOptions
                              .selectedTextColor ??
                          (item == selectedItem || item == selectedItem
                              ? Get.isDarkMode
                                  ? Theme.of(context).textTheme.button?.color
                                  : Theme.of(context).scaffoldBackgroundColor
                              : Theme.of(context).disabledColor))
                  .color,
              iconColor: Theme.of(context)
                  .textTheme
                  .button
                  ?.copyWith(
                      color: FlutterDashboardMaterialApp.of(context)!
                              .drawerOptions
                              .selectedTextColor ??
                          (item == selectedItem || item == selectedItem
                              ? Get.isDarkMode
                                  ? Theme.of(context).textTheme.button?.color
                                  : Theme.of(context).scaffoldBackgroundColor
                              : Theme.of(context).disabledColor))
                  .color,
            ),
            dividerColor: Colors.transparent,
          ),
          child: item.subItems.isNotEmpty
              ? DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).drawerTheme.backgroundColor ??
                          Theme.of(context).primaryColor,
                    ),
                  ),
                  child: ExpansionTile(
                    title: Text(item.title),
                    maintainState: true,
                    initiallyExpanded: _expanded(item.subItems)
                        .any((element) => element == selectedItem),
                    leading: item.icon,
                    tilePadding: FlutterDashboardMaterialApp.of(context)!
                        .drawerOptions
                        .tileContentPadding,
                    childrenPadding: EdgeInsets.zero,
                    collapsedTextColor: Theme.of(context)
                        .textTheme
                        .button
                        ?.copyWith(
                            color: FlutterDashboardMaterialApp.of(context)!
                                    .drawerOptions
                                    .selectedTextColor ??
                                (item == selectedItem || item == selectedItem
                                    ? Get.isDarkMode
                                        ? Theme.of(context)
                                            .textTheme
                                            .button
                                            ?.color
                                        : Theme.of(context)
                                            .scaffoldBackgroundColor
                                    : Theme.of(context).disabledColor))
                        .color,
                    collapsedIconColor: Theme.of(context)
                        .textTheme
                        .button
                        ?.copyWith(
                            color: FlutterDashboardMaterialApp.of(context)!
                                    .drawerOptions
                                    .selectedTextColor ??
                                (item == selectedItem || item == selectedItem
                                    ? Get.isDarkMode
                                        ? Theme.of(context)
                                            .textTheme
                                            .button
                                            ?.color
                                        : Theme.of(context)
                                            .scaffoldBackgroundColor
                                    : Theme.of(context).disabledColor))
                        .color,
                    iconColor: FlutterDashboardMaterialApp.of(context)!
                            .drawerOptions
                            .selectedItemColor ??
                        Theme.of(context).indicatorColor,
                    textColor: FlutterDashboardMaterialApp.of(context)!
                            .drawerOptions
                            .selectedItemColor ??
                        Theme.of(context).indicatorColor,
                    backgroundColor: item == selectedItem ||
                            item == selectedItem
                        ? (FlutterDashboardMaterialApp.of(context)!
                                .drawerOptions
                                .selectedItemColor ??
                            Theme.of(context).drawerTheme.backgroundColor)
                        : ((FlutterDashboardMaterialApp.of(context)!
                                        .drawerOptions
                                        .unSelectedItemColor ==
                                    Colors.transparent
                                ? Theme.of(context).drawerTheme.backgroundColor
                                : FlutterDashboardMaterialApp.of(context)!
                                    .drawerOptions
                                    .unSelectedItemColor) ??
                            Theme.of(context).drawerTheme.backgroundColor),
                    children: [
                      for (var subItem in item.subItems)
                        _DrawerListTile(
                          isDesktop: isDesktop,
                          selectedItem: selectedItem,
                          isFirstItem: isFirstItem,
                          item: subItem,
                          expanded: expanded,
                          isSubItem: true,
                        ),
                    ],
                  ),
                )
              : ListTile(
                  contentPadding: FlutterDashboardMaterialApp.of(context)!
                      .drawerOptions
                      .tileContentPadding,
                  onTap: () {
                    if (!isDesktop) {
                      Navigator.of(context).pop();
                    }
                    if (selectedItem.title != item.title) {
                      FlutterDashboardController.to.delegate?.toNamed(
                        "${DashboardRoutes.DASHBOARD}${item.page!.name}",
                      );
                    }
                  },
                  selected: item == selectedItem || item == selectedItem,
                  dense: Get.context!.isPhone,
                  leading: item == selectedItem || item == selectedItem
                      ? (item.selectedIcon ?? item.icon)
                      : item.icon,
                  title: Text(
                    item.title,
                    textScaleFactor: Get.textScaleFactor,
                  ),
                ),
        ),
      ),
    );
  }
}
