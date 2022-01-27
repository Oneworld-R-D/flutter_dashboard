part of '../auth.dart';

abstract class FlutterDashboardLoginView
    extends GetResponsiveView<LoginController> {
  FlutterDashboardLoginView({
    Key? key,
  }) : super(key: key);

  FlutterDashboardMaterialApp get dashboard =>
      FlutterDashboardMaterialApp.of(screen.context)!;

  Widget buildSubmitButton(
    BuildContext context,
  ) {
    final RxBool _isProcessing = false.obs;
    return Obx(
      () => Center(
        child: LoadingButton(
          onPressed: () async {
            _isProcessing(true);
            await controller
                .handleLogin()
                .whenComplete(() => _isProcessing(false));
          },
          defaultWidget: Text(
            'Login to Continue',
            textScaleFactor: Get.textScaleFactor,
            style: Theme.of(context).textTheme.button?.copyWith(
                  color: screen.context.isDarkMode
                      ? Theme.of(context).textTheme.button?.color
                      : Theme.of(context).scaffoldBackgroundColor,
                ),
          ),
          loadingWidget: CircularProgressIndicator(
            color: Theme.of(context).indicatorColor,
          ),
          color: _isProcessing.value
              ? Colors.transparent
              : Theme.of(context).primaryColor,
          type: _isProcessing.value
              ? LoadingButtonType.Outline
              : LoadingButtonType.Raised,
          borderRadius: Get.width * 1,
        ),
      ),
    );
  }

  List<Widget> buildSimpleContent() {
    return [
      Text(
        "Log in",
        textScaleFactor: Get.textScaleFactor,
        style: Theme.of(screen.context).textTheme.headline4?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      const Divider(
        color: Colors.transparent,
      ),
      Text(
        "Enter below details to continue ",
        textScaleFactor: Get.textScaleFactor,
        style: Theme.of(screen.context).textTheme.subtitle2?.copyWith(
              color: Theme.of(screen.context).disabledColor,
              fontWeight: FontWeight.normal,
            ),
      ),
    ];
  }

  FormGroup get loginForm => controller.loginFom;

  List<Widget> buildFormFields(FormGroup _form) {
    return [
      if (screen.isDesktop) const Spacer(),
      ...buildSimpleContent(),
      Divider(
        color: Colors.transparent,
        height: screen.isDesktop ? 100 : 50,
      ),
      ...buildForm(_form),
      const Divider(
        color: Colors.transparent,
        height: 80,
      ),
      buildSubmitButton(screen.context),
      if (screen.isDesktop) const Spacer(),
    ];
  }

  Widget emailField(FormGroup _form) {
    return ReactiveTextField(
      formControlName: 'email',
      validationMessages: (control) => {
        ValidationMessage.required: 'Email can not be empty'.tr,
        ValidationMessage.email: 'Must be a valid email'.tr,
      },
      onEditingComplete: () => _form.focus('password'),
      decoration: dashboard.authConfig.emailInputDecoration ??
          InputDecoration(
            label: const Text('Email'),
            hintText:
                'example@${dashboard.title.split(" ").first.toLowerCase()}.com',
          ),
    );
  }

  Widget userNameField(FormGroup _form) {
    return ReactiveTextField(
      formControlName: 'username',
      onEditingComplete: () => _form.focus('password'),
      validationMessages: (control) => {
        ValidationMessage.required: 'Username can not be empty'.tr,
      },
      decoration: dashboard.authConfig.emailInputDecoration ??
          const InputDecoration(
            label: Text('Username'),
            hintText: 'Enter your username',
          ),
    );
  }

  Widget passwordField(FormGroup _form) {
    return Obx(
      () => ReactiveTextField(
        formControlName: 'password',
        obscureText: !controller.isPasswordVisible.value,
        onEditingComplete: () => _form.unfocus(),
        validationMessages: (control) => {
          ValidationMessage.required: 'The password must not be empty'.tr,
          ValidationMessage.minLength:
              'The password must be at least 6 characters'.tr,
          ValidationMessage.pattern: 'Passowrd should be alphanumeric'.tr
        },
        decoration: dashboard.authConfig.passwordInputDecoration ??
            InputDecoration(
              label: const Text('Password'),
              hintText: 'Enter your password',
              suffixIcon: IconButton(
                onPressed: controller.isPasswordVisible.toggle,
                icon: Icon(
                  controller.isPasswordVisible.value
                      ? dashboard.authConfig.obsecurePasswordIcon
                      : dashboard.authConfig.visiblePasswordIcon,
                  color: Theme.of(screen.context).disabledColor,
                ),
              ),
            ),
      ),
    );
  }

  List<Widget> buildForm(
    FormGroup _form,
  ) {
    return [
      if (!dashboard.authConfig.useUserNameAuth) emailField(_form),
      if (dashboard.authConfig.useUserNameAuth) userNameField(_form),
      const Divider(
        color: Colors.transparent,
        height: 30,
      ),
      passwordField(_form),
    ];
  }

  Widget formView(BuildContext context,
      {required FormGroup form, required bool isDesktop}) {
    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: InputDecorationTheme(
          filled: dashboard.authConfig.inputDecorationTheme?.filled ?? false,
          hintStyle: dashboard.authConfig.inputDecorationTheme?.hintStyle,
          border: dashboard.authConfig.inputDecorationTheme?.border ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Theme.of(context).dividerColor.withOpacity(0.1),
                ),
              ),
          enabledBorder: dashboard.authConfig.inputDecorationTheme?.border ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Theme.of(context).dividerColor.withOpacity(0.1),
                ),
              ),
          focusedBorder: dashboard.authConfig.inputDecorationTheme?.border ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Theme.of(context).dividerColor.withOpacity(0.1),
                ),
              ),
          focusedErrorBorder:
              dashboard.authConfig.inputDecorationTheme?.border ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).dividerColor.withOpacity(0.1),
                    ),
                  ),
          disabledBorder: dashboard.authConfig.inputDecorationTheme?.border ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Theme.of(context).dividerColor.withOpacity(0.1),
                ),
              ),
          errorBorder: (dashboard.authConfig.inputDecorationTheme?.border ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).dividerColor.withOpacity(0.1),
                    ),
                  ))
              .copyWith(
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
        ),
      ),
      child: SizedBox(
        width: isDesktop ? screen.width * 0.4 : Get.width * 0.85,
        child: Column(
          crossAxisAlignment:
              isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          mainAxisAlignment:
              isDesktop ? MainAxisAlignment.start : MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: buildFormFields(form),
        ),
      ),
    );
  }

  Widget buildBrandLogo(bool isDesktop) {
    return Center(
      child: SizedBox.square(
        dimension: dashboard.authConfig.logoSize ??
            (isDesktop
                ? screen.width <= 1920
                    ? Get.width * 0.3
                    : 580
                : 250),
        child: dashboard.config.brandLogo,
      ),
    );
  }

  Widget buildDefaultView(BuildContext context, {required FormGroup form}) {
    return CustomScrollView(
      controller: ScrollController(),
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: buildBrandLogo(screen.isDesktop),
        ),
        SliverToBoxAdapter(
          child: Center(
            child: formView(
              context,
              form: form,
              isDesktop: false,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDesktopView(BuildContext context, {required FormGroup form}) {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.02,
          vertical: Get.height * 0.05,
        ),
        child: Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                  ),
                  child: SizedBox(
                    height: double.maxFinite,
                    child: Center(
                      child: formView(
                        context,
                        form: form,
                        isDesktop: screen.isDesktop,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: SizedBox(
                    height: double.maxFinite,
                    child: buildBrandLogo(screen.isDesktop),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBody(
      {FormGroup? customLoginForm,
      Widget Function(BuildContext, FormGroup, Widget?)? builder}) {
    return ReactiveFormBuilder(
      form: () => customLoginForm ?? loginForm,
      builder: builder ??
          (BuildContext context, FormGroup _form, Widget? child) {
            return screen.isDesktop
                ? buildDesktopView(
                    context,
                    form: _form,
                  )
                : buildDefaultView(
                    context,
                    form: _form,
                  );
          },
    );
  }

  @override
  Widget build(BuildContext context) {
    screen.context = context;
    return Scaffold(
      body: buildBody(),
    );
  }
}

class FlutterDashboardDefaultLoginView extends FlutterDashboardLoginView {
  FlutterDashboardDefaultLoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }
}
