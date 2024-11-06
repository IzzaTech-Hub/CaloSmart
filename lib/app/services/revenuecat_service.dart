import 'dart:developer' as dp;

import 'package:calories_detector/app/premium/premium.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:ai_chatbot/app/modules/routes/app_pages.dart';
// import 'package:flutter_gif/flutter_gif.dart';
// import 'package:purchases_flutter/purchases_flutter.dart';

// import '../modules/home/controllers/nav_view_ctl.dart';
// import '../modules/utills/Gems_rates.dart';

// class RevenueCatIDs {
//   // static const idGems10 = '10_gems';
//   static const removeAdID = 'aislide_adremove_1';

//   static const allids = [
//     // idGems10,
//     removeAdID
//   ];
// }

class RevenueCatService {
  static final RevenueCatService _instance = RevenueCatService._internal();

  factory RevenueCatService() {
    // Purchases.setEmail(email)
    return _instance;
  }

  RevenueCatService._internal();

  Rx<Entitlement> currentEntitlement = Entitlement.free.obs;

  Future<bool> CheckRemoveAdsForUser() async {
    final prefs = await SharedPreferences.getInstance();
    final isAdRemoved = prefs.getBool('isAdRemoved') ?? false;

    if (isAdRemoved) {
      RevenueCatService().currentEntitlement.value = Entitlement.paid;
      // Premium.instance.isPremium!.value = true;
    } else {
      RevenueCatService().currentEntitlement.value = Entitlement.free;
      // Premium.instance.isPremium!.value = false;
    }
    dp.log("IsAdRemoved: $isAdRemoved");
    dp.log(
        "CurrentEntitlement: ${RevenueCatService().currentEntitlement.value}");

    return isAdRemoved;
  }
}

enum Entitlement { free, paid }
