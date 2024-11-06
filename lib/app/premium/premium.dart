import 'package:calories_detector/app/data/day_base.dart';
import 'package:calories_detector/app/data/oneday.dart';
import 'package:calories_detector/app/premium/trailbase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Premium {
  Premium._privateConstructor();
  static final Premium instance = Premium._privateConstructor();
  OneDay? toDay;
  RxBool? isPremium = false.obs;
  // RxBool? canScan = false.obs;
  // RxInt? trail = 0.obs;
  RxInt? currentStreak = 0.obs;
  RxBool? isrewardCollected = false.obs;
  RxInt? apple = 0.obs;
  Future<void> initialize() async {
    toDay = await DatabaseHelper2()
        .fetchOneDay(DateFormat('dd/MM/yyyy').format(DateTime.now()));
    isrewardCollected!.value = toDay!.isRewardCollected.value;
    isPremium!.value = false;
    if (isrewardCollected!.value) {
      await AppleManager.resetApple(0);
    }
    // trail!.value = await getapples();
    currentStreak!.value = await StreakManager.getCurrentStreak();
    apple!.value = await AppleManager.getCurrentAppleCount();
  }

  reduce1(int tovalue) async {
    // await TrailbaseHelper.instance.decrementTrial();
    AppleManager.decreaseApple(tovalue);
    updatePremium();
  }

  rewardCollected() async {
    await DatabaseHelper2()
        .toggleRewardCollected(DateFormat('dd/MM/yyyy').format(DateTime.now()));

    await AppleManager.RewardCollected();
    await StreakManager.incrementStreak();
    updatePremium();
  }

  // Future<int> getapples() async {
  //   int trailsLeft = await TrailbaseHelper.instance.getTrialsLeft();
  //   if (trailsLeft > 0) {
  //     canScan!.value = true;
  //   } else {
  //     canScan!.value = false;
  //   }
  //   return trailsLeft;
  // }

  updatePremium() async {
    toDay = await DatabaseHelper2()
        .fetchOneDay(DateFormat('dd/MM/yyyy').format(DateTime.now()));
    currentStreak!.value = await StreakManager.getCurrentStreak();
    print('herethe value is ${toDay!.isRewardCollected.value}');
    isrewardCollected!.value = toDay!.isRewardCollected.value;
    // trail!.value = await getapples();
    apple!.value = await AppleManager.getCurrentAppleCount();
  }
}

class PremiumTheme {
  // static const appleColor = Colors.grey;
  static const appleColor = Colors.red;
  // static const freeToken1 = 5;
  // static const freeToken2 = 6;
  // static const freeToken3 = 8;
  // static const freeToken4 = 10;
  // static const freeToken5 = 12;
  // static const freeToken6 = 15;
  // static const freeToken7 = 18;
  // static const paidToken1 = 20;
  // static const paidToken2 = 25;
  // static const paidToken3 = 30;
  // static const paidToken4 = 35;
  // static const paidToken5 = 40;
  // static const paidToken6 = 45;
  // static const paidToken7 = 50;
  static const List<int> freeTokens = [5, 6, 8, 10, 12, 15, 18];
  static const List<int> paidTokens = [20, 25, 30, 35, 40, 45, 50];

  static const scanPrice = 5;
  static const manualEntryPrice = 1;
  static const alternatePrice = 3;
  static const comparisonPrice = 5;
}
