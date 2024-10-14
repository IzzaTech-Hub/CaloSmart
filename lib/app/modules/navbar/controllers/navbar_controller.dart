import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:calories_detector/app/data/food_item.dart';
import 'package:calories_detector/app/modules/ResponseScreen/controllers/response_screen_controller.dart';
import 'package:calories_detector/app/modules/ResponseScreen/views/response_screen_view.dart';
import 'package:calories_detector/app/modules/home/views/history_show.dart';
import 'package:calories_detector/app/modules/home/views/home_view.dart';
import 'package:calories_detector/app/modules/liquidloading/views/liquidloading_view.dart';
import 'package:calories_detector/app/modules/settings/views/settings_view.dart';
import 'package:calories_detector/app/modules/utills/Themes/current_theme.dart';
import 'package:calories_detector/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

// RxString tempprompt = ''.obs;
FoodData? navFoodData;
Uint8List? navImg;
final ImagePicker _picker = ImagePicker();

class NavbarController extends GetxController {
  void resetFunction() {
    currentBody = bodyList[index.value];
    currentAppBar = appBarList[index.value];
    print('${index.value}');
  }

  RxBool showButtons = false.obs;

  RxInt index = 0.obs;
  List<Widget> bodyList = <Widget>[
    HomeView(),
    HistoryShow(),
    ResponseScreenView(),
    SettingsView()
  ];
  List<Widget> appBarList = <Widget>[
    HomeViewAppBar(),
    HistoryShowAppBar(),
    ResponseScreenAppBar(),
    SettingsViewAppBar()
  ];

  Widget currentBody = HomeView();
  Widget currentAppBar = HomeViewAppBar();

  final count = 0.obs;
  @override
  void onInit() {
    // HomeController().updateInitial();
    // Widget currentBody = bodyList[index.value];
    // Widget currentAppBar = appBarList[index.value];
    super.onInit();
  }



