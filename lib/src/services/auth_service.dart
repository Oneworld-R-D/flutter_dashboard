part of 'flutter_dashboard_services.dart';

class FlutterDashboardAuthService extends GetxService
    with _FlutterDashboardAuthInsterface {
  static FlutterDashboardAuthService get to =>
      Get.find<FlutterDashboardAuthService>();

  FlutterDashboardUser? get rootUser =>
      FlutterDashboardMaterialApp.of(Get.context!)?.authConfig.rootUser;

  final RxBool allowUsersToLoginIntoDashboard = false.obs;

  String? authToken;

  bool get isAuthenticated {
    authToken = readAuthToken();
    if (authToken != null) {
      return true;
    } else {
      return false;
    }
  }

  FormGroup emailLoginForm = FormGroup(
    {
      'email': FormControl<String>(
        validators: [
          Validators.required,
          Validators.email,
        ],
      ),
      'password': FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(6),
          Validators.pattern(FlutterDashboardFormValidators.passwordPattern),
        ],
      ),
    },
  );

  FormGroup usernameLoginForm = FormGroup(
    {
      'username': FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),
      'password': FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(6),
          Validators.pattern(FlutterDashboardFormValidators.passwordPattern),
        ],
      ),
    },
  );

  @override
  void onInit() {
    authToken = readAuthToken();
    super.onInit();
  }

  @override
  Future<bool> register(Map<String, dynamic> registrationPayload) async {
    if (FlutterDashboardMaterialApp.of(Get.context!)!
                .authConfig
                .overrideRegisterFunction !=
            null &&
        rootUser == null) {
      return await FlutterDashboardMaterialApp.of(Get.context!)!
          .authConfig
          .overrideRegisterFunction!(registrationPayload);
    } else {
      return await super.register(registrationPayload);
    }
  }

  @override
  Future<bool?> login(Map<String, dynamic> credential) async {
    try {
      if (FlutterDashboardMaterialApp.of(Get.context!)!
                  .authConfig
                  .overrideLoginFunction !=
              null &&
          rootUser == null) {
        return await FlutterDashboardMaterialApp.of(Get.context!)!
            .authConfig
            .overrideLoginFunction!(credential);
      } else {
        if (rootUser != null) {
          return await Future.delayed(2.seconds, () async {
            if (rootUser?.email == credential['email'] &&
                rootUser?.password == credential['password']) {
              saveAuthToken('root-admin-token');
              // print(readAuthToken());
              return true;
            } else {
              return await super.login(credential);
            }
          });
        } else {
          return null;
        }
      }
    } catch (e) {
      Get.log('Login error');
    }
  }

  @override
  Future<void> logout() async {
    if (FlutterDashboardMaterialApp.of(Get.context!)!
                .authConfig
                .overrideLogoutFunction !=
            null &&
        rootUser == null) {
      await FlutterDashboardMaterialApp.of(Get.context!)!
          .authConfig
          .overrideLogoutFunction!()
          .then((bool _response) async {
        if (_response) {
          removeAuthToken();
          Get.resetRootNavigator();
          await Future.delayed(2000.milliseconds, () {
            Get.rootDelegate.toNamed(DashboardRoutes.LOGIN);
          });
        }
      });
    } else {
      removeAuthToken();
      Get.resetRootNavigator();
      await Future.delayed(2.seconds, () {
        Get.rootDelegate.toNamed(DashboardRoutes.LOGIN);
      });
    }
  }
}
