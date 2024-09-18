import 'package:get/get.dart';

import '../controllers/response_screen_controller.dart';

class ResponseScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResponseScreenController>(
      () => ResponseScreenController(),
    );
  }
}
