// File: history_view_binding.dart
import 'package:calories_detector/app/modules/home/controllers/gender_controller.dart';
import 'package:get/get.dart';

class GenderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenderController>(
      () => GenderController(),
    );
  }
}
