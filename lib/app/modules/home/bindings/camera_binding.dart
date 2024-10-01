// File: history_view_binding.dart
import 'package:calories_detector/app/modules/home/controllers/camera_controller.dart';
import 'package:calories_detector/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class CameraBinding extends Bindings {
  @override
  void dependencies() {

    //  Get.put(HomeController());
    
    Get.lazyPut<CameraViewController>(
      () => CameraViewController(),
    );
  }
}
