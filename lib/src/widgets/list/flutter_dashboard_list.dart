library flutter_dashboard_list;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part './grid.dart';

typedef FlutterDashboardListWidgetBuilder = Widget Function(BuildContext, int);

enum FlutterDashboardListType {
  Normal,
  Grid,
  Custom,
}

// ignore: must_be_immutable
class FlutterDashboardListView<T> extends GetResponsiveView<T> {
  bool? isSliverItem;
  Iterable<T>? items;
  int? childCount;
  EdgeInsetsGeometry? padding;
  FlutterDashboardListWidgetBuilder? buildItem;
  FlutterDashboardListWidgetBuilder? dividerBuilder;
  List<Widget>? slivers;
  ScrollPhysics? physics;
  Axis? scrollDirection;
  ScrollBehavior? scrollBehavior;
  bool? shrinkWrap;
  bool? reverse;
  FlutterDashboardListType listType;
  SliverGridDelegate? gridDelegate;

  FlutterDashboardListView.list({
    Key? key,
    required this.isSliverItem,
    this.items = const [],
    this.childCount = 0,
    this.padding,
    required this.buildItem,
    required this.listType,
  }) : super(key: key) {
    slivers = const [];
    physics = null;
    scrollDirection = null;
    scrollBehavior = null;
    shrinkWrap = null;
    reverse = null;
    dividerBuilder = null;
    gridDelegate = null;
  }

  FlutterDashboardListView.grid({
    Key? key,
    required this.isSliverItem,
    this.items = const [],
    this.childCount = 0,
    this.padding,
    required this.buildItem,
    required this.listType,
    required this.dividerBuilder,
    this.physics,
    this.scrollDirection,
    this.shrinkWrap,
    this.reverse,
    this.gridDelegate,
  }) : super(key: key) {
    slivers = const [];
    scrollBehavior = null;
  }

  FlutterDashboardListView({
    Key? key,
    required this.slivers,
    this.physics,
    this.scrollDirection,
    this.scrollBehavior,
    this.shrinkWrap,
    this.reverse,
    required this.listType,
  }) : super(key: key) {
    buildItem = null;
    isSliverItem = false;
    items = null;
    childCount = null;
    padding = null;
    dividerBuilder = null;
    gridDelegate = null;
  }

  @override
  Widget build(BuildContext context) {
    screen.context = context;
    if (buildItem != null && listType == FlutterDashboardListType.Grid) {
      if (isSliverItem!) {
        return SliverPadding(
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
          sliver: SliverGrid(
            gridDelegate: gridDelegate ??
                FlutterDashboardGridDelegates.responsive(
                  screen: screen,
                  length: childCount,
                ),
            delegate: SliverChildBuilderDelegate(
              buildItem!,
              childCount: childCount,
            ),
          ),
        );
      } else {
        return Padding(
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
          child: GridView.builder(
            physics: physics,
            scrollDirection: scrollDirection ?? Axis.vertical,
            shrinkWrap: shrinkWrap ?? true,
            gridDelegate: gridDelegate ??
                FlutterDashboardGridDelegates.responsive(
                  screen: screen,
                  length: childCount,
                ),
            itemBuilder: buildItem!,
            itemCount: childCount,
          ),
        );
      }
    } else if (buildItem != null &&
        listType == FlutterDashboardListType.Normal) {
      if (isSliverItem!) {
        return SliverPadding(
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              buildItem!,
              childCount: childCount,
            ),
          ),
        );
      } else {
        return Padding(
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
          child: ListView.separated(
            physics: physics,
            scrollDirection: scrollDirection ?? Axis.vertical,
            shrinkWrap: shrinkWrap ?? true,
            itemBuilder: buildItem!,
            itemCount: childCount ?? 0,
            separatorBuilder: dividerBuilder ??
                (_, __) => const Divider(
                      color: Colors.transparent,
                      height: 5,
                    ),
          ),
        );
      }
    } else {
      return CustomScrollView(
        controller: ScrollController(),
        physics: physics,
        scrollDirection: scrollDirection ?? Axis.vertical,
        scrollBehavior: scrollBehavior ??
            ScrollConfiguration.of(context)
                .copyWith(dragDevices: PointerDeviceKind.values.toSet()),
        shrinkWrap: shrinkWrap ?? true,
        slivers: slivers ?? [],
      );
    }
  }
}
