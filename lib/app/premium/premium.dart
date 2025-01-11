import 'package:calories_detector/app/data/day_base.dart';
import 'package:calories_detector/app/data/oneday.dart';
import 'package:calories_detector/app/premium/trailbase.dart';
import 'package:calories_detector/app/services/revenuecat_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class Premium {
  Premium._privateConstructor();
  static final Premium instance = Premium._privateConstructor();
  OneDay? toDay;
  RxBool isPremium = false.obs;
  // RxBool? canScan = false.obs;
  // RxInt? trail = 0.obs;
  RxInt? currentStreak = 0.obs;
  RxBool? isrewardCollected = false.obs;
  RxInt? apple = 0.obs;
  Future<void> initialize() async {
    toDay = await DatabaseHelper2()
        .fetchOneDay(DateFormat('dd/MM/yyyy').format(DateTime.now()));
    isrewardCollected!.value = toDay!.isRewardCollected.value;
    isPremium.value = false;
    // if (isrewardCollected!.value) {
    //   await AppleManager.resetApple(0);
    // }
    // trail!.value = await getapples();
    currentStreak!.value = await StreakManager.getCurrentStreak();
    apple!.value = await AppleManager.getCurrentAppleCount();
    RevenueCatService().checkSubscriptionStatus();
  }

  reduce1(int tovalue) async {
    // await TrailbaseHelper.instance.decrementTrial();
    AppleManager.decreaseApple(tovalue);
    updatePremium();
  }

  increaseapple(int tovalue) async {
    // await TrailbaseHelper.instance.decrementTrial();
    AppleManager.increaseApple(tovalue);
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
  static Offering? offering;
  // static const appleColor = Colors.grey;
  static const appleColor = Colors.red;

  static const List<int> basefreeTokens = [5, 6, 8, 10, 12, 15, 18];
  static const List<int> basepaidTokens = [20, 25, 30, 35, 40, 45, 50];
  static List<int> freeTokens = [5, 6, 8, 10, 12, 15, 18];
  static List<int> paidTokens = [20, 25, 30, 35, 40, 45, 50];

  static var scanPrice = 5;
  static var manualEntryPrice = 1;
  static var alternatePrice = 3;
  static var comparisonPrice = 5;
  static var welcomeReward = 30;
  static var adReward = 5;

  static var weeklyMembership = 2.99;
  static var anuallyMembership = 9.99;
  static var monthlyMembership = 6.99;
  static var weeklyMembershipString = '2.99\$';
  static var monthlyMembershipString = '6.99\$';
  static var anuallyMembershipString = '9.99\$';
}