  void increment() => count.value++;

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        File imageFile = File(image.path);
        print('Image Path: ${image.path}');
        sendImageToGoogleAI(imageFile); // Send image to Gemini
      }
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> sendImageToGoogleAI(File imgFile) async {
    // Get.back();
    // Get.dialog(
    //   Container(
    //     color: AppThemeColors.secondery1
    //         .withOpacity(0.6), // Semi-transparent background
    //     child: Center(
    //       child: Container(
    //         padding: EdgeInsets.all(20),
    //         decoration: BoxDecoration(
    //           color: Colors.white, // Background for the dialog content
    //           borderRadius: BorderRadius.circular(20),
    //           boxShadow: [
    //             BoxShadow(
    //               color: Colors.black.withOpacity(0.2),
    //               blurRadius: 10,
    //               offset: Offset(0, 4),
    //             ),
    //           ],
    //         ),
    //         width: SizeConfig.screenWidth * 0.8,
    //         child: Column(
    //           mainAxisSize:
    //               MainAxisSize.min, // Shrinks the column to fit content
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             Text(
    //               'Analyzing your image...',
    //               textAlign: TextAlign.center,
    //               style: TextStyle(
    //                 // fontFamily: 'Inter', // Inter font family
    //                 fontSize: 18,
    //                 fontWeight: FontWeight.bold,
    //                 color: Colors.black54, // color: AppThemeColors.onPrimary1,
    //                 decoration: TextDecoration.none,
    //               ),
    //             ),
    //             SizedBox(height: 30),
    //             LinearProgressIndicator(
    //               valueColor: AlwaysStoppedAnimation<Color>(
    //                   AppThemeColors.onPrimary1), // Custom progress bar color
    //               backgroundColor: AppThemeColors.secondery1.withOpacity(0.2),
    //               minHeight: 8, // Thickness of the loading bar
    //             ),
    //             SizedBox(height: 20),
    //             // Text(
    //             //   'Please wait while we process your image...',
    //             //   textAlign: TextAlign.center,
    //             //   style: TextStyle(
    //             //     // fontFamily: 'Inter', // Inter font family
    //             //     fontSize: 14,
    //             //     color: Colors.grey[600],
    //             //     decoration: TextDecoration.none,
    //             //   ),
    //             // ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    //   barrierDismissible: false, // Prevent dismissing by tapping outside
    // );
    Get.dialog(
      Container(
        color: AppThemeColors.secondery1.withOpacity(0.6),
        child: Center(
          child: Container(
            clipBehavior: Clip.hardEdge,
            height: SizeConfig.screenHeight * 0.2,
            width: SizeConfig.screenWidth * 0.9,

            // padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: LiquidloadingView(),
          ),
        ),
      ),
      barrierDismissible: false, // Prevent dismissing by tapping outside
    );

    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: 'AIzaSyD4cCpD7lP-Q9raPF59L8npR8H5NF3pLIo',
    );
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString('selected_button') ?? 'None');
    final prompt =
        'you are an expert dietician. You will be given an image of some food item/items.tell the name/names of the food/foods given in image,and quantity of it/them quantity can be any thing like no. of slice,no.of items with name, mass in kg no. of scoops, no. of litres or anything else suitable for that food. then tell 1 best and healthy alternates for it to consume instead of them if i want to ${prefs.getString('selected_button') ?? 'None'}. Analyze the nutritional content and tell how much water(in liters) should be drank after consuming these in waterquantity and how much exercise should be done(in hours).Values of vitamins and minerals in DV.Dietary Labels:Vegan,Vegetarian,Paleo,Keto,Gluten-Free,Dairy-Free,Low-Fat,Low-Carb,High-Fiber,Allergens:Gluten,Dairy,Eggs,Nuts,Soy,Shellfish,Warnings/Alerts:High in Sugar,High in Sodium,High in Saturated Fat,Contains Additives (e.g., preservatives, colorants) or you can tell none if there is not any in health score give it rating from five stars .At last give a short description about why should i consume the alternate how it is better than original. provide a response in JSON format with the following structure:\n'
        '''
{
  "item": {\n
    "name": "<string>",\n
    "quantity": "<string>",\n
    "calories": <int>,\n
    "macronutrients": {\n
      "fat": <float>,\n
      "carbs": <float>,\n
      "protein": <float>,\n
      "fiber": <float>,\n
      "sugars": <float>,\n
      "saturatedFats": <float>,\n
      "unsaturatedFats": <float>,\n
      "transFats": <float>\n
    },\n
    "micronutrients": {\n
      "vitamins": {\n
        "vitaminA": "<string>", \n
        "vitaminC": "<string>",\n
        "vitaminD": "<string>",\n
        "vitaminE": "<string>",\n
        "vitaminK": "<string>",\n
        "vitaminB1": "<string>", \n
        "vitaminB2": "<string>",\n
        "vitaminB3": "<string>",\n
        "vitaminB5": "<string>",\n
        "vitaminB6": "<string>",\n
        "vitaminB7": "<string>",\n
        "vitaminB9": "<string>",\n
        "vitaminB12": "<string>"\n
      },\n
      "minerals": {\n
        "calcium": "<string>",\n
        "iron": "<string>",\n
        "potassium": "<string>",\n
        "magnesium": "<string>",\n
        "zinc": "<string>",\n
        "sodium": "<string>",\n
        "phosphorus": "<string>",\n
        "copper": "<string>",\n
        "manganese": "<string>",\n
        "selenium": "<string>",\n
        "iodine": "<string>"\n
      }\n
    },\n
    "additionalNutrients": {\n
      "cholesterol": <string>,\n
      "waterContent": "<string>",\n
      "caffeine": <string>\n
    },\n
    "allergens": ["<string>", "<string>"],\n
    "dietCompatibility": ["<string>", "<string>"],\n
    "warnings": ["<string>", "<string>"],\n
    "healthScore": <int>,\n
    "waterquantity": <float>,\n
    "exercise": <float>\n
  },\n
  "alternate1": {\n
    "name": "<string>",\n
    "quantity": "<string>",\n
    "calories": <int>,\n
    "macronutrients": {\n
      "fat": <float>,\n
      "carbs": <float>,\n
      "protein": <float>,\n
      "fiber": <float>,\n
      "sugars": <float>,\n
      "saturatedFats": <float>,\n
      "unsaturatedFats": <float>,\n
      "transFats": <float>\n
    },\n
    "micronutrients": {\n
      "vitamins": {\n
        "vitaminA": "<string>", \n
        "vitaminC": "<string>",\n
        "vitaminD": "<string>",\n
        "vitaminE": "<string>",\n
        "vitaminK": "<string>",\n
        "vitaminB1": "<string>", \n
        "vitaminB2": "<string>",\n
        "vitaminB3": "<string>",\n
        "vitaminB5": "<string>",\n
        "vitaminB6": "<string>",\n
        "vitaminB7": "<string>",\n
        "vitaminB9": "<string>",\n
        "vitaminB12": "<string>"\n
      },\n
      "minerals": {\n
        "calcium": "<string>",\n
        "iron": "<string>",\n
        "potassium": "<string>",\n
        "magnesium": "<string>",\n
        "zinc": "<string>",\n
        "sodium": "<string>",\n
        "phosphorus": "<string>",\n
        "copper": "<string>",\n
        "manganese": "<string>",\n
        "selenium": "<string>",\n
        "iodine": "<string>"\n
      }\n
    },\n
    "additionalNutrients": {\n
      "cholesterol": <string>,\n
      "waterContent": "<string>",\n
      "caffeine": <string>\n
    },\n
    "allergens": ["<string>", "<string>"],\n
    "dietCompatibility": ["<string>", "<string>"],\n
    "warnings": ["<string>", "<string>"],\n
    "healthScore": <int>,\n
    "waterquantity": <float>,\n
    "exercise": <float>\n
  },\n
  "description": "<string>"\n
}


'''
        'dont give me any text or disclaimer or note your response should start from { bracket of json structure and end with } json bracket';

