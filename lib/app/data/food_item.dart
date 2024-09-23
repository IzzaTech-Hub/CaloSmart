class FoodItem {
  String name;
  String quantity;
  int fat;
  int carbs;
  int protein;
  double waterquantity;
  double exercise;

  // Calculated values
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
        percentageCaloriesFromCarbs =
            ((carbs * 4) * 100 / ((carbs * 4) + (protein * 4) + (fat * 9)))
                .round(),
        percentageCaloriesFromProtein =
            ((protein * 4) * 100 / ((carbs * 4) + (protein * 4) + (fat * 9)))
                .round(),
        percentageCaloriesFromFat = 100 -
            (((carbs * 4) * 100 / ((carbs * 4) + (protein * 4) + (fat * 9)))
                    .round() +
                ((protein * 4) * 100 /
                        ((carbs * 4) + (protein * 4) + (fat * 9)))
                    .round());

  // Factory constructor for creating an instance from JSON
  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      name: json['name'],
      quantity: json['quantity'],
      fat: json['fat'],
      carbs: json['carbs'],
      protein: json['protein'],
      waterquantity: (json['waterquantity'] as num).toDouble(),
      exercise: (json['exercise'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'fat': fat,
      'carbs': carbs,
      'protein': protein,
      'waterquantity': waterquantity,
      'exercise': exercise,
      'caloriesFromCarbs': caloriesFromCarbs,
      'caloriesFromProtein': caloriesFromProtein,
      'caloriesFromFat': caloriesFromFat,
      'totalCalories': totalCalories,
      'percentageCaloriesFromCarbs': percentageCaloriesFromCarbs,
      'percentageCaloriesFromProtein': percentageCaloriesFromProtein,
      'percentageCaloriesFromFat': percentageCaloriesFromFat,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'fat': fat,
      'carbs': carbs,
      'protein': protein,
      'waterquantity': waterquantity,
      'exercise': exercise,
      'caloriesFromCarbs': caloriesFromCarbs,
      'caloriesFromProtein': caloriesFromProtein,
      'caloriesFromFat': caloriesFromFat,
      'totalCalories': totalCalories,
      'percentageCaloriesFromCarbs': percentageCaloriesFromCarbs,
      'percentageCaloriesFromProtein': percentageCaloriesFromProtein,
      'percentageCaloriesFromFat': percentageCaloriesFromFat,
    };
  }

  factory FoodItem.fromMap(Map<String, dynamic> map) {
    return FoodItem(
      name: map['name'],
      quantity: map['quantity'],
      fat: map['fat'],
      carbs: map['carbs'],
      protein: map['protein'],
      waterquantity: map['waterquantity'],
      exercise: map['exercise'],
    );
  }
}

class FoodData {
  FoodItem item;
  FoodItem alternate1;
  String description;

  FoodData({
    required this.item,
    required this.alternate1,
    required this.description,
  });

  factory FoodData.fromJson(Map<String, dynamic> json) {
    return FoodData(
      item: FoodItem.fromJson(json['item']),
      alternate1: FoodItem.fromJson(json['alternate1']),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item': item.toJson(),
      'alternate1': alternate1.toJson(),
      'description': description,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'item': item.toMap(),
      'alternate1': alternate1.toMap(),
      'description': description,
    };
  }

  factory FoodData.fromMap(Map<String, dynamic> map) {
    return FoodData(
      item: FoodItem.fromMap(map['item']),
      alternate1: FoodItem.fromMap(map['alternate1']),
      description: map['description'],
    );
  }
}
