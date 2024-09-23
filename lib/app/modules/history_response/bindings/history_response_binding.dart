import 'package:get/get.dart';

import '../controllers/history_response_controller.dart';

class HistoryResponseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryResponseController>(
      () => HistoryResponseController(),
    );
  }
}
