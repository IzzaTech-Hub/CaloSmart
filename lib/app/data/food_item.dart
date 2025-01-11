class FoodItem {
  String name;
  String quantity;
  double fat; // Changed from int to double
  double carbs; // Changed from int to double
  double protein; // Changed from int to double
  double waterQuantity;
  double exercise;

  // Calculated values
  int caloriesFromCarbs;
  int caloriesFromProtein;
  int caloriesFromFat;
  int totalCalories;
  int percentageCaloriesFromCarbs;
  int percentageCaloriesFromProtein;
  int percentageCaloriesFromFat;

  // New fields
  Map<String, String> vitamins;
  Map<String, String> minerals;
  Map<String, double> additionalNutrients;
  List<String> allergens;
  List<String> dietCompatibility;
  List<String> warnings;
  int healthScore;

  FoodItem({
    required this.name,
    required this.quantity,
    required this.fat,
    required this.carbs,
    required this.protein,
    required this.waterQuantity,
    required this.exercise,
    required this.vitamins,
    required this.minerals,
    required this.additionalNutrients,
    required this.allergens,
    required this.dietCompatibility,
    required this.warnings,
    required this.healthScore,
  })  : caloriesFromCarbs = (carbs * 4).toInt(),
        caloriesFromProtein = (protein * 4).toInt(),
        caloriesFromFat = (fat * 9).toInt(),
        totalCalories = (carbs * 4 + protein * 4 + fat * 9).toInt(),
        percentageCaloriesFromCarbs =
            ((carbs * 4) * 100 / (carbs * 4 + protein * 4 + fat * 9).toInt())
                .round(),
        percentageCaloriesFromProtein =
            ((protein * 4) * 100 / (carbs * 4 + protein * 4 + fat * 9).toInt())
                .round(),
        percentageCaloriesFromFat = 100 -
            ((((carbs * 4) * 100 / (carbs * 4 + protein * 4 + fat * 9).toInt())
                        .round() +
                    ((protein * 4) *
                            100 /
                            (carbs * 4 + protein * 4 + fat * 9).toInt())
                        .round())
                .round());

  // Factory constructor for creating an instance from JSON
  factory FoodItem.fromJson(Map<String, dynamic> json) {
    print('Starting JSON conversion...');

    // Assigning to temporary variables and printing them
    var tempName = json['name'] ?? 'Unknown';
    print('Name: $tempName');

    var tempQuantity = json['quantity'] ?? 'Unknown';
    print('Quantity: $tempQuantity');

    var tempFat = (json['macronutrients']['fat'] as num).toDouble();
    print('Fat: $tempFat');

    var tempCarbs = (json['macronutrients']['carbs'] as num).toDouble();
    print('Carbs: $tempCarbs');

    var tempProtein = (json['macronutrients']['protein'] as num).toDouble();
    print('Protein: $tempProtein');

    var tempWaterQuantity = (json['waterquantity'] as num?)?.toDouble() ?? 0.0;
    print('Water Quantity: $tempWaterQuantity');

    var tempExercise = (json['exercise'] as num?)?.toDouble() ?? 0.0;
    print('Exercise: $tempExercise');

    var tempVitamins =
        Map<String, String>.from(json['micronutrients']['vitamins'] ?? {});
    print('Vitamins: $tempVitamins');

    var tempMinerals =
        Map<String, String>.from(json['micronutrients']['minerals'] ?? {});
    print('Minerals: $tempMinerals');
    print(json['additionalNutrients']);
    print('Raw Cholesterol: ${json['additionalNutrients']['cholesterol']}');
    print('Raw Water Content: ${json['additionalNutrients']['waterContent']}');
    print('Raw Caffeine: ${json['additionalNutrients']['caffeine']}');

    var tempCholesterol = double.tryParse(json['additionalNutrients']
                    ['cholesterol']
                ?.replaceAll(RegExp('[^0-9.]'), '') ??
            '0') ??
        0.0;
    print('Cholesterol: $tempCholesterol');

    var tempWaterContent = double.tryParse(json['additionalNutrients']
                    ['waterContent']
                ?.replaceAll('%', '')
                ?.trim() ??
            '0') ??
        0.0;
    print('Water Content: $tempWaterContent');

    var tempCaffeine = double.tryParse(json['additionalNutrients']['caffeine']
                ?.replaceAll(RegExp('[^0-9.]'), '') ??
            '0') ??
        0.0;
    print('Caffeine: $tempCaffeine');

    var tempAllergens = List<String>.from(json['allergens'] ?? []);
    print('Allergens: $tempAllergens');

    var tempDietCompatibility =
        List<String>.from(json['dietCompatibility'] ?? []);
    print('Diet Compatibility: $tempDietCompatibility');

    var tempWarnings = List<String>.from(json['warnings'] ?? []);
    print('Warnings: $tempWarnings');

    var tempHealthScore = json['healthScore'] ?? 0;
    print('Health Score: $tempHealthScore');

    // Returning the FoodItem object
    return FoodItem(
      name: tempName,
      quantity: tempQuantity,
      fat: tempFat,
      carbs: tempCarbs,
      protein: tempProtein,
      waterQuantity: tempWaterQuantity,
      exercise: tempExercise,
      vitamins: tempVitamins,
      minerals: tempMinerals,
      additionalNutrients: {
        'cholesterol': tempCholesterol,
        'waterContent': tempWaterContent,
        'caffeine': tempCaffeine,
      },
      allergens: tempAllergens,
      dietCompatibility: tempDietCompatibility,
      warnings: tempWarnings,
      healthScore: tempHealthScore,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'fat': fat,
      'carbs': carbs,
      'protein': protein,
      'waterQuantity': waterQuantity,
      'exercise': exercise,
      'micronutrients': {
        'vitamins': vitamins,
        'minerals': minerals,
      },
      'additionalNutrients': additionalNutrients,
      'allergens': allergens,
      'dietCompatibility': dietCompatibility,
      'warnings': warnings,
      'healthScore': healthScore,
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
      'waterQuantity': waterQuantity,
      'exercise': exercise,
      'micronutrients': {
        'vitamins': vitamins,
        'minerals': minerals,
      },
      'additionalNutrients': additionalNutrients,
      'allergens': allergens,
      'dietCompatibility': dietCompatibility,
      'warnings': warnings,
      'healthScore': healthScore,
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
      waterQuantity: map['waterQuantity'],
      exercise: map['exercise'],
      vitamins: Map<String, String>.from(map['micronutrients']['vitamins']),
      minerals: Map<String, String>.from(map['micronutrients']['minerals']),
      additionalNutrients: Map<String, double>.from(map['additionalNutrients']),
      allergens: List<String>.from(map['allergens']),
      dietCompatibility: List<String>.from(map['dietCompatibility']),
      warnings: List<String>.from(map['warnings']),
      healthScore: map['healthScore'] ?? 0,
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

class CommpareItem {
  FoodItem item;
  String description;

  CommpareItem({
    required this.item,
    required this.description,
  });

  factory CommpareItem.fromJson(Map<String, dynamic> json) {
    print(json['comparison_description']);
    String descriptiont = json['comparison_description'];

    FoodItem itemt = FoodItem.fromJson(json['item']);
    print(json['food item done']);

    return CommpareItem(
      description: descriptiont,
      item: itemt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item': item.toJson(),
      'comparison_description': description,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'item': item.toMap(),
      'comparison_description': description,
    };
  }

  factory CommpareItem.fromMap(Map<String, dynamic> map) {
    return CommpareItem(
      item: FoodItem.fromMap(map['item']),
      description: map['comparison_description'],
    );
  }
}


// class FoodItem {
//   String name;
//   String quantity;
//   int fat;
//   int carbs;
//   int protein;
//   double waterQuantity;
//   double exercise;
//   // Calculated values
//   int caloriesFromCarbs;
//   int caloriesFromProtein;
//   int caloriesFromFat;
//   int totalCalories;
//   int percentageCaloriesFromCarbs;
//   int percentageCaloriesFromProtein;
//   int percentageCaloriesFromFat;
//   // New fields
//   Map<String, String> vitamins;
//   Map<String, String> minerals;
//   Map<String, double> additionalNutrients;
//   List<String> allergens;
//   List<String> dietCompatibility;
//   List<String> warnings;
//   int healthScore;
//   FoodItem({
//     required this.name,
//     required this.quantity,
//     required this.fat,
//     required this.carbs,
//     required this.protein,
//     required this.waterQuantity,
//     required this.exercise,
//     required this.vitamins,
//     required this.minerals,
//     required this.additionalNutrients,
//     required this.allergens,
//     required this.dietCompatibility,
//     required this.warnings,
//     required this.healthScore,
//   })  : caloriesFromCarbs = carbs * 4,
//         caloriesFromProtein = protein * 4,
//         caloriesFromFat = fat * 9,
//         totalCalories = (carbs * 4) + (protein * 4) + (fat * 9),
//         percentageCaloriesFromCarbs =
//             ((carbs * 4) * 100 / ((carbs * 4) + (protein * 4) + (fat * 9)))
//                 .round(),
//         percentageCaloriesFromProtein =
//             ((protein * 4) * 100 / ((carbs * 4) + (protein * 4) + (fat * 9)))
//                 .round(),
//         percentageCaloriesFromFat = 100 -
//             (((carbs * 4) * 100 / ((carbs * 4) + (protein * 4) + (fat * 9)))
//                     .round() +
//                 ((protein * 4) *
//                         100 /
//                         ((carbs * 4) + (protein * 4) + (fat * 9)))
//                     .round());
//   // Factory constructor for creating an instance from JSON
//   // factory FoodItem.fromJson(Map<String, dynamic> json) {
//   //   return FoodItem(
//   //     name: json['name'],
//   //     quantity: json['quantity'],
//   //     fat: json['fat'],
//   //     carbs: json['carbs'],
//   //     protein: json['protein'],
//   //     waterQuantity: (json['waterQuantity'] as num).toDouble(),
//   //     exercise: (json['exercise'] as num).toDouble(),
//   //     vitamins: Map<String, String>.from(json['micronutrients']['vitamins']),
//   //     minerals: Map<String, String>.from(json['micronutrients']['minerals']),
//   //     additionalNutrients: Map<String, double>.from(json['additionalNutrients']),
//   //     allergens: List<String>.from(json['allergens']),
//   //     dietCompatibility: List<String>.from(json['dietCompatibility']),
//   //     warnings: List<String>.from(json['warnings']),
//   //     healthScore: json['healthScore'] ?? 0,
//   //   );
//   // }
//   factory FoodItem.fromJson(Map<String, dynamic> json) {
//     print("Parsing FoodItem: $json");
//     return FoodItem(
//       name: json['name'] ?? 'Unknown',
//       quantity: json['quantity'] ?? 'Unknown',
//       fat: json['fat'] ?? 0,
//       carbs: json['carbs'] ?? 0,
//       protein: json['protein'] ?? 0,
//       waterQuantity: (json['waterQuantity'] as num?)?.toDouble() ?? 0.0,
//       exercise: (json['exercise'] as num?)?.toDouble() ?? 0.0,
//       vitamins:
//           Map<String, String>.from(json['micronutrients']['vitamins'] ?? {}),
//       minerals:
//           Map<String, String>.from(json['micronutrients']['minerals'] ?? {}),
//       additionalNutrients:
//           Map<String, double>.from(json['additionalNutrients'] ?? {}),
//       allergens: List<String>.from(json['allergens'] ?? []),
//       dietCompatibility: List<String>.from(json['dietCompatibility'] ?? []),
//       warnings: List<String>.from(json['warnings'] ?? []),
//       healthScore: json['healthScore'] ?? 0,
//     );
//   }
//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'quantity': quantity,
//       'fat': fat,
//       'carbs': carbs,
//       'protein': protein,
//       'waterQuantity': waterQuantity,
//       'exercise': exercise,
//       'micronutrients': {
//         'vitamins': vitamins,
//         'minerals': minerals,
//       },
//       'additionalNutrients': additionalNutrients,
//       'allergens': allergens,
//       'dietCompatibility': dietCompatibility,
//       'warnings': warnings,
//       'healthScore': healthScore,
//       'caloriesFromCarbs': caloriesFromCarbs,
//       'caloriesFromProtein': caloriesFromProtein,
//       'caloriesFromFat': caloriesFromFat,
//       'totalCalories': totalCalories,
//       'percentageCaloriesFromCarbs': percentageCaloriesFromCarbs,
//       'percentageCaloriesFromProtein': percentageCaloriesFromProtein,
//       'percentageCaloriesFromFat': percentageCaloriesFromFat,
//     };
//   }
//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'quantity': quantity,
//       'fat': fat,
//       'carbs': carbs,
//       'protein': protein,
//       'waterQuantity': waterQuantity,
//       'exercise': exercise,
//       'micronutrients': {
//         'vitamins': vitamins,
//         'minerals': minerals,
//       },
//       'additionalNutrients': additionalNutrients,
//       'allergens': allergens,
//       'dietCompatibility': dietCompatibility,
//       'warnings': warnings,
//       'healthScore': healthScore,
//       'caloriesFromCarbs': caloriesFromCarbs,
//       'caloriesFromProtein': caloriesFromProtein,
//       'caloriesFromFat': caloriesFromFat,
//       'totalCalories': totalCalories,
//       'percentageCaloriesFromCarbs': percentageCaloriesFromCarbs,
//       'percentageCaloriesFromProtein': percentageCaloriesFromProtein,
//       'percentageCaloriesFromFat': percentageCaloriesFromFat,
//     };
//   }
//   factory FoodItem.fromMap(Map<String, dynamic> map) {
//     return FoodItem(
//       name: map['name'],
//       quantity: map['quantity'],
//       fat: map['fat'],
//       carbs: map['carbs'],
//       protein: map['protein'],
//       waterQuantity: map['waterQuantity'],
//       exercise: map['exercise'],
//       vitamins: Map<String, String>.from(map['micronutrients']['vitamins']),
//       minerals: Map<String, String>.from(map['micronutrients']['minerals']),
//       additionalNutrients: Map<String, double>.from(map['additionalNutrients']),
//       allergens: List<String>.from(map['allergens']),
//       dietCompatibility: List<String>.from(map['dietCompatibility']),
//       warnings: List<String>.from(map['warnings']),
//       healthScore: map['healthScore'] ?? 0,
//     );
//   }
// }

// class FoodData {
//   FoodItem item;
//   FoodItem alternate1;
//   String description;
//   FoodData({
//     required this.item,
//     required this.alternate1,
//     required this.description,
//   });
//   factory FoodData.fromJson(Map<String, dynamic> json) {
//     return FoodData(
//       item: FoodItem.fromJson(json['item']),
//       alternate1: FoodItem.fromJson(json['alternate1']),
//       description: json['description'],
//     );
//   }
//   Map<String, dynamic> toJson() {
//     return {
//       'item': item.toJson(),
//       'alternate1': alternate1.toJson(),
//       'description': description,
//     };
//   }
//   Map<String, dynamic> toMap() {
//     return {
//       'item': item.toMap(),
//       'alternate1': alternate1.toMap(),
//       'description': description,
//     };
//   }
//   factory FoodData.fromMap(Map<String, dynamic> map) {
//     return FoodData(
//       item: FoodItem.fromMap(map['item']),
//       alternate1: FoodItem.fromMap(map['alternate1']),
//       description: map['description'],
//     );
//   }
// }


// {
//   "item": {
//     "name": "<string>",
//     "quantity": "<string>",
//     "calories": <int>,
//     "macronutrients": {
//       "fat": <float>,
//       "carbs": <float>,
//       "protein": <float>,
//       "fiber": <float>,
//       "sugars": <float>,
//       "saturatedFats": <float>,
//       "unsaturatedFats": <float>,
//       "transFats": <float>
//     },
//     "micronutrients": {
//       "vitamins": {
//         "vitaminA": "<string>", 
//         "vitaminC": "<string>",
//         "vitaminD": "<string>",
//         "vitaminE": "<string>",
//         "vitaminK": "<string>",
//         "vitaminB1": "<string>", 
//         "vitaminB2": "<string>",
//         "vitaminB3": "<string>",
//         "vitaminB5": "<string>",
//         "vitaminB6": "<string>",
//         "vitaminB7": "<string>",
//         "vitaminB9": "<string>",
//         "vitaminB12": "<string>"
//       },
//       "minerals": {
//         "calcium": "<string>",
//         "iron": "<string>",
//         "potassium": "<string>",
//         "magnesium": "<string>",
//         "zinc": "<string>",
//         "sodium": "<string>",
//         "phosphorus": "<string>",
//         "copper": "<string>",
//         "manganese": "<string>",
//         "selenium": "<string>",
//         "iodine": "<string>"
//       }
//     },
//     "additionalNutrients": {
//       "cholesterol": <float>,
//       "waterContent": "<string>",
//       "caffeine": <float>
//     },
//     "allergens": ["<string>", "<string>"],
//     "dietCompatibility": ["<string>", "<string>"],
//     "warnings": ["<string>", "<string>"],
//     "healthScore": <int>,
//   },
//   "alternate1": {
//     "name": "<string>",
//     "quantity": "<string>",
//     "calories": <int>,
//     "macronutrients": {
//       "fat": <float>,
//       "carbs": <float>,
//       "protein": <float>,
//       "fiber": <float>,
//       "sugars": <float>,
//       "saturatedFats": <float>,
//       "unsaturatedFats": <float>,
//       "transFats": <float>
//     },
//     "micronutrients": {
//       "vitamins": {
//         "vitaminA": "<string>", 
//         "vitaminC": "<string>",
//         "vitaminD": "<string>",
//         "vitaminE": "<string>",
//         "vitaminK": "<string>",
//         "vitaminB1": "<string>", 
//         "vitaminB2": "<string>",
//         "vitaminB3": "<string>",
//         "vitaminB5": "<string>",
//         "vitaminB6": "<string>",
//         "vitaminB7": "<string>",
//         "vitaminB9": "<string>",
//         "vitaminB12": "<string>"
//       },
//       "minerals": {
//         "calcium": "<string>",
//         "iron": "<string>",
//         "potassium": "<string>",
//         "magnesium": "<string>",
//         "zinc": "<string>",
//         "sodium": "<string>",
//         "phosphorus": "<string>",
//         "copper": "<string>",
//         "manganese": "<string>",
//         "selenium": "<string>",
//         "iodine": "<string>"
//       }
//     },
//     "additionalNutrients": {
//       "cholesterol": <float>,
//       "waterContent": "<string>",
//       "caffeine": <float>
//     },
//     "allergens": ["<string>", "<string>"],
//     "dietCompatibility": ["<string>", "<string>"],
//     "warnings": ["<string>", "<string>"],
//     "healthScore": <int>,
//   },
//   "description": "<string>"
// }
