import 'package:get/get.dart';

import '../controllers/page1_controller.dart';

class Page1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Page1Controller>(
      () => Page1Controller(),
    );
  }
}
