import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dashboard/src/dashboard/components/components.dart';
import 'package:get/get.dart';

class DashboardConfig {
  final Widget? brandLogo;
  final bool enableSpacing;
  final bool enableBodySpacing;
  final AppBarOptions? appBarOptions;
  final bool debugShowCheckedModeBanner;
  final SystemMouseCursor? mouseCursor;
  final bool hasScrollingBody;
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeMode themeMode;
  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final Locale? Function(List<Locale>?, Iterable<Locale>)?
      localeListResolutionCallback;
  final Locale? Function(Locale?, Iterable<Locale>)? localeResolutionCallback;
  final Locale? fallbackLocale;
  final Iterable<Locale> supportedLocales;
  final TextDirection? textDirection;
  final Translations? translations;
  final EdgeInsetsGeometry? dashboardContentPadding;
  final double? dashboardContentRadius;
  final EdgeInsetsGeometry? dashboardAppbarPadding;

  const DashboardConfig({
    this.brandLogo,
    this.appBarOptions,
    this.enableSpacing = true,
    this.enableBodySpacing = false,
    this.debugShowCheckedModeBanner = true,
    this.mouseCursor,
    this.dashboardContentRadius,
    this.hasScrollingBody = true,
    this.theme,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.fallbackLocale,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.textDirection,
    this.translations,
    this.dashboardContentPadding,
    this.dashboardAppbarPadding,
  });
}
