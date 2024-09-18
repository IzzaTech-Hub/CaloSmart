// File: history_view_binding.dart
import 'package:calories_detector/app/modules/home/controllers/history_show_controller.dart';
import 'package:get/get.dart';

class HistoryshowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryShowController>(
      () => HistoryShowController(),
    );
  }
}
