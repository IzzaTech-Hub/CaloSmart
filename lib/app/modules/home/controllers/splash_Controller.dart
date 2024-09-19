import 'package:get/get.dart';
import 'package:calories_detector/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    goToNextPage();
  }

  void increment() => count.value++;

  void goToNextPage() async {
    await Future.delayed(const Duration(seconds: 5));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
    // Get.offNamed(Routes.HOME);
    // print("Went to Home");
    if (isFirstLaunch) {
      await prefs.setBool('isFirstLaunch', false);
      Get.offNamed(Routes
          .GOAL_SCREEN);
      print("Navigated to Goal Route");
    } else {
      Get.offNamed(Routes.HOME);
      // Get.offNamed(Routes.GOAL_SCREEN);
      print("Went to Home");
    }
  }
}
