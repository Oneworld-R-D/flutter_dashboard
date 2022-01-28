import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/page1_controller.dart';

class Page1View extends GetView<Page1Controller> {
  const Page1View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page1View'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Page1View is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
