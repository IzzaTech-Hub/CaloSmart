import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController {
  var selectedGoal = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadSelectedGoal();
  }

  Future<void> loadSelectedGoal() async {
    final prefs = await SharedPreferences.getInstance();
    selectedGoal.value = prefs.getString('selected_button') ?? 'Gain Weight';
  }

  Future<void> saveSelectedGoal(String goal) async {
    final prefs = await SharedPreferences.getInstance();
    selectedGoal.value = goal;
    await prefs.setString('selected_button', goal);
  }
}
