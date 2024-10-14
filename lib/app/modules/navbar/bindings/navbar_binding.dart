import 'package:calories_detector/app/modules/ResponseScreen/controllers/response_screen_controller.dart';
import 'package:calories_detector/app/modules/home/controllers/history_show_controller.dart';
import 'package:calories_detector/app/modules/liquidloading/controllers/liquidloading_controller.dart';
import 'package:calories_detector/app/modules/settings/controllers/settings_controller.dart';
import 'package:get/get.dart';

import '../controllers/navbar_controller.dart';

class NavbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavbarController>(
      () => NavbarController(),
    );
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
    // Get.put<HomeController>(
    //   HomeController(),
    // );
    Get.lazyPut<ResponseScreenController>(
      () => ResponseScreenController(),
    );
    // Get.lazyPut<HistoryShowController>(
    //   () => HistoryShowController(),
    // );
    Get.lazyPut<LiquidloadingController>(
      () => LiquidloadingController(),
    );
    Get.put(SettingsController());
    Get.put(HistoryShowController());
    // Get.lazyPut<HistoryShowController>(
    //   () => HistoryShowController(),
    // );
  }
}
