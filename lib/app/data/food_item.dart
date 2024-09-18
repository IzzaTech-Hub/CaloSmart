class FoodItem {
  String name;
  String quantity;
  int fat;
  int carbs;
  int protein;
  double waterquantity;
  double exercise;
  
  // New fields for calculated values
  int caloriesFromCarbs;
  int caloriesFromProtein;
  int caloriesFromFat;
  int totalCalories;
  int percentageCaloriesFromCarbs;
  int percentageCaloriesFromProtein;
  int percentageCaloriesFromFat;

  FoodItem({
    required this.name,
    required this.quantity,
    required this.fat,
    required this.carbs,
    required this.protein,
    required this.waterquantity,
    required this.exercise,
  })  : caloriesFromCarbs = carbs * 4,
        caloriesFromProtein = protein * 4,
        caloriesFromFat = fat * 9,
        totalCalories = (carbs * 4) + (protein * 4) + (fat * 9),
        percentageCaloriesFromCarbs = ((carbs * 4) * 100 / ((carbs * 4) + (protein * 4) + (fat * 9))).round(),
        percentageCaloriesFromProtein = ((protein * 4) * 100 / ((carbs * 4) + (protein * 4) + (fat * 9))).round(),
        percentageCaloriesFromFat = 100 - (((carbs * 4) * 100 / ((carbs * 4) + (protein * 4) + (fat * 9))).round() + 
                                           ((protein * 4) * 100 / ((carbs * 4) + (protein * 4) + (fat * 9))).round());

  // Factory constructor for creating an instance from JSON
  factory FoodItem.fromJson(Map<String, dynamic> json) {
    int fat = json['fat'];
    int carbs = json['carbs'];
    int protein = json['protein'];
    return FoodItem(
      name: json['name'],
      quantity: json['quantity'],
      fat: fat,
      carbs: carbs,
      protein: protein,
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
      // Include the calculated fields in the JSON output as well
      'caloriesFromCarbs': caloriesFromCarbs,
      'caloriesFromProtein': caloriesFromProtein,
      'caloriesFromFat': caloriesFromFat,
      'totalCalories': totalCalories,
      'percentageCaloriesFromCarbs': percentageCaloriesFromCarbs,
      'percentageCaloriesFromProtein': percentageCaloriesFromProtein,
      'percentageCaloriesFromFat': percentageCaloriesFromFat,
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

