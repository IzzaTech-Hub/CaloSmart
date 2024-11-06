import 'package:calories_detector/app/data/day_base.dart';
import 'package:calories_detector/app/notificationservice/local_notification_service.dart';
import 'package:calories_detector/app/premium/premium.dart';
import 'package:calories_detector/app/premium/trailbase.dart';
import 'package:calories_detector/app/providers/applovin_ads_provider.dart';
import 'package:calories_detector/app/services/remoteconfig_services.dart';
import 'package:calories_detector/firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:calories_detector/app/data/Data_Base.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'dart:developer' as developer;

void main() async {
  // Premium().isPremium.value = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

//? -----------------------------------Push notification Implementation below----------------------------------------//
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  LocalNotificationService.initialize();

//?--------------------------------------------------- Push notification Implementation above ---------------------------------------//
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.landscapeRight,
  ]);
  // Initialize the database before running the app
  // DatabaseHelper().deleteDatabaseFile;
  // DatabaseHelper2().deleteDatabaseFile;
  print('1');
  await RemoteConfigService().initialize();
  print('1.5');

  await StreakManager.initializeStreak();
  print('2');
  await DatabaseHelper().database;
  print('3');
  await DatabaseHelper2().database;
  print('4');
  // await TrailbaseHelper.instance.database;
  print('5');
  print('6');
  await Premium.instance.initialize();
  print('7');
  AppLovinProvider.instance.init();

  runApp(
    MyApp(),

    // const MaterialApp(home: SplashView()),
  );
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Message Title: ${message.notification!.title.toString()}");
  print("Message body: ${message.notification!.body.toString()}");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(
    analytics: analytics,
  );

  @override
  Widget build(BuildContext context) {
    // analytics.setAnalyticsCollectionEnabled(true);
    analytics.setAnalyticsCollectionEnabled(kReleaseMode);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      navigatorObservers: <NavigatorObserver>[observer],

      initialRoute: AppPages.INITIAL,
      // initialRoute: AppPages.CHECK,
      getPages: AppPages.routes,
    );
  }
}
//  Future<void> _initializeCamera() async {
//     cameras.value = await availableCameras();
//     Cameracontroller = CameraController(
//       cameras[currentCameraIndex.value],
//       ResolutionPreset.high,
//     );
//     await Cameracontroller?.initialize();
//     isCameraInitialized.value = true;
//   }
//   CameraController? Cameracontroller;
//   final cameras = <CameraDescription>[].obs;
//   final isCameraInitialized = false.obs;
//   final currentCameraIndex = 0.obs;