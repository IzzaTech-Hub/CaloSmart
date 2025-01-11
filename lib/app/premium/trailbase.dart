import 'package:calories_detector/app/premium/premium.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class TrailbaseHelper {
//   static final _databaseName = "UserTrials.db";
//   static final _databaseVersion = 1;
//   static final table = 'user_trials';

//   static final columnDate = 'date';
//   static final columnTrialsLeft = 'trialsLeft';
//   static final columnUserType = 'userType';

//   TrailbaseHelper._privateConstructor();
//   static final TrailbaseHelper instance = TrailbaseHelper._privateConstructor();

//   static Database? _database;

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }

//   _initDatabase() async {
//     String path = join(await getDatabasesPath(), _databaseName);
//     return await openDatabase(
//       path,
//       version: _databaseVersion,
//       onCreate: _onCreate,
//     );
//   }

//   Future _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE $table (
//         $columnDate TEXT PRIMARY KEY,
//         $columnTrialsLeft INTEGER NOT NULL,
//         $columnUserType TEXT NOT NULL
//       )
//     ''');
//   }

//   // Function to get trials left for the current day based on user type
//   Future<int> getTrialsLeft() async {
//     final db = await database;
//     String today = DateFormat('dd/MM/yyyy').format(DateTime.now());

//     var result = await db.query(
//       table,
//       columns: [columnTrialsLeft],
//       where: '$columnDate = ?',
//       whereArgs: [today],
//     );

//     if (result.isEmpty) {
//       // No entry for today, create a new one based on user type
//       await _createNewDay(today);
//       return await _getInitialTrials();
//     } else {
//       return result.first[columnTrialsLeft] as int;
//     }
//   }

//   // Function to create a new entry for a given date and user type
//   Future<void> _createNewDay(String date) async {
//     bool isPaid = Premium.instance.isPremium!.value;
//     final db = await database;
//     await db.insert(table, {
//       columnDate: date,
//       columnTrialsLeft: await _getInitialTrials(),
//       columnUserType: isPaid ? 'paid' : 'free',
//     });
//   }

//   // Function to decrement the number of trials left
//   Future<void> decrementTrial() async {
//     final db = await database;
//     String today = DateFormat('dd/MM/yyyy').format(DateTime.now());

//     int trialsLeft = await getTrialsLeft();
//     if (trialsLeft > 0) {
//       await db.update(
//         table,
//         {columnTrialsLeft: trialsLeft - 1},
//         where: '$columnDate = ?',
//         whereArgs: [today],
//       );
//     }
//   }

//   // Helper function to determine the initial trials based on user type
//   // Future<int> _getInitialTrials() async {
//   //   bool isPaid = Premium.instance.isPremium!.value;
//   //   int streakCount = await StreakManager.getStreakCount();
//   //   if (streakCount <= 1) {
//   //     return isPaid ? PremiumTheme.paidToken1 : PremiumTheme.freeToken1;
//   //   } else if (streakCount == 2) {
//   //     return isPaid ? PremiumTheme.paidToken2 : PremiumTheme.freeToken2;
//   //   } else if (streakCount == 3) {
//   //     return isPaid ? PremiumTheme.paidToken3 : PremiumTheme.freeToken3;
//   //   } else if (streakCount == 4) {
//   //     return isPaid ? PremiumTheme.paidToken4 : PremiumTheme.freeToken4;
//   //   } else if (streakCount == 5) {
//   //     return isPaid ? PremiumTheme.paidToken5 : PremiumTheme.freeToken5;
//   //   } else if (streakCount == 6) {
//   //     return isPaid ? PremiumTheme.paidToken6 : PremiumTheme.freeToken6;
//   //   } else {
//   //     // For streak count 7 and above, keep the final reward
//   //     return isPaid ? PremiumTheme.paidToken7 : PremiumTheme.freeToken7;
//   //   }
//   // }

//   Future<int> _getInitialTrials() async {
//     bool isPaid = Premium.instance.isPremium!.value;
//     int streakCount = 10;
//     // int streakCount = await StreakManager.getStreakCount();

