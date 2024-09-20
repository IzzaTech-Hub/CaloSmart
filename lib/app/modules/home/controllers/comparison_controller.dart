import 'package:get/get.dart';
import 'package:calories_detector/app/data/Data_Base.dart';
import 'package:calories_detector/app/data/food_item.dart';

class ComparisonController extends GetxController {
  Rxn<FoodItem> food1 = Rxn<FoodItem>();
  Rxn<FoodItem> food2 = Rxn<FoodItem>();
  @override
  void onInit() {
    final arguments = Get.arguments;
    FoodItem first = arguments[0];
    FoodItem second = arguments[1];
    food1.value = first;
    food2.value = second;
    super.onInit();
  }

  final count = 0.obs;

  void increment() => count.value++;
}
