import 'package:flutter/material.dart';
import 'package:flutter_dashboard/src/auth/auth.dart';
import 'package:flutter_dashboard/src/dashboard/models/models.dart';

class FlutterDashboarAuthConfig {
  final String? loginUrl;
  final FlutterDashboardUser? rootUser;
  final Future<bool> Function(Map<String, dynamic>)? overrideRegisterFunction;
  final Future<bool> Function(Map<String, dynamic>)? overrideLoginFunction;
  final FlutterDashboardLoginView? overrideLoginView;
  final Future<bool> Function()? overrideLogoutFunction;
  final double? logoSize;
  final InputDecoration? emailInputDecoration;
  final InputDecoration? passwordInputDecoration;
  final InputDecoration? usernameInputDecoration;
  final FormInputDecoration? inputDecorationTheme;
  final bool useUserNameAuth;
  final IconData visiblePasswordIcon;
  final IconData obsecurePasswordIcon;

  FlutterDashboarAuthConfig({
    this.loginUrl,
    this.overrideRegisterFunction,
    this.overrideLoginFunction,
    this.overrideLogoutFunction,
    this.overrideLoginView,
    this.logoSize,
    this.emailInputDecoration,
    this.passwordInputDecoration,
    this.usernameInputDecoration,
    this.inputDecorationTheme = const FormInputDecoration(),
    this.rootUser,
    this.useUserNameAuth = false,
    this.visiblePasswordIcon = Icons.visibility,
    this.obsecurePasswordIcon = Icons.visibility_off,
  })  : assert(
          overrideLoginFunction == null || loginUrl == null,
          'Can not provide both loginUrl and overrideLoginFunction',
        ),
        assert(
          overrideLoginFunction == null || rootUser == null,
          'Can not provide both rootUser and overrideLoginFunction',
        );
}

class FormInputDecoration {
  final bool? filled;
  final InputBorder? border;
  final TextStyle? hintStyle;

  const FormInputDecoration({
    this.filled,
    this.border,
    this.hintStyle,
  });
}
