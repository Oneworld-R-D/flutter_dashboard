part of '../auth.dart';

class LoginController extends GetxController {
  FlutterDashboardAuthService authController = FlutterDashboardAuthService.to;

  late FormGroup loginFom;

  final RxBool isPasswordVisible = false.obs;

  void checkUserAndNavigate() async {
    await Future.delayed(300.milliseconds, () {
      String? afterLoginRoute;

      // print(Get.rootDelegate.parameters);

      if (Get.rootDelegate.parameters.containsKey('then')) {
        afterLoginRoute = Get.rootDelegate.parameters['then']!;
      }

      // print(afterLoginRoute);

      if (afterLoginRoute != null) {
        Get.rootDelegate.toNamed(afterLoginRoute);
      } else {
        Get.rootDelegate.toNamed(DashboardRoutes.DASHBOARD);
      }
    });
  }

  @override
  void onInit() {
    if (FlutterDashboardMaterialApp.of(Get.context!)!
        .authConfig
        .useUserNameAuth) {
      loginFom = authController.usernameLoginForm;
    } else {
      loginFom = authController.emailLoginForm;
    }
    super.onInit();
  }

  Future<void> loginUser() async {
    if (loginFom.valid) {
      await authController.login(loginFom.value).then((bool? _isLoginSuccess) {
        if (_isLoginSuccess != null) {
          if (_isLoginSuccess) {
            checkUserAndNavigate();
          } else {
            Get.showSnackbar(GetSnackBar(
              title: 'Error',
              message: 'Invalid credential',
              snackbarStatus: (SnackbarStatus? status) async {
                if (status != null) {
                  if (status == SnackbarStatus.OPEN) {
                    await Future.delayed(2.seconds, () {
                      Get.closeCurrentSnackbar();
                    });
                  }
                }
              },
            ));
          }
        } else {
          Get.showSnackbar(GetSnackBar(
            title: 'Error',
            message: 'Please provide a rootUser credential under authconfig.',
            snackbarStatus: (SnackbarStatus? status) async {
              if (status != null) {
                if (status == SnackbarStatus.OPEN) {
                  await Future.delayed(2.seconds, () {
                    Get.closeCurrentSnackbar();
                  });
                }
              }
            },
          ));
        }
      });
    } else {
      loginFom.markAllAsTouched();
    }
  }
}
