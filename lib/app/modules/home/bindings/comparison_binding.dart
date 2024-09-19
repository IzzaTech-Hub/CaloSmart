// File: history_view_binding.dart
import 'package:calories_detector/app/modules/home/controllers/comparison_controller.dart';
import 'package:get/get.dart';

class ComparisonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComparisonController>(
      () => ComparisonController(),
    );
  }
}
