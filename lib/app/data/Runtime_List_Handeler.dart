import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'food_item.dart';
import '../data/Data_Base.dart';

RxList<FoodData> foodList = <FoodData>[].obs;

Future<List<FoodData>> getFoodData() async {
  final db = await DatabaseHelper().database;

  // Query the database for all rows
  final List<Map<String, dynamic>> maps = await db.query('food_data');

  // Convert List<Map<String, dynamic>> to List<FoodData>
  return List.generate(maps.length, (i) {
    // Extract each row from the database
    final map = maps[i];

    // Create FoodItem objects for main item and alternates
    final item = FoodItem.fromMap({
      'name': map['itemName'],
      'quantity': map['itemQuantity'],
      'fat': map['itemFat'],
      'carbs': map['itemCarbs'],
      'protein': map['itemProtein'],
      'waterquantity': map['itemWaterquantity'],
      'exercise': map['itemExercise'],
      'caloriesFromCarbs': map['itemCaloriesFromCarbs'],
      'caloriesFromProtein': map['itemCaloriesFromProtein'],
      'caloriesFromFat': map['itemCaloriesFromFat'],
      'totalCalories': map['itemTotalCalories'],
      'percentageCaloriesFromCarbs': map['itemPercentageCaloriesFromCarbs'],
      'percentageCaloriesFromProtein': map['itemPercentageCaloriesFromProtein'],
      'percentageCaloriesFromFat': map['itemPercentageCaloriesFromFat'],
    });

    final alternate1 = FoodItem.fromMap({
      'name': map['alternate1Name'],
      'quantity': map['alternate1Quantity'],
      'fat': map['alternate1Fat'],
      'carbs': map['alternate1Carbs'],
      'protein': map['alternate1Protein'],
      'waterquantity': map['alternate1Waterquantity'],
      'exercise': map['alternate1Exercise'],
      'caloriesFromCarbs': map['alternate1CaloriesFromCarbs'],
      'caloriesFromProtein': map['alternate1CaloriesFromProtein'],
      'caloriesFromFat': map['alternate1CaloriesFromFat'],
      'totalCalories': map['alternate1TotalCalories'],
      'percentageCaloriesFromCarbs':
          map['alternate1PercentageCaloriesFromCarbs'],
      'percentageCaloriesFromProtein':
          map['alternate1PercentageCaloriesFromProtein'],
      'percentageCaloriesFromFat': map['alternate1PercentageCaloriesFromFat'],
    });

    final alternate2 = FoodItem.fromMap({
      'name': map['alternate2Name'],
      'quantity': map['alternate2Quantity'],
      'fat': map['alternate2Fat'],
      'carbs': map['alternate2Carbs'],
      'protein': map['alternate2Protein'],
      'waterquantity': map['alternate2Waterquantity'],
      'exercise': map['alternate2Exercise'],
      'caloriesFromCarbs': map['alternate2CaloriesFromCarbs'],
      'caloriesFromProtein': map['alternate2CaloriesFromProtein'],
      'caloriesFromFat': map['alternate2CaloriesFromFat'],
      'totalCalories': map['alternate2TotalCalories'],
      'percentageCaloriesFromCarbs':
          map['alternate2PercentageCaloriesFromCarbs'],
      'percentageCaloriesFromProtein':
          map['alternate2PercentageCaloriesFromProtein'],
      'percentageCaloriesFromFat': map['alternate2PercentageCaloriesFromFat'],
    });

    final alternate3 = FoodItem.fromMap({
      'name': map['alternate3Name'],
      'quantity': map['alternate3Quantity'],
      'fat': map['alternate3Fat'],
      'carbs': map['alternate3Carbs'],
      'protein': map['alternate3Protein'],
      'waterquantity': map['alternate3Waterquantity'],
      'exercise': map['alternate3Exercise'],
      'caloriesFromCarbs': map['alternate3CaloriesFromCarbs'],
      'caloriesFromProtein': map['alternate3CaloriesFromProtein'],
      'caloriesFromFat': map['alternate3CaloriesFromFat'],
      'totalCalories': map['alternate3TotalCalories'],
      'percentageCaloriesFromCarbs':
          map['alternate3PercentageCaloriesFromCarbs'],
      'percentageCaloriesFromProtein':
          map['alternate3PercentageCaloriesFromProtein'],
      'percentageCaloriesFromFat': map['alternate3PercentageCaloriesFromFat'],
    });

    // Create FoodData object from FoodItem objects
    return FoodData(
      item: item,
      alternate1: alternate1,
      alternate2: alternate2,
      alternate3: alternate3,
    );
  });
}

Future<List<FoodData>> fetchFoodData() async {
  DatabaseHelper dbHelper = DatabaseHelper();
  final List<FoodData> fooddatalist = await dbHelper.fetchFoodData();

  // Map each entry in the list to a FoodData object, safely handling nulls
  return fooddatalist;
}
