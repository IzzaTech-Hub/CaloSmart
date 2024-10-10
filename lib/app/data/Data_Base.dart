import 'dart:convert';
import 'package:calories_detector/app/data/day_base.dart';
import 'package:calories_detector/app/modules/home/controllers/home_controller.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'food_item.dart'; // Assuming this contains FoodItem class definition
import 'package:intl/intl.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'food_data.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE food_data (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date TEXT,
      description TEXT, -- This is the description of the overall entry
      
      -- Main item fields
      itemName TEXT,
      itemQuantity TEXT,
      itemFat REAL, -- Changed from INTEGER to REAL
      itemCarbs REAL, -- Changed from INTEGER to REAL
      itemProtein REAL, -- Changed from INTEGER to REAL
      itemWaterQuantity REAL,
      itemExercise REAL,

      -- Micronutrients for the main item
      itemVitamins TEXT, -- JSON string representation
      itemMinerals TEXT, -- JSON string representation
      itemAdditionalNutrients TEXT, -- JSON string representation
      itemAllergens TEXT, -- JSON string representation
      itemDietCompatibility TEXT, -- JSON string representation
      itemWarnings TEXT, -- JSON string representation
      itemHealthScore INTEGER,

      -- Alternate 1 fields
      alternate1Name TEXT,
      alternate1Quantity TEXT,
      alternate1Fat REAL, -- Changed from INTEGER to REAL
      alternate1Carbs REAL, -- Changed from INTEGER to REAL
      alternate1Protein REAL, -- Changed from INTEGER to REAL
      alternate1WaterQuantity REAL,
      alternate1Exercise REAL,

      -- Micronutrients for the alternate item
      alternate1Vitamins TEXT, -- JSON string representation
      alternate1Minerals TEXT, -- JSON string representation
      alternate1AdditionalNutrients TEXT, -- JSON string representation
      alternate1Allergens TEXT, -- JSON string representation
      alternate1DietCompatibility TEXT, -- JSON string representation
      alternate1Warnings TEXT, -- JSON string representation
      alternate1HealthScore INTEGER
    )
    ''');
  }

  Future<void> insertFoodData(FoodData foodData) async {
    String nowDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

    final db = await database;
    int id = await db.insert('food_data', {
      'date': nowDate,
      'description': foodData.description,

      // Main item fields
      'itemName': foodData.item.name,
      'itemQuantity': foodData.item.quantity,
      'itemFat': foodData.item.fat,
      'itemCarbs': foodData.item.carbs,
      'itemProtein': foodData.item.protein,
      'itemWaterQuantity': foodData.item.waterQuantity,
      'itemExercise': foodData.item.exercise,
      'itemVitamins':
          jsonEncode(foodData.item.vitamins), // Convert Map to JSON string
      'itemMinerals':
          jsonEncode(foodData.item.minerals), // Convert Map to JSON string
      'itemAdditionalNutrients': jsonEncode(
          foodData.item.additionalNutrients), // Convert Map to JSON string
      'itemAllergens':
          jsonEncode(foodData.item.allergens), // Convert List to JSON string
      'itemDietCompatibility': jsonEncode(
          foodData.item.dietCompatibility), // Convert List to JSON string
      'itemWarnings':
          jsonEncode(foodData.item.warnings), // Convert List to JSON string
      'itemHealthScore': foodData.item.healthScore,

      // Alternate 1 fields
      'alternate1Name': foodData.alternate1.name,
      'alternate1Quantity': foodData.alternate1.quantity,
      'alternate1Fat': foodData.alternate1.fat,
      'alternate1Carbs': foodData.alternate1.carbs,
      'alternate1Protein': foodData.alternate1.protein,
      'alternate1WaterQuantity': foodData.alternate1.waterQuantity,
      'alternate1Exercise': foodData.alternate1.exercise,
      'alternate1Vitamins': jsonEncode(
          foodData.alternate1.vitamins), // Convert Map to JSON string
      'alternate1Minerals': jsonEncode(
          foodData.alternate1.minerals), // Convert Map to JSON string
      'alternate1AdditionalNutrients': jsonEncode(foodData
          .alternate1.additionalNutrients), // Convert Map to JSON string
      'alternate1Allergens': jsonEncode(
          foodData.alternate1.allergens), // Convert List to JSON string
      'alternate1DietCompatibility': jsonEncode(
          foodData.alternate1.dietCompatibility), // Convert List to JSON string
      'alternate1Warnings': jsonEncode(
          foodData.alternate1.warnings), // Convert List to JSON string
      'alternate1HealthScore': foodData.alternate1.healthScore,
    });
    print('after insert in id = $id');

    // await HomeController().toDay!.AddFoodItem(id);
    if (toDay != null) {
      await toDay!.AddFoodItem(id);
      print('it is not null');
    } else {
      print('it is null');
    }
    print('hhh${toDay!.caloriestarget}');
    print('after adding food');

    await DatabaseHelper2().updateOneDay(toDay!);
    print('after update oneday');
  }

  Future<FoodData?> fetchFoodDataByIndex(int index) async {
    final db = await database;

    // Query the specific row by index
    final List<Map<String, dynamic>> maps = await db.query(
      'food_data',
      where: 'id = ?',
      whereArgs: [index],
    );

    // If no result is found, return null
    if (maps.isEmpty) return null;

    // Convert the row into a FoodData object and return it
    return FoodData(
      description: maps[0]['description'],
      item: FoodItem(
        name: maps[0]['itemName'],
        quantity: maps[0]['itemQuantity'],
        fat: (maps[0]['itemFat'] as num).toDouble(),
        carbs: (maps[0]['itemCarbs'] as num).toDouble(),
        protein: (maps[0]['itemProtein'] as num).toDouble(),
        waterQuantity: (maps[0]['itemWaterQuantity'] as num).toDouble(),
        exercise: (maps[0]['itemExercise'] as num).toDouble(),
        vitamins: _parseMap(maps[0]['itemVitamins']),
        minerals: _parseMap(maps[0]['itemMinerals']),
        additionalNutrients:
            _parseAdditionalNutrients(maps[0]['itemAdditionalNutrients']),
        allergens: _parseList(maps[0]['itemAllergens']),
        dietCompatibility: _parseList(maps[0]['itemDietCompatibility']),
        warnings: _parseList(maps[0]['itemWarnings']),
        healthScore: maps[0]['itemHealthScore'] ?? 0,
      ),
      alternate1: FoodItem(
        name: maps[0]['alternate1Name'],
        quantity: maps[0]['alternate1Quantity'],
        fat: (maps[0]['alternate1Fat'] as num).toDouble(),
        carbs: (maps[0]['alternate1Carbs'] as num).toDouble(),
        protein: (maps[0]['alternate1Protein'] as num).toDouble(),
        waterQuantity: (maps[0]['alternate1WaterQuantity'] as num).toDouble(),
        exercise: (maps[0]['alternate1Exercise'] as num).toDouble(),
        vitamins: _parseMap(maps[0]['alternate1Vitamins']),
        minerals: _parseMap(maps[0]['alternate1Minerals']),
        additionalNutrients:
            _parseAdditionalNutrients(maps[0]['alternate1AdditionalNutrients']),
        allergens: _parseList(maps[0]['alternate1Allergens']),
        dietCompatibility: _parseList(maps[0]['alternate1DietCompatibility']),
        warnings: _parseList(maps[0]['alternate1Warnings']),
        healthScore: maps[0]['alternate1HealthScore'] ?? 0,
      ),
    );
  }

  Future<List<FoodData>> fetchFoodData() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('food_data');

    return List.generate(maps.length, (i) {
      return FoodData(
        description: maps[i]['description'],
        item: FoodItem(
          name: maps[i]['itemName'],
          quantity: maps[i]['itemQuantity'],
          fat: (maps[i]['itemFat'] as num).toDouble(),
          carbs: (maps[i]['itemCarbs'] as num).toDouble(),
          protein: (maps[i]['itemProtein'] as num).toDouble(),
          waterQuantity: (maps[i]['itemWaterQuantity'] as num).toDouble(),
          exercise: (maps[i]['itemExercise'] as num).toDouble(),
          vitamins: _parseMap(maps[i]['itemVitamins']),
          minerals: _parseMap(maps[i]['itemMinerals']),
          additionalNutrients:
              _parseAdditionalNutrients(maps[i]['itemAdditionalNutrients']),
          allergens: _parseList(maps[i]['itemAllergens']),
          dietCompatibility: _parseList(maps[i]['itemDietCompatibility']),
          warnings: _parseList(maps[i]['itemWarnings']),
          healthScore: maps[i]['itemHealthScore'] ?? 0,
        ),
        alternate1: FoodItem(
          name: maps[i]['alternate1Name'],
          quantity: maps[i]['alternate1Quantity'],
          fat: (maps[i]['alternate1Fat'] as num).toDouble(),
          carbs: (maps[i]['alternate1Carbs'] as num).toDouble(),
          protein: (maps[i]['alternate1Protein'] as num).toDouble(),
          waterQuantity: (maps[i]['alternate1WaterQuantity'] as num).toDouble(),
          exercise: (maps[i]['alternate1Exercise'] as num).toDouble(),
          vitamins: _parseMap(maps[i]['alternate1Vitamins']),
          minerals: _parseMap(maps[i]['alternate1Minerals']),
          additionalNutrients: _parseAdditionalNutrients(
              maps[i]['alternate1AdditionalNutrients']),
          allergens: _parseList(maps[i]['alternate1Allergens']),
          dietCompatibility: _parseList(maps[i]['alternate1DietCompatibility']),
          warnings: _parseList(maps[i]['alternate1Warnings']),
          healthScore: maps[i]['alternate1HealthScore'] ?? 0,
        ),
      );
    });
  }

  Future<List<String>> fetchDate() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('food_data');

    return List.generate(maps.length, (i) {
      return maps[i]['date'] as String;
    });
  }

  Future<void> deleteDatabaseFile() async {
    String path = join(await getDatabasesPath(), 'food_data.db');
    await deleteDatabase(path);
    print('Database deleted at: $path');
    // _initDatabase();
    // print('new database1 created');
  }

  // Helper methods to parse JSON strings
  Map<String, String> _parseMap(String? jsonString) {
    if (jsonString == null || jsonString.isEmpty) {
      return {};
    }
    return Map<String, String>.from(json.decode(jsonString));
  }

  Map<String, double> _parseAdditionalNutrients(String? jsonString) {
    if (jsonString == null || jsonString.isEmpty) {
      return {};
    }
    return Map<String, double>.from(json.decode(jsonString));
  }

  List<String> _parseList(String? jsonString) {
    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }
    return List<String>.from(json.decode(jsonString));
  }
}
