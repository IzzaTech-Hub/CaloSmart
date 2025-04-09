import 'dart:convert';
import 'dart:math';
import 'dart:developer' as dp;

import 'package:calories_detector/app/modules/utills/remoteConfigVariables.dart';
import 'package:calories_detector/app/premium/premium.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

import 'package:get/get.dart';

class RemoteConfigService {
  static final RemoteConfigService _instance = RemoteConfigService._internal();

  factory RemoteConfigService() {
    // Purchases.setEmail(email)
    return _instance;
  }

  RemoteConfigService._internal();

  final remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> initialize() async {
    print("Iniitalizing Remote config...");
    try {
      GetRemoteConfig().then((value) {
        SetRemoteConfig();

        remoteConfig.onConfigUpdated.listen((event) async {
          print("Remote Updated");
          //  await remoteConfig.activate();
          SetRemoteConfig();

          // Use the new config values here.
          print('successfully get remote config');
        });
      });
    } catch (e) {
      print('Cant get remote config');
    }
  }

  Future GetRemoteConfig() async {
    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(seconds: 1),
      ));

      await remoteConfig.setDefaults(const {
        "GemeniAPIKey": "AIzaSyD4cCpD7lP-Q9raPF59L8npR8H5NF3pLIo",
        "PrivacyPolicyLink":
            "https://docs.google.com/document/d/1p3TlpUixPKvev9rMR-bo3tv-8yOvf6n3/edit?usp=drive_link&ouid=116035705295374336742&rtpof=true&sd=true",
      });

      await remoteConfig.fetchAndActivate();
    } on Exception catch (e) {
      // TODO
      print("Remote Config error: $e");
    }
  }

  Future SetRemoteConfig() async {
    RCVariables.GemeniAPIKey.value = remoteConfig.getString('GemeniAPIKey');
    RCVariables.PrivacyPolicyLink.value =
        remoteConfig.getString('PrivacyPolicyLink');
    RCVariables.GemeniAiModel.value =
        remoteConfig.getString('GemeniAiModel');
    dp.log("trying rc");

// var jsonMap=remoteConfig.getString('Json');
Map<String, dynamic> jsonData = json.decode(remoteConfig.getString('Json'));
 PremiumTheme.freeTokens = List<int>.from(jsonData['freeTokens']);
  PremiumTheme.paidTokens = List<int>.from(jsonData['paidTokens']);
  
  Map<String, dynamic> prices = jsonData['prices'];
  Map<String, dynamic> rewards = jsonData['rewards'];

  PremiumTheme.scanPrice = prices['scanPrice'];
  PremiumTheme. manualEntryPrice = prices['manualEntryPrice'];
  PremiumTheme. alternatePrice = prices['alternatePrice'];
  PremiumTheme. comparisonPrice = prices['comparisonPrice'];
  PremiumTheme. welcomeReward = rewards['welcomeReward'];
  PremiumTheme. adReward = rewards['adReward'];

    // var tempstring = remoteConfig.getString('FreeTokenRewards');
    // dp.log("Get From rc");
    // PremiumTheme.freeTokens = List<int>.from(json.decode(tempstring));
    dp.log("Fetched Key: ${RCVariables.GemeniAPIKey.value}");
    // dp.log("Fetched Key: ${PremiumTheme.freeTokens}");
    // dp.log("Fetched Key: ${PremiumTheme.paidTokens}");
  }
}
