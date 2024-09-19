// File: history_view_binding.dart
import 'package:calories_detector/app/modules/home/controllers/goal_controller.dart';
import 'package:get/get.dart';

class GoalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GoalController>(
      () => GoalController(),
    );
  }
}