//         {
//   "item": {
//     "name": "<string>",\n
//     "quantity": "<string>",\n
//     "fat": <int>,\n
//     "carbs": <int>,\n
//     "protein": <int>,\n
//     "waterquantity": <float>,\n
//     "exercise": <float>\n
//   },\n
//   "alternate1": {
//     "name": "<string>",\n
//     "quantity": "<string>",\n
//     "fat": <int>,\n
//     "carbs": <int>,\n
//     "protein": <int>,\n
//     "waterquantity": <float>,\n
//     "exercise": <float>\n
//   },\n
//   "description":<string>\n
// }
    print(prompt);
    Uint8List imageBytes = await imgFile.readAsBytes();

    final content = [
      Content.multi([TextPart(prompt), DataPart('image/jpeg', imageBytes)]),
    ];
    //   final response = await model.generateContent(content);
    // print(response.text);
    //     Map<String, dynamic> jsonMap = jsonDecode(response.text?? '');

    // FoodData foodData = FoodData.fromJson(jsonMap);
    try {
      final response = await model.generateContent(content);
      // Map<String, dynamic> jsonMap = jsonDecode(response.text ?? '');
      // FoodData foodData = FoodData.fromJson(jsonMap);

      // FoodData foodData = await parseFoodData();
      // Close the loading dialog
      print(response.text);
      // tempprompt.value = response.text!;
      // print(foodData.item.name);

      Map<String, dynamic> jsonMap = jsonDecode(response.text ?? '');
      // print(jsonMap['item']);
      FoodData foodData = FoodData.fromJson(jsonMap);
      Get.back();
      goToREsponse(foodData, imageBytes);
    } catch (e) {
      // Close the loading dialog
      Get.back();

      // Handle the error
      Get.snackbar(
        'Error',
        // 'Failed to get response: $e',
        'There is something Wrong with your image',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void goToREsponse(FoodData foodData, Uint8List imgFile) {
    try {
      navFoodData = foodData;
      navImg = imgFile;
      
      ResponseScreenController().transfercallFunction(foodData, imgFile);
      // Get.toNamed(Routes.RESPONSE_SCREEN,
      //     // arguments: [response.text ?? '',Image.file(imgFile)]
      //     arguments: [foodData, imgFile]);
      isrespnse.value = true;
      index.value = 2;
    } catch (e) {
      Get.snackbar(
        'Error',
        // 'Failed to get response:\nThere is something Wrong with your image',
        'There is something Wrong with your image',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
