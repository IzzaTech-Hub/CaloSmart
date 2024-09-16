import 'package:get/get.dart';
import 'package:calories_detector/app/routes/app_pages.dart';

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
    Get.offNamed(Routes.HOME);
    print("Went to Home");
  }
}
