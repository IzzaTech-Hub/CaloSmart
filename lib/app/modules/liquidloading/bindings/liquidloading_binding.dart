import 'package:get/get.dart';

import '../controllers/liquidloading_controller.dart';

class LiquidloadingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LiquidloadingController>(
      () => LiquidloadingController(),
    );
  }
}
