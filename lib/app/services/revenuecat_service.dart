import 'dart:developer' as dp;

import 'package:calories_detector/app/premium/premium.dart';
import 'package:calories_detector/app/routes/app_pages.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
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
  final entitlementID = "premium_entitlement";
  // final entitlementID = "remove_ads";
  static const _apiKey = 'goog_ytAjbRcAecgrcyBdNgIsmAhjSwG';

  Future<void> checkSubscriptionStatus() async {
    print('Now Checking for subscription');
    try {
      final purchaserInfo = await Purchases.getCustomerInfo();

      final entitelments = purchaserInfo.entitlements.active.values.toList();

      // entitlementInfos.active;
      dp.log("Active Entitlements: ${entitelments.first.identifier}");

      if (entitelments.first.identifier == entitlementID) {
        //? Unlock Premium Features
        // await RemoveAdsForUser(true);
        Premium.instance.isPremium.value = true;
      } else {
        // await RemoveAdsForUser(false);
        Premium.instance.isPremium.value = false;
      }

      print(
          "CheckSubscription: ${purchaserInfo.allPurchasedProductIdentifiers}");
      // if (purchaserInfo.allPurchasedProductIdentifiers
      //     .contains("aislide_adremove_1")) {}
    } catch (error) {
      // await RemoveAdsForUser(false);
      Premium.instance.isPremium.value = false;

      // Error occurred while fetching the subscription status
      print('Error: $error');
    }
  }

  Future<void> initialize() async {
    // String customerID="ranasherry94@gmail.com";

    // if (kDebugMode) {
    //   userID = "\$RCAnonymousID:22a7f8f7cd4f4080beb2e366ff3daaec";
    // }

    // dp.log("Inititalizing Revenue cart: $userID");
    await Purchases.setLogLevel(LogLevel.debug);

    await Purchases.configure(PurchasesConfiguration(
      _apiKey,
    ));

    dp.log('in app purchase initialized');
    getAllSubscriptionProducts();
    // checkSubscriptionStatus();
    //     .then((value) async {
    //   getRemoveAdProduct();
    //   await checkSubscriptionStatus();
    //   FirestoreService().UserID = await Purchases.appUserID;
    //   if (currentEntitlement.value == Entitlement.paid) {
    //     try {
    //       CreateFirebaseUser();
    //     } catch (e) {
    //       dp.log("Firebase Error: $e");
    //     }
    //   }
    // });

    // getRemoveAdProduct();
    // await checkSubscriptionStatus();
    // FirestoreService().UserID = await Purchases.appUserID;
  }

  Future<List<StoreProduct>> getAllSubscriptionProducts() async {
    // Get offerings
    final offerings = await Purchases.getOfferings();

    // dp.log("All Offering: $offerings");

    // Check if "premium_subscription" offering exists
    final premiumOffering = offerings.current!;
    PremiumTheme.offering = premiumOffering;
    // final premiumOffering = offerings.getOffering("temp_offering");
    // premiumOffering!.availablePackages[0].storeProduct.price;
    try {
      PremiumTheme.monthlyMembership =
          premiumOffering.monthly!.storeProduct.price;
      PremiumTheme.monthlyMembershipString =
          premiumOffering.monthly!.storeProduct.priceString;
    } catch (e) {
      try {
        PremiumTheme.monthlyMembership =
            premiumOffering.weekly!.storeProduct.price / 2.5 * 4;
        PremiumTheme.monthlyMembershipString =
            premiumOffering.weekly!.storeProduct.priceString;
      } catch (e) {
        PremiumTheme.monthlyMembership = 0;
        PremiumTheme.monthlyMembershipString = '0.0\$';
      }
    }
    try {
      PremiumTheme.weeklyMembership =
          premiumOffering.weekly!.storeProduct.price;
      PremiumTheme.weeklyMembershipString =
          premiumOffering.weekly!.storeProduct.priceString;
    } catch (e) {
      try {
        PremiumTheme.weeklyMembership =
            premiumOffering.monthly!.storeProduct.price / 4 * 2.5;
        PremiumTheme.weeklyMembershipString =
            premiumOffering.monthly!.storeProduct.priceString;
      } catch (e) {
        PremiumTheme.weeklyMembership = 0;
        PremiumTheme.weeklyMembershipString = '0.0\$';
      }
    }
    try {
      PremiumTheme.anuallyMembership =
          premiumOffering.annual!.storeProduct.price;
      PremiumTheme.anuallyMembershipString =
          premiumOffering.annual!.storeProduct.priceString;
    } catch (e) {
      PremiumTheme.anuallyMembership = 0;
      PremiumTheme.anuallyMembershipString = '0.0\$';
    }
    dp.log("Temp Offering: $premiumOffering");

    return [];
  }

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

  Future<void> purchaseSubscriptionWithProduct(StoreProduct product) async {
    // facebookAppEvents.logAddToWishlist(
    //     id: product.identifier,
    //     type: "InApp",
    //     currency: product.currencyCode,
    //     price: product.price);

    try {
      EasyLoading.show(status: "Please wait...");
      // final purchaserInfo = await Purchases.purchaseStoreProduct(product);

      //? New Method
      // final purchaserInfo = await Purchases.getCustomerInfo();
      final purchaserInfo = await Purchases.purchaseStoreProduct(product);

      // final entitelments = purchaserInfo.entitlements.active.values.toList();
      final entitelments = purchaserInfo.entitlements.active.values.toList();

      // entitlementInfos.active;
      dp.log("Active Entitlements: ${entitelments.first.identifier}");

      //? Unlock Premium Features
      Premium.instance.isPremium.value = true;
      EasyLoading.showSuccess("Congratulation your are a Premium User now");
      Get.offAllNamed(Routes.NAVBAR);

      // TODO: Check if user is logged in or not. if logged in, update Revenue Cat User ID else Goto Signin Page

      EasyLoading.dismiss();
    }

    // print("PurchaseInfo: ${purchaserInfo.allPurchasedProductIdentifiers}");
    // if (purchaserInfo.allPurchasedProductIdentifiers
    //     .contains("aislide_adremove_1")) {
    //   RemoveAdsForUser();
    //   CreateFirebaseUser();
    //   if (kReleaseMode) {
    //     FirebaseAnalytics.instance.logPurchase(
    //         currency: product.currencyCode,
    //         value: product.price,
    //         items: [
    //           AnalyticsEventItem(
    //               itemId: product.identifier, price: product.price)
    //         ]);
    //   }
    // }
    // Handle successful purchase
    catch (error) {
      EasyLoading.dismiss();
      

      // Handle purchase error
    }
  }
}

extension on PurchaseResult {
  get entitlements => null;
}

enum Entitlement { free, paid }
