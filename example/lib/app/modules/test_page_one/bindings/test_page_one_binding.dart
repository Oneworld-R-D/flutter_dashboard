import 'package:get/get.dart';

import '../controllers/test_page_one_controller.dart';

class TestPageOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TestPageOneController>(
      () => TestPageOneController(),
    );
  }
}
