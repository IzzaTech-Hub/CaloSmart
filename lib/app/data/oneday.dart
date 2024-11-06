import 'package:calories_detector/app/data/Data_Base.dart';
import 'package:calories_detector/app/data/day_base.dart';
import 'package:calories_detector/app/data/food_item.dart';
import 'package:calories_detector/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class OneDay {
  String date;
  RxInt caloriestarget;
  RxDouble watertarget;
  RxDouble exercisetarget;
  RxInt fattarget;
  RxInt protientarget;
  RxInt carbstarget;

  RxInt caloriesProgress = 0.obs;
  RxDouble waterProgress = 0.0.obs;
  RxDouble exerciseProgress = 0.0.obs;
  RxInt fatProgress = 0.obs;
  RxInt proteinProgress = 0.obs;
  RxInt carbsProgress = 0.obs;

  RxInt caloriesRemaining;
  RxDouble waterRemaining;
  RxDouble exerciseRemaining;
  RxInt fatRemaining;
  RxInt proteinRemaining;
  RxInt carbsRemaining;
  RxBool isRewardCollected=false.obs;

  List<int> indexes = [];
  List<FoodItem> fooditems = [];

  OneDay({
    required this.date,
    required int caloriestarget,
    required double watertarget,
    required double exercisetarget,
    required int fattarget,
    required int protientarget,
    required int carbstarget,
    // required bool isRewardCollected,
  })  : caloriestarget = caloriestarget.obs,
        watertarget = watertarget.obs,
        exercisetarget = exercisetarget.obs,
        fattarget = fattarget.obs,
        protientarget = protientarget.obs,
        carbstarget = carbstarget.obs,
        caloriesRemaining = caloriestarget.obs,
        waterRemaining = watertarget.obs,
        exerciseRemaining = exercisetarget.obs,
        fatRemaining = fattarget.obs,
        proteinRemaining = protientarget.obs,
        carbsRemaining = carbstarget.obs;
  // isRewardCollected = isRewardCollected.obs;
  // isRewardCollected;

  Future<void> AddFoodItem(int index) async {
    FoodItem fooditem =
        (await DatabaseHelper().fetchFoodDataByIndex(index))!.item;

    caloriesProgress.value += fooditem.totalCalories;
    caloriesRemaining.value = caloriestarget.value - caloriesProgress.value;

    fatProgress.value += fooditem.fat.toInt();
    fatRemaining.value = fattarget.value - fatProgress.value;

    proteinProgress.value += fooditem.protein.toInt();
    proteinRemaining.value = protientarget.value - proteinProgress.value;

    carbsProgress.value += fooditem.carbs.toInt();
    carbsRemaining.value = carbstarget.value - carbsProgress.value;
    indexes.add(index);
    fooditems.add(fooditem);
  }

  void AddWater(double Water) async {
    waterProgress.value += Water;
    waterRemaining.value = watertarget.value - waterProgress.value;
    await DatabaseHelper2().updateOneDay(toDay!);
  }

  void AddExercise(double exeTime) async {
    exerciseProgress.value += exeTime;
    exerciseRemaining.value = exercisetarget.value - exerciseProgress.value;
    await DatabaseHelper2().updateOneDay(toDay!);
  }

  void update(OneDay newDay) {
    date = newDay.date;
    caloriestarget.value = newDay.caloriestarget.value;
    watertarget.value = newDay.watertarget.value;
    exercisetarget.value = newDay.exercisetarget.value;
    fattarget.value = newDay.fattarget.value;
    protientarget.value = newDay.protientarget.value;
    carbstarget.value = newDay.carbstarget.value;

    caloriesProgress.value = newDay.caloriesProgress.value;
    waterProgress.value = newDay.waterProgress.value;
    exerciseProgress.value = newDay.exerciseProgress.value;
    fatProgress.value = newDay.fatProgress.value;
    proteinProgress.value = newDay.proteinProgress.value;
    carbsProgress.value = newDay.carbsProgress.value;

    caloriesRemaining.value = newDay.caloriesRemaining.value;
    waterRemaining.value = newDay.waterRemaining.value;
    exerciseRemaining.value = newDay.exerciseRemaining.value;
    fatRemaining.value = newDay.fatRemaining.value;
    proteinRemaining.value = newDay.proteinRemaining.value;
    carbsRemaining.value = newDay.carbsRemaining.value;

    indexes = List.from(newDay.indexes);
    fooditems = List.from(newDay.fooditems);
  }
}
