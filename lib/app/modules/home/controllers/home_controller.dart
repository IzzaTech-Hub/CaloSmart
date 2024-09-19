import 'package:get/get.dart';


class FoodItem {
  String name;
  String quantity;
  int fat;
  int carbs;
  int protein;
  double waterquantity;
  double exercise;

  FoodItem({
    required this.name,
    required this.quantity,
    required this.fat,
    required this.carbs,
    required this.protein,
    required this.waterquantity,
    required this.exercise,
  });

  // Factory constructor for creating an instance from JSON
  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      name: json['name'],
      quantity: json['quantity'],
      fat: json['fat'],
      carbs: json['carbs'],
      protein: json['protein'],
      waterquantity: json['waterquantity'].toDouble(),
      exercise: json['exercise'].toDouble(),
    );
  }

  // Method for converting an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'fat': fat,
      'carbs': carbs,
      'protein': protein,
      'waterquantity': waterquantity,
      'exercise': exercise,
    };
  }
}

class FoodData {
  FoodItem item;
  FoodItem alternate1;
  FoodItem alternate2;
  FoodItem alternate3;

  FoodData({
    required this.item,
    required this.alternate1,
    required this.alternate2,
    required this.alternate3,
  });

  // Factory constructor for creating an instance from JSON
  factory FoodData.fromJson(Map<String, dynamic> json) {
    return FoodData(
      item: FoodItem.fromJson(json['item']),
      alternate1: FoodItem.fromJson(json['alternate1']),
      alternate2: FoodItem.fromJson(json['alternate2']),
      alternate3: FoodItem.fromJson(json['alternate3']),
    );
  }

  // Method for converting an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'item': item.toJson(),
      'alternate1': alternate1.toJson(),
      'alternate2': alternate2.toJson(),
      'alternate3': alternate3.toJson(),
    };
  }
}


class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;



  void increment() => count.value++;
}
