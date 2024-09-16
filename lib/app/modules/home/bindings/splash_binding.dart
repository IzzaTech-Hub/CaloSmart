import 'package:calories_detector/app/modules/home/controllers/splash_Controller.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
    
  }
}
