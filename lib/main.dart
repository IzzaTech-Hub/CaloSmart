import 'package:flutter/material.dart';
import 'package:calories_detector/app/data/Data_Base.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  // Ensure that widget bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the database before running the app
  await DatabaseHelper().database;
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      // initialRoute: AppPages.HISTORY_VIEW,
      getPages: AppPages.routes,
    ),

    // const MaterialApp(home: SplashView()),
  );
}

