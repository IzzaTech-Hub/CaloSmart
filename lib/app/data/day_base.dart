import 'package:calories_detector/app/data/Data_Base.dart';
import 'package:calories_detector/app/data/food_item.dart';
import 'package:calories_detector/app/modules/home/controllers/home_controller.dart';
import 'package:calories_detector/app/premium/trailbase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'oneday.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper2 {
  static final DatabaseHelper2 _instance = DatabaseHelper2._();
  static Database? _database;

  DatabaseHelper2._();

  factory DatabaseHelper2() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'one_day_data.db');
    Database db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE one_day (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT,
        caloriestarget INTEGER,
        watertarget REAL,
        exercisetarget REAL,
        fattarget INTEGER,
        protientarget INTEGER,
        carbstarget INTEGER,
        caloriesProgress INTEGER,
        waterProgress REAL,
        exerciseProgress REAL,
        fatProgress INTEGER,
        proteinProgress INTEGER,
        carbsProgress INTEGER,
        caloriesRemaining INTEGER,
        waterRemaining REAL,
        exerciseRemaining REAL,
        fatRemaining INTEGER,
        proteinRemaining INTEGER,
        carbsRemaining INTEGER,
        indexes TEXT,
        isRewardCollected INTEGER DEFAULT 0
      )
    ''');
  }

  Future<void> insertOneDay(OneDay oneDay) async {
    AppleManager.resetApple(0);
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'one_day',
      where: 'date = ?',
      whereArgs: [oneDay.date],
    );
    if (result.isNotEmpty) {
      await updateOneDay(oneDay);
    } else {
      await db.insert('one_day', {
        'date': oneDay.date,
        'caloriestarget': oneDay.caloriestarget.value,
        'watertarget': oneDay.watertarget.value,
        'exercisetarget': oneDay.exercisetarget.value,
        'fattarget': oneDay.fattarget.value,
        'protientarget': oneDay.protientarget.value,
        'carbstarget': oneDay.carbstarget.value,
        'caloriesProgress': oneDay.caloriesProgress.value,
        'waterProgress': oneDay.waterProgress.value,
        'exerciseProgress': oneDay.exerciseProgress.value,
        'fatProgress': oneDay.fatProgress.value,
        'proteinProgress': oneDay.proteinProgress.value,
        'carbsProgress': oneDay.carbsProgress.value,
        'caloriesRemaining': oneDay.caloriesRemaining.value,
        'waterRemaining': oneDay.waterRemaining.value,
        'exerciseRemaining': oneDay.exerciseRemaining.value,
        'fatRemaining': oneDay.fatRemaining.value,
        'proteinRemaining': oneDay.proteinRemaining.value,
        'carbsRemaining': oneDay.carbsRemaining.value,
        'indexes': oneDay.indexes.join(','),
        'isRewardCollected': oneDay.isRewardCollected.value ? 1 : 0,
      });
    }
  }

  Future<OneDay> fetchOneDay(String tdate) async {
    final db = await database;
    final List<Map<String, dynamic>> chckmaps = await db.query(
      'one_day',
      where: 'date = ?',
      whereArgs: [tdate],
    );
    print('Before if');

    if (chckmaps.isEmpty) {
      print('if run');

      final prefs = await SharedPreferences.getInstance();
      String goal = prefs.getString('selected_button') ?? 'Gain Weight';
      await prefs.setString('selected_button', goal);
      DietPlan setplan = generateDietPlan(goal);
      print('after diet');

      OneDay newDay = OneDay(
        date: tdate,
        caloriestarget: setplan.foodTarget,
        watertarget: setplan.waterTarget,
        exercisetarget: setplan.exerciseTarget,
        fattarget: setplan.fatTarget,
        protientarget: setplan.proteinTarget,
        carbstarget: setplan.carbsTarget,
      );
      print('start inserting');

      await insertOneDay(newDay);
      print('inserted');
    }
    print('after if');
    print('$chckmaps');

    final List<Map<String, dynamic>> maps = await db.query(
      'one_day',
      where: 'date = ?',
      whereArgs: [tdate],
    );
    print('map created');

    final map = maps.first;

    List<int> indexesList = [];
    if (map['indexes'] != null && map['indexes'].isNotEmpty) {
      indexesList = (map['indexes'] as String)
          .split(',')
          .map((e) => int.tryParse(e) ?? 0)
          .where((e) => e != 0)
          .toList();
    }
    print('before returning');

    return OneDay(
      date: map['date'] ?? '',
      caloriestarget: map['caloriestarget'] ?? 0,
      watertarget: map['watertarget'] ?? 0.0,
      exercisetarget: map['exercisetarget'] ?? 0.0,
      fattarget: map['fattarget'] ?? 0,
      protientarget: map['protientarget'] ?? 0,
      carbstarget: map['carbstarget'] ?? 0,
      // isRewardCollected: map['isRewardCollected'] == 1,
    )
      ..caloriesProgress.value = map['caloriesProgress'] ?? 0
      ..waterProgress.value = map['waterProgress'] ?? 0.0
      ..exerciseProgress.value = map['exerciseProgress'] ?? 0.0
      ..fatProgress.value = map['fatProgress'] ?? 0
      ..proteinProgress.value = map['proteinProgress'] ?? 0
      ..carbsProgress.value = map['carbsProgress'] ?? 0
      ..caloriesRemaining.value = map['caloriesRemaining'] ?? 0
      ..waterRemaining.value = map['waterRemaining'] ?? 0.0
      ..exerciseRemaining.value = map['exerciseRemaining'] ?? 0.0
      ..fatRemaining.value = map['fatRemaining'] ?? 0
      ..proteinRemaining.value = map['proteinRemaining'] ?? 0
      ..carbsRemaining.value = map['carbsRemaining'] ?? 0
      // ..isRewardCollected.value = map['isRewardCollected'] ?? false
      ..isRewardCollected.value = (map['isRewardCollected'] ?? 0) == 1
      ..indexes = indexesList;
  }

  Future<List<OneDay>> fetchAllOneDays() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('one_day');
    return List.generate(maps.length, (i) {
      final map = maps[i];
      return OneDay(
        date: map['date'],
        caloriestarget: map['caloriestarget'],
        watertarget: map['watertarget'],
        exercisetarget: map['exercisetarget'],
        fattarget: map['fattarget'],
        protientarget: map['protientarget'],
        carbstarget: map['carbstarget'],
        // isRewardCollected: map['isRewardCollected'] == 1,
      )
        ..caloriesProgress = map['caloriesProgress']
        ..waterProgress = map['waterProgress']
        ..exerciseProgress = map['exerciseProgress']
        ..fatProgress = map['fatProgress']
        ..proteinProgress = map['proteinProgress']
        ..carbsProgress = map['carbsProgress']
        ..caloriesRemaining = map['caloriesRemaining']
        ..waterRemaining = map['waterRemaining']
        ..exerciseRemaining = map['exerciseRemaining']
        ..fatRemaining = map['fatRemaining']
        ..proteinRemaining = map['proteinRemaining']
        ..carbsRemaining = map['carbsRemaining']
        ..isRewardCollected = map['isRewardCollected']
        ..indexes = map['indexes'].split(',').map(int.parse).toList();
    });
  }

  Future<void> toggleRewardCollected(String date) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'one_day',
      where: 'date = ?',
      whereArgs: [date],
    );

    if (maps.isNotEmpty) {
      final currentStatus = maps.first['isRewardCollected'] ?? 0;
      await db.update(
        'one_day',
        {'isRewardCollected': currentStatus == 0 ? 1 : 0},
        where: 'date = ?',
        whereArgs: [date],
      );
    }
  }

  Future<int> getIndexByDate(String date) async {
    List<OneDay> days = await fetchAllOneDays();
    for (int i = 0; i < days.length; i++) {
      if (days[i].date == date) {
        return i;
      }
    }
    return -1;
  }

  Future<void> updateOneDay(OneDay oneDay) async {
    final db = await database;
    await db.update(
      'one_day',
      {
        'date': oneDay.date,
        'caloriestarget': oneDay.caloriestarget.value,
        'watertarget': oneDay.watertarget.value,
        'exercisetarget': oneDay.exercisetarget.value,
        'fattarget': oneDay.fattarget.value,
        'protientarget': oneDay.protientarget.value,
        'carbstarget': oneDay.carbstarget.value,
        'caloriesProgress': oneDay.caloriesProgress.value,
        'waterProgress': oneDay.waterProgress.value,
        'exerciseProgress': oneDay.exerciseProgress.value,
        'fatProgress': oneDay.fatProgress.value,
        'proteinProgress': oneDay.proteinProgress.value,
        'carbsProgress': oneDay.carbsProgress.value,
        'caloriesRemaining': oneDay.caloriesRemaining.value,
        'waterRemaining': oneDay.waterRemaining.value,
        'exerciseRemaining': oneDay.exerciseRemaining.value,
        'fatRemaining': oneDay.fatRemaining.value,
        'proteinRemaining': oneDay.proteinRemaining.value,
        'carbsRemaining': oneDay.carbsRemaining.value,
        'indexes': oneDay.indexes.join(','),
        'isRewardCollected': oneDay.isRewardCollected.value ? 1 : 0,
      },
      where: 'date = ?',
      whereArgs: [oneDay.date],
    );
  }

  Future<void> deleteDatabaseFile() async {
    String path = join(await getDatabasesPath(), 'one_day_data.db');
    await deleteDatabase(path);
    print('Database deleted at: $path');
    // _initDatabase();
    // print('newdatabase2 created');
  }
}

class DietPlan {
  double waterTarget; // in liters
  double exerciseTarget; // in hours
  int foodTarget; // in Kcal
  int fatTarget; // in grams
  int proteinTarget; // in grams
  int carbsTarget; // in grams

  DietPlan({
    required this.waterTarget,
    required this.exerciseTarget,
    required this.foodTarget,
    required this.fatTarget,
    required this.proteinTarget,
    required this.carbsTarget,
  });
}

DietPlan generateDietPlan(String goal) {
  int calorieTarget;
  if (goal.toLowerCase() == 'gain weight') {
    calorieTarget = 2800; // High calorie intake for gaining weight
  } else if (goal.toLowerCase() == 'lose weight') {
    calorieTarget = 1700; // Lower calorie intake for losing weight
  } else {
    calorieTarget = 2200; // Moderate calorie intake for maintaining weight
  }

  double waterTarget = 12;

  double exerciseHours;
  if (goal.toLowerCase() == 'gain weight') {
    exerciseHours = 0.5;
  } else if (goal.toLowerCase() == 'lose weight') {
    exerciseHours = 1.5;
  } else {
    exerciseHours = 1.0;
  }

  // 4. Macronutrient breakdown based on calorie target
  int proteinGrams =
      (calorieTarget * 0.25 / 4).round(); // 25% of calories from protein
  int fatGrams = (calorieTarget * 0.30 / 9).round(); // 30% of calories from fat
  int carbsGrams =
      (calorieTarget * 0.45 / 4).round(); // 45% of calories from carbs

  return DietPlan(
    waterTarget: waterTarget,
    exerciseTarget: exerciseHours,
    foodTarget: calorieTarget,
    fatTarget: fatGrams,
    proteinTarget: proteinGrams,
    carbsTarget: carbsGrams,
  );
}






// class UserProfile {
//   final int age;
//   final String gender; // "male", "female", "rather not say"
//   final double weight; // in kilograms
//   final double height; // in centimeters
//   final String goal; // "gain weight", "lose weight", "maintain weight"
//   final String
//       activityLevel; // "sedentary", "light", "moderate", "active", "extra active"
//   UserProfile({
//     required this.age,
//     required this.gender,
//     required this.weight,
//     required this.height,
//     required this.goal,
//     required this.activityLevel,
//   });
// }
// class DietPlan {
//   double waterTarget; // in liters
//   double exerciseTarget; // in hours
//   int foodTarget; // in Kcal
//   int fatTarget; // in grams
//   int proteinTarget; // in grams
//   int carbsTarget; // in grams
//   DietPlan({
//     required this.waterTarget,
//     required this.exerciseTarget,
//     required this.foodTarget,
//     required this.fatTarget,
//     required this.proteinTarget,
//     required this.carbsTarget,
//   });
//   @override
//   String toString() {
//     return 'Diet Plan:\n'
//         'Water Target: ${waterTarget.toStringAsFixed(2)} L\n'
//         'Exercise Target: ${exerciseTarget.toStringAsFixed(2)} hrs\n'
//         'Food Target: $foodTarget Kcal\n'
//         'Fat Target: $fatTarget g\n'
//         'Protein Target: $proteinTarget g\n'
//         'Carbs Target: $carbsTarget g\n';
//   }
// }
// double calculateBMR(UserProfile user) {
//   double bmr;
//   // Mifflin-St Jeor formula
//   if (user.gender.toLowerCase() == "male") {
//     bmr = 10 * user.weight + 6.25 * user.height - 5 * user.age + 5;
//   } else if (user.gender.toLowerCase() == "female") {
//     bmr = 10 * user.weight + 6.25 * user.height - 5 * user.age - 161;
//   } else {
//     // Default BMR calculation for "rather not say"
//     bmr = 10 * user.weight + 6.25 * user.height - 5 * user.age;
//   }
//   return bmr;
// }
// double adjustForActivity(double bmr, String activityLevel) {
//   switch (activityLevel.toLowerCase()) {
//     case 'sedentary':
//       return bmr * 1.2;
//     case 'light':
//       return bmr * 1.375;
//     case 'moderate':
//       return bmr * 1.55;
//     case 'active':
//       return bmr * 1.725;
//     case 'extra active':
//       return bmr * 1.9;
//     default:
//       return bmr * 1.2; // Default to sedentary if no valid input
//   }
// }
// int adjustForGoal(double adjustedBMR, String goal) {
//   if (goal.toLowerCase() == 'gain weight') {
//     return (adjustedBMR + 500).toInt(); // Add 500 Kcal for weight gain
//   } else if (goal.toLowerCase() == 'lose weight') {
//     return (adjustedBMR - 500).toInt(); // Subtract 500 Kcal for weight loss
//   } else {
//     return adjustedBMR.toInt(); // No change for maintaining weight
//   }
// }
// DietPlan generateDietPlan(UserProfile user) {
//   double bmr = calculateBMR(user);
//   double adjustedBMR = adjustForActivity(bmr, user.activityLevel);
//   int calorieTarget = adjustForGoal(adjustedBMR, user.goal);
//   double waterTarget = calorieTarget * 0.03;
//   double exerciseHours;
//   if (user.activityLevel.toLowerCase() == 'sedentary') {
//     exerciseHours = 0.5; // Minimum exercise recommendation for sedentary users
//   } else {
//     exerciseHours = 1.0; // Default 1 hour for active users
//   }
//   int proteinGrams = (calorieTarget * 0.25 / 4).round(); // 25% from protein
//   int fatGrams = (calorieTarget * 0.30 / 9).round(); // 30% from fat
//   int carbsGrams = (calorieTarget * 0.45 / 4).round(); // 45% from carbs
//   return DietPlan(
//     waterTarget: waterTarget,
//     exerciseTarget: exerciseHours,
//     foodTarget: calorieTarget,
//     fatTarget: fatGrams,
//     proteinTarget: proteinGrams,
//     carbsTarget: carbsGrams,
//   );
// }
