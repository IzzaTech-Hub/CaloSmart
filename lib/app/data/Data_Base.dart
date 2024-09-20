import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'food_item.dart';
import 'package:intl/intl.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    print('database function works');

    if (_database != null) return _database!;
    {
      print('if condition works');
      _database = await _initDatabase();
    }
    return _database!;
  }

  Future<Database> _initDatabase() async {
    print('initiate db function works');
    String path = join(await getDatabasesPath(), 'food_data.db');
    print(path);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE food_data (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date TEXT,
      -- Main item fields
      itemName TEXT,
      itemQuantity TEXT,
      itemFat INTEGER,
      itemCarbs INTEGER,
      itemProtein INTEGER,
      itemWaterquantity REAL,
      itemExercise REAL,
      
      -- Alternate 1 fields
      alternate1Name TEXT,
      alternate1Quantity TEXT,
      alternate1Fat INTEGER,
      alternate1Carbs INTEGER,
      alternate1Protein INTEGER,
      alternate1Waterquantity REAL,
      alternate1Exercise REAL,
      
      -- Alternate 2 fields
      alternate2Name TEXT,
      alternate2Quantity TEXT,
      alternate2Fat INTEGER,
      alternate2Carbs INTEGER,
      alternate2Protein INTEGER,
      alternate2Waterquantity REAL,
      alternate2Exercise REAL,
      
      -- Alternate 3 fields
      alternate3Name TEXT,
      alternate3Quantity TEXT,
      alternate3Fat INTEGER,
      alternate3Carbs INTEGER,
      alternate3Protein INTEGER,
      alternate3Waterquantity REAL,
      alternate3Exercise REAL
    )
  ''');
  }

  Future<void> insertFoodData(FoodData foodData) async {
    String nowDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

    final db = await database;
    await db.insert('food_data', {
      'date': nowDate,
      // Main item fields
      'itemName': foodData.item.name,
      'itemQuantity': foodData.item.quantity,
      'itemFat': foodData.item.fat,
      'itemCarbs': foodData.item.carbs,
      'itemProtein': foodData.item.protein,
      'itemWaterquantity': foodData.item.waterquantity,
      'itemExercise': foodData.item.exercise,

      // Alternate 1 fields
      'alternate1Name': foodData.alternate1.name,
      'alternate1Quantity': foodData.alternate1.quantity,
      'alternate1Fat': foodData.alternate1.fat,
      'alternate1Carbs': foodData.alternate1.carbs,
      'alternate1Protein': foodData.alternate1.protein,
      'alternate1Waterquantity': foodData.alternate1.waterquantity,
      'alternate1Exercise': foodData.alternate1.exercise,

      // Alternate 2 fields
      'alternate2Name': foodData.alternate2.name,
      'alternate2Quantity': foodData.alternate2.quantity,
      'alternate2Fat': foodData.alternate2.fat,
      'alternate2Carbs': foodData.alternate2.carbs,
      'alternate2Protein': foodData.alternate2.protein,
      'alternate2Waterquantity': foodData.alternate2.waterquantity,
      'alternate2Exercise': foodData.alternate2.exercise,

      // Alternate 3 fields
      'alternate3Name': foodData.alternate3.name,
      'alternate3Quantity': foodData.alternate3.quantity,
      'alternate3Fat': foodData.alternate3.fat,
      'alternate3Carbs': foodData.alternate3.carbs,
      'alternate3Protein': foodData.alternate3.protein,
      'alternate3Waterquantity': foodData.alternate3.waterquantity,
      'alternate3Exercise': foodData.alternate3.exercise,
    });
  }

  Future<List<FoodData>> fetchFoodData() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('food_data');

    return List.generate(maps.length, (i) {
      return FoodData(
        item: FoodItem(
          name: maps[i]['itemName'],
          quantity: maps[i]['itemQuantity'],
          fat: maps[i]['itemFat'],
          carbs: maps[i]['itemCarbs'],
          protein: maps[i]['itemProtein'],
          waterquantity: maps[i]['itemWaterquantity'],
          exercise: maps[i]['itemExercise'],
        ),
        alternate1: FoodItem(
          name: maps[i]['alternate1Name'],
          quantity: maps[i]['alternate1Quantity'],
          fat: maps[i]['alternate1Fat'],
          carbs: maps[i]['alternate1Carbs'],
          protein: maps[i]['alternate1Protein'],
          waterquantity: maps[i]['alternate1Waterquantity'],
          exercise: maps[i]['alternate1Exercise'],
        ),
        alternate2: FoodItem(
          name: maps[i]['alternate2Name'],
          quantity: maps[i]['alternate2Quantity'],
          fat: maps[i]['alternate2Fat'],
          carbs: maps[i]['alternate2Carbs'],
          protein: maps[i]['alternate2Protein'],
          waterquantity: maps[i]['alternate2Waterquantity'],
          exercise: maps[i]['alternate2Exercise'],
        ),
        alternate3: FoodItem(
          name: maps[i]['alternate3Name'],
          quantity: maps[i]['alternate3Quantity'],
          fat: maps[i]['alternate3Fat'],
          carbs: maps[i]['alternate3Carbs'],
          protein: maps[i]['alternate3Protein'],
          waterquantity: maps[i]['alternate3Waterquantity'],
          exercise: maps[i]['alternate3Exercise'],
        ),
      );
    });
  }

  Future<List<String>> fetchDate() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('food_data');

    return List.generate(maps.length, (i) {
      // Ensure 'date' is properly accessed from the map
      return maps[i]['date'] as String;
    });
  }

  Future<void> deleteDatabaseFile() async {
    String path = join(await getDatabasesPath(), 'food_data.db');
    await deleteDatabase(path);
    print('Database deleted at: $path');
  }
}
