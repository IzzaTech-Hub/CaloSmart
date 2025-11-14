import 'package:calories_detector/app/premium/premium.dart';
import 'package:calories_detector/app/premium/trailbase.dart';
import 'package:get/get.dart';

class StreakController extends GetxController {
  int totalDays = 366;
  RxInt? currentDay = (Premium.instance.currentStreak!.value).obs;

  //TODO: Implement StreakController

  final count = 0.obs;
  @override
  void onInit() async {
    currentDay!.value = await StreakManager.getCurrentStreak();

    super.onInit();
  }



  void increment() => count.value++;
}
