import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../../../data/food_item.dart';
import '../../../data/Data_Base.dart';

Color onSecondaryColor = const Color(0xffFFffff);
Color secondaryColor = Color(0xffFF4D6D);
Color primaryColor = Color(0xffFFD1DC);
Color onPrimaryColor = Color(0xff1E3A5F);

class ResponseScreenController extends GetxController {
  void logFeed(FoodData foodData) async {
    final dbHelper = DatabaseHelper(); // Create an instance of DatabaseHelper

    try {
      await dbHelper.insertFoodData(foodData);
      // Insert FoodData into the database
      print('Food data logged successfully.');
    } catch (e) {
      print('Error logging food data: $e');
    }
  }

  Rxn<Image> imageFile = Rxn<Image>();
  Rxn<FoodData> foodData = Rxn<FoodData>();
  @override
  void onInit() {
    final arguments = Get.arguments;
    final FoodData response = arguments[0];
    imageFile.value = arguments[1];
    print("Argument ${response}");
    foodData.value = response;
    // Map<String, dynamic> jsonMap = jsonDecode(response);
    // foodData.value = FoodData.fromJson(jsonMap);

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  final count = 0.obs;

  void increment() => count.value++;
}
