import 'package:get/get.dart';
import 'package:calories_detector/app/data/food_item.dart';

class ComparisonController extends GetxController {
  Rxn<FoodItem> food1 = Rxn<FoodItem>();
  Rxn<FoodItem> food2 = Rxn<FoodItem>();
  RxnString name = RxnString();
  RxnString description = RxnString();
  @override
  void onInit() {
    final arguments = Get.arguments;
    FoodItem first = arguments[0];
    FoodItem second = arguments[1];
    String function = arguments[2];
    String thisdescription = arguments[3];
    food1.value = first;
    food2.value = second;
    name.value = function;
    description.value = thisdescription;

    super.onInit();
  }

  final count = 0.obs;

  void increment() => count.value++;
}
