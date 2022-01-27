part of './components.dart';

typedef FlutterDashboardContentWidgetBuilder = Widget;

abstract class _FlutterDashboardContentMain<T>
    extends GetResponsiveView<FlutterDashboardController> {
  _FlutterDashboardContentMain({
    Key? key,
  }) : super(key: key);

  final String? controllerTag = null;

  FlutterDashboardController get dashboardController => controller;

  T get pageController => GetInstance().find<T>(tag: controllerTag)!;

  Future<T> goToNextPage(
    String page, {
    dynamic arguments,
    Map<String, String>? parameters,
  }) =>
      Get.rootDelegate.toNamed(
        page,
        arguments: arguments,
        parameters: parameters,
      );

  EdgeInsetsGeometry bodyPadding(BuildContext context) =>
      FlutterDashboardMaterialApp.of(context)!.config.enableBodySpacing &&
              screen.isDesktop
          ? (FlutterDashboardMaterialApp.of(context)!
                  .config
                  .dashboardContentPadding ??
              kDashboardContentPadding)
          : EdgeInsets.zero;

  MouseCursor get cursorStyle => SystemMouseCursors.basic;

  double radius(BuildContext context) =>
      FlutterDashboardMaterialApp.of(context)!.config.enableBodySpacing
          ? !screen.isDesktop
              ? 0
              : (FlutterDashboardMaterialApp.of(context)!
                      .config
                      .dashboardContentRadius ??
                  kDefaultRadius + 10)
          : 0;

  ShapeBorder shape(BuildContext context) => RoundedRectangleBorder(
        borderRadius:
            FlutterDashboardMaterialApp.of(context)!.config.enableSpacing
                ? BorderRadius.zero
                : BorderRadius.circular(radius(context)),
        side: const BorderSide(
          color: Colors.transparent,
          width: 0,
          style: BorderStyle.none,
        ),
      );

  @override
  Widget build(BuildContext context) {
    screen.context = context;
    return super.build(screen.context);
  }

  Color get backgroungColor => Theme.of(screen.context).cardColor;
}

mixin _FlutterDashboardContentMixin {
  FlutterDashboardContentWidgetBuilder? body(BuildContext context);
}

abstract class FlutterDashboardContent<T>
    extends _FlutterDashboardContentMain<T>
    implements _FlutterDashboardContentMixin {
  FlutterDashboardContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screen.context = context;
    return MouseRegion(
      cursor: cursorStyle,
      child: Padding(
        padding: EdgeInsets.only(
          left: bodyPadding(context).horizontal,
          right: bodyPadding(context).horizontal,
          bottom: bodyPadding(context).vertical == 0
              ? 0
              : bodyPadding(context).vertical + 10,
          top: bodyPadding(context).vertical == 0
              ? 0
              : bodyPadding(context).vertical + 2,
        ),
        child: Material(
          borderRadius: BorderRadius.circular(radius(context)),
          elevation: 10,
          clipBehavior: Clip.hardEdge,
          color: backgroungColor,
          child: body(context) ?? const SizedBox.shrink(),
        ),
      ),
    );
  }
}
