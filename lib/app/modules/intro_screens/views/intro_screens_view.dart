import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/intro_screens_controller.dart';

class IntroScreensView extends GetView<IntroScreensController> {
  const IntroScreensView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IntroScreensView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'IntroScreensView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