//     // Cap streakCount at 7 to handle any values above 7
//     int cappedStreak = streakCount.clamp(1, 7) - 1;
//     return isPaid
//         ? PremiumTheme.paidTokens[cappedStreak]
//         : PremiumTheme.freeTokens[cappedStreak];
//   }

//   Future<void> deleteDatabaseFile() async {
//     String path = join(await getDatabasesPath(), 'UserTrials.db');
//     await deleteDatabase(path);
//     print('Database deleted at: $path');
//   }
// }

// import 'package:shared_preferences/shared_preferences.dart';

class StreakManager {
  static const String _streakKey = 'streakCount';
  static const String _lastRewardDateKey = 'lastRewardDate';

  // static Future<void> initializeStreak() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int currentStreak = prefs.getInt(_streakKey) ?? 0;
  //   String? lastRewardDateString = prefs.getString(_lastRewardDateKey);
  //   DateTime today = DateTime.now();
  //   DateTime lastRewardDate = lastRewardDateString != null
  //       ? DateTime.parse(lastRewardDateString)
  //       : today.subtract(const Duration(days: 2));
  //   int daysDifference = today.difference(lastRewardDate).inDays;
  //   if (daysDifference > 1) {
  //     // Streak is broken, reset it to zero
  //     currentStreak = 0;
  //     await prefs.setInt(_streakKey, currentStreak);
  //   }
  // }

  static Future<void> initializeStreak() async {
    print('in init');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentStreak = prefs.getInt(_streakKey) ?? 0;
    String? lastRewardDateString = prefs.getString(_lastRewardDateKey);
    DateTime today = DateTime.now();
    DateTime lastRewardDate = lastRewardDateString != null
        ? DateTime.parse(lastRewardDateString)
        : today.subtract(const Duration(days: 2));

    int daysDifference = today.difference(lastRewardDate).inDays;

    print("Days since last reward: $daysDifference");
    print("Current streak before check: $currentStreak");

    if (daysDifference > 1) {
      // Streak is broken, reset it to zero
      currentStreak = 0;
      await prefs.setInt(_streakKey, currentStreak);
      print("Streak is broken. Resetting to zero.");
    } else {
      print("Streak continues. No reset needed.");
    }
  }

  /// Increment the streak when reward is collected and update the last reward date.
  static Future<void> incrementStreak() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentStreak = prefs.getInt(_streakKey) ?? 0;
    currentStreak++;

    // Save the updated streak count and set today as the last reward date
    await prefs.setInt(_streakKey, currentStreak);
    await prefs.setString(_lastRewardDateKey, DateTime.now().toIso8601String());
  }

  /// Get the current streak count directly from shared preferences.
  static Future<int> getCurrentStreak() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_streakKey) ?? 0;
  }

  static Future<void> reset(tovalue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_streakKey, tovalue);
    Premium.instance.updatePremium();
  }
}

class AppleManager {
  static const String _appleKey = 'appleCount';

  /// Get the current apple count.
  static Future<int> getCurrentAppleCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_appleKey) ?? 0;
  }

  /// Increase apple count by a specific amount.
  static Future<void> increaseApple(int amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentApple = await getCurrentAppleCount();
    currentApple += amount;
    await prefs.setInt(_appleKey, currentApple);
    // Premium.instance.updatePremium();
  }

  /// Decrease apple count by a specific amount.
  /// Prevents the count from going below zero.
  static Future<void> decreaseApple(int amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentApple = await getCurrentAppleCount();
    currentApple = (currentApple - amount).clamp(0, currentApple);
    await prefs.setInt(_appleKey, currentApple);
    // Premium.instance.updatePremium();
  }

  /// Reset apple count to a specific value, defaulting to zero.
  static Future<void> resetApple(int toValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_appleKey, toValue);
    // Premium.instance.updatePremium();
  }

  static Future<void> RewardCollected() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isPaid = Premium.instance.isPremium.value;
    int streakCount = await StreakManager.getCurrentStreak();
    int cappedStreak = streakCount.clamp(0, 6);
    int todayCollect = isPaid
        ? PremiumTheme.paidTokens[cappedStreak]
        : PremiumTheme.freeTokens[cappedStreak];
    int setto = todayCollect + await getCurrentAppleCount();
    await prefs.setInt(_appleKey, setto);

    // Premium.instance.updatePremium();
  }
}
