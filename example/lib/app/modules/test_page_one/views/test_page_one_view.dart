import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/test_page_one_controller.dart';

class TestPageOneView extends GetView<TestPageOneController> {
  const TestPageOneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TestPageOneView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TestPageOneView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
