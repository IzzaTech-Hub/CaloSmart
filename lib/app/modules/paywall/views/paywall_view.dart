import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/paywall_controller.dart';

class PaywallView extends GetView<PaywallController> {
  const PaywallView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PaywallView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PaywallView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
