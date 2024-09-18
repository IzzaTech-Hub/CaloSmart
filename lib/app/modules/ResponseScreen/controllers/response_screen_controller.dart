import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../../../data/food_item.dart';

Color onSecondaryColor = const Color(0xffFFffff);
Color secondaryColor = Color(0xffFF4D6D);
Color primaryColor = Color(0xffFFD1DC);
Color onPrimaryColor = Color(0xff1E3A5F);
// String nameOfDish = 'A piece of cake';
// String waterQ = 'Drink 5 Glasses of water';
// String exerciseQ = 'Exercise for 0.5 hours';
// String quantity = 'in one piece(0.5kg)';
// int noOfCalories = 272;

// int carbsW = 20;
// int carbsp = 40;
// int protienW = 30;
// int protienp = 30;
// int fatW = 60;
// int fatp = 100 - carbsp - protienp;

class ResponseScreenController extends GetxController {
  // final arguments = Get.arguments as Map;

  //TODO: Implement ResponseScreenController

  final count = 0.obs;

  // late Rx<Image>? imageFile;
  // late Rx<FoodData>? foodData;
  Rxn<Image> imageFile = Rxn<Image>();
  Rxn<FoodData> foodData = Rxn<FoodData>();
  @override
  void onInit() {
    final arguments = Get.arguments;
    final String response = arguments[0];
    imageFile.value = arguments[1];
    print("Argument ${response}");
    Map<String, dynamic> jsonMap = jsonDecode(response);
    foodData.value = FoodData.fromJson(jsonMap);

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

  void increment() => count.value++;
}
