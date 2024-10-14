import 'package:calories_detector/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:calories_detector/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  final count = 0.obs;

  @override
  void onInit() async {
    //      DatabaseHelper().deleteDatabaseFile;
    // DatabaseHelper2().deleteDatabaseFile;
    // await DatabaseHelper().database;
    // await DatabaseHelper2().database;

    // DatabaseHelper().deleteDatabaseFile();
    // DatabaseHelper2().deleteDatabaseFile();
    super.onInit();
    goToNextPage();
  }

  void increment() => count.value++;

  void goToNextPage() async {
    await Future.delayed(const Duration(seconds: 5));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    // if (0==0) {
    if (isFirstLaunch) {
      await prefs.setBool('isFirstLaunch', false);
      Get.offNamed(Routes.GOAL_SCREEN);
      print("Navigated to Goal Route");
     
    } else {
      Get.offNamed(Routes.NAVBAR);
      // Get.offNamed(Routes.GOAL_SCREEN);
      print("Went to Home");
      Get.put<HomeController>(
        HomeController(false),
      );
    }
  }
}
