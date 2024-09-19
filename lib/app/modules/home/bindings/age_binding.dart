// File: history_view_binding.dart
import 'package:calories_detector/app/modules/home/controllers/age_controller.dart';
import 'package:get/get.dart';

class AgeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AgeController>(
      () => AgeController(),
    );
  }
}
