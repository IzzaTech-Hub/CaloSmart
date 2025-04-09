import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:calories_detector/app/data/Data_Base.dart';
import 'package:calories_detector/app/data/day_base.dart';
import 'package:calories_detector/app/data/food_item.dart';
import 'package:calories_detector/app/modules/ResponseScreen/controllers/response_screen_controller.dart';
import 'package:calories_detector/app/modules/ResponseScreen/views/response_screen_view.dart';
import 'package:calories_detector/app/modules/aichat/views/aichat_view.dart';
import 'package:calories_detector/app/modules/home/controllers/history_show_controller.dart';
import 'package:calories_detector/app/modules/home/controllers/home_controller.dart';
import 'package:calories_detector/app/modules/home/views/history_show.dart';
import 'package:calories_detector/app/modules/home/views/home_view.dart';
import 'package:calories_detector/app/modules/liquidloading/views/liquidloading_view.dart';
import 'package:calories_detector/app/modules/settings/views/settings_view.dart';
import 'package:calories_detector/app/modules/utills/Themes/current_theme.dart';
import 'package:calories_detector/app/modules/utills/app_images.dart';
import 'package:calories_detector/app/modules/utills/remoteConfigVariables.dart';
import 'package:calories_detector/app/premium/premium.dart';
import 'package:calories_detector/app/routes/app_pages.dart';
import 'package:calories_detector/sizeConfig.dart';
import 'package:flutter/foundation.dart';
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
  // RxBool isPermissionDenied;

  // final bool checkForDialog;
  // NavbarController(this.checkForDialog);
  void resetFunction() {
    currentBody = bodyList[index.value];
    currentAppBar = appBarList[index.value];
    print('index is ${index.value}');
  }

  void changeindex(int tothis) {
    index.value = tothis;
  }

  RxBool showButtons = false.obs;

  RxInt index = 0.obs;
  List<Widget> bodyList = <Widget>[
    HomeView(),
    HistoryShow(),
    // ResponseScreenView(),
    // AichatView(),
    SettingsView(),
    SettingsView()
  ];
  List<Widget> appBarList = <Widget>[
    HomeViewAppBar(),
    HistoryShowAppBar(),
    // ResponseScreenAppBar(),
    // AichatViewAppBar(),
    SettingsViewAppBar(),
    SettingsViewAppBar()
  ];

  Widget currentBody = HomeView();
  Widget currentAppBar = HomeViewAppBar();

  final count = 0.obs;
  @override
  void onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
    if (isFirstLaunch) {
      // if (0 == 0) {
      await prefs.setBool('isFirstLaunch', false);
      Get.dialog(
          AlertDialog(
            title: Text('Disclaimer'),
            content: Text(
                textAlign: TextAlign.justify,
                'The nutritional information provided by this app is intended for informational purposes only and should not be considered a substitute for professional dietary advice. While we strive to offer accurate estimates of calories and nutrients based on the food images provided, the data may not always be 100% accurate due to variations in food preparation, portion sizes, and other factors. Users should use this information as a general guide and consult a healthcare professional for precise dietary recommendations.'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.dialog(
                    Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15), // Rounded corners
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: AppThemeColors.buttonColor,
                          borderRadius: BorderRadius.circular(
                              15), // Keep gradient rounded
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Welcome Reward',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors
                                      .white, // Make title stand out on gradient
                                ),
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(AppImages.applecenter),
                                  Text('X ${PremiumTheme.welcomeReward}')
                                ],
                              ),
                              SizedBox(height: 15),
                              Text('Can only be used today'),
                              SizedBox(height: 15),
                              ElevatedButton.icon(
                                onPressed: () {
                                  Get.back();
                                  Premium.instance.increaseapple(
                                      PremiumTheme.welcomeReward);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                icon: Icon(Icons.check,
                                    color: AppThemeColors.onPrimary1),
                                label: Text('Collect',
                                    style: TextStyle(color: Colors.black)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    barrierDismissible: false,
                  );
                },
                child: Text('OK'),
              ),
            ],
          ),
          barrierDismissible: false);
    }

    if (Get.arguments != null && Get.arguments[0] is bool) {
      bool isPermissionDenied = Get.arguments[0] as bool;
      if (isPermissionDenied) {
        Get.snackbar('Permission denied',
            "Unable to Scan from camera. now finding image from gallery",
            snackPosition: SnackPosition.BOTTOM);
        await Future.delayed(Duration(seconds: 2));
        pickImageFromGallery();
      }
    }
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
        sendImageToGoogleAI(imageFile);
      }
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
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
    final prefs = await SharedPreferences.getInstance();
    final prompt =
        'you are an expert dietician. You will be given an image of some food item/items.tell the name/names of the food/foods given in image,and quantity of it/them quantity can be any thing like no. of slice,no.of items with name, mass in kg no. of scoops, no. of litres or anything else suitable for that food. then tell 1 best and healthy alternates for it to consume instead of them if i want to ${prefs.getString('selected_button') ?? 'None'}. Analyze the nutritional content and tell how much water(in liters) should be drank after consuming these in waterquantity and how much exercise should be done(in hours).Values of vitamins and minerals in DV.Dietary Labels:Vegan,Vegetarian,Paleo,Keto,Gluten-Free,Dairy-Free,Low-Fat,Low-Carb,High-Fiber,Allergens:Gluten,Dairy,Eggs,Nuts,Soy,Shellfish,Warnings/Alerts:High in Sugar,High in Sodium,High in Saturated Fat,Contains Additives (e.g., preservatives, colorants) or you can tell none if there is not any in health score give it rating from five stars .At last give a short description about why should i consume the alternate how it is better than original. provide a response in JSON format with the following structure:\n';

    final model = GenerativeModel(
      // model: 'gemini-1.5-flash',
      model: RCVariables.GemeniAiModel.value,
      apiKey: RCVariables.GemeniAPIKey.value,
      generationConfig: GenerationConfig(
        temperature: 1,
        topK: 40,
        topP: 0.95,
        maxOutputTokens: 8000,
        responseMimeType: 'application/json',
        responseSchema: Schema(
          SchemaType.object,
          enumValues: [],
          requiredProperties: ["item"],
          properties: {
            "item": Schema(
              SchemaType.object,
              enumValues: [],
              requiredProperties: [
                "name",
                "quantity",
                "calories",
                "macronutrients",
                "micronutrients",
                "additionalNutrients",
                "allergens",
                "dietCompatibility",
                "warnings",
                "healthScore",
                "waterquantity",
                "exercise"
              ],
              properties: {
                "name": Schema(
                  SchemaType.string,
                ),
                "quantity": Schema(
                  SchemaType.string,
                ),
                "calories": Schema(
                  SchemaType.integer,
                ),
                "macronutrients": Schema(
                  SchemaType.object,
                  enumValues: [],
                  requiredProperties: [
                    "fat",
                    "carbs",
                    "protein",
                    "fiber",
                    "sugars",
                    "saturatedFats",
                    "unsaturatedFats",
                    "transFats"
                  ],
                  properties: {
                    "fat": Schema(
                      SchemaType.number,
                    ),
                    "carbs": Schema(
                      SchemaType.number,
                    ),
                    "protein": Schema(
                      SchemaType.number,
                    ),
                    "fiber": Schema(
                      SchemaType.number,
                    ),
                    "sugars": Schema(
                      SchemaType.number,
                    ),
                    "saturatedFats": Schema(
                      SchemaType.number,
                    ),
                    "unsaturatedFats": Schema(
                      SchemaType.number,
                    ),
                    "transFats": Schema(
                      SchemaType.number,
                    ),
                  },
                ),
                "micronutrients": Schema(
                  SchemaType.object,
                  enumValues: [],
                  requiredProperties: ["vitamins", "minerals"],
                  properties: {
                    "vitamins": Schema(
                      SchemaType.object,
                      enumValues: [],
                      requiredProperties: [
                        "vitaminA",
                        "vitaminC",
                        "vitaminD",
                        "vitaminE",
                        "vitaminK",
                        "vitaminB1",
                        "vitaminB2",
                        "vitaminB3",
                        "vitaminB5",
                        "vitaminB6",
                        "vitaminB7",
                        "vitaminB9",
                        "vitaminB12"
                      ],
                      properties: {
                        "vitaminA": Schema(
                          SchemaType.string,
                        ),
                        "vitaminC": Schema(
                          SchemaType.string,
                        ),
                        "vitaminD": Schema(
                          SchemaType.string,
                        ),
                        "vitaminE": Schema(
                          SchemaType.string,
                        ),
                        "vitaminK": Schema(
                          SchemaType.string,
                        ),
                        "vitaminB1": Schema(
                          SchemaType.string,
                        ),
                        "vitaminB2": Schema(
                          SchemaType.string,
                        ),
                        "vitaminB3": Schema(
                          SchemaType.string,
                        ),
                        "vitaminB5": Schema(
                          SchemaType.string,
                        ),
                        "vitaminB6": Schema(
                          SchemaType.string,
                        ),
                        "vitaminB7": Schema(
                          SchemaType.string,
                        ),
                        "vitaminB9": Schema(
                          SchemaType.string,
                        ),
                        "vitaminB12": Schema(
                          SchemaType.string,
                        ),
                      },
                    ),
                    "minerals": Schema(
                      SchemaType.object,
                      enumValues: [],
                      requiredProperties: [
                        "calcium",
                        "iron",
                        "potassium",
                        "magnesium",
                        "zinc",
                        "sodium",
                        "phosphorus",
                        "copper",
                        "manganese",
                        "selenium"
                      ],
                      properties: {
                        "calcium": Schema(
                          SchemaType.string,
                        ),
                        "iron": Schema(
                          SchemaType.string,
                        ),
                        "potassium": Schema(
                          SchemaType.string,
                        ),
                        "magnesium": Schema(
                          SchemaType.string,
                        ),
                        "zinc": Schema(
                          SchemaType.string,
                        ),
                        "sodium": Schema(
                          SchemaType.string,
                        ),
                        "phosphorus": Schema(
                          SchemaType.string,
                        ),
                        "copper": Schema(
                          SchemaType.string,
                        ),
                        "manganese": Schema(
                          SchemaType.string,
                        ),
                        "selenium": Schema(
                          SchemaType.string,
                        ),
                        "iodine": Schema(
                          SchemaType.string,
                        ),
                      },
                    ),
                  },
                ),
                "additionalNutrients": Schema(
                  SchemaType.object,
                  enumValues: [],
                  requiredProperties: [
                    "cholesterol",
                    "waterContent",
                    "caffeine"
                  ],
                  properties: {
                    "cholesterol": Schema(
                      SchemaType.string,
                    ),
                    "waterContent": Schema(
                      SchemaType.string,
                    ),
                    "caffeine": Schema(
                      SchemaType.string,
                    ),
                  },
                ),
                "allergens": Schema(
                  SchemaType.array,
                  items: Schema(
                    SchemaType.string,
                  ),
                ),
                "dietCompatibility": Schema(
                  SchemaType.array,
                  items: Schema(
                    SchemaType.string,
                  ),
                ),
                "warnings": Schema(
                  SchemaType.array,
                  items: Schema(
                    SchemaType.string,
                  ),
                ),
                "healthScore": Schema(
                  SchemaType.integer,
                ),
                "waterquantity": Schema(
                  SchemaType.number,
                ),
                "exercise": Schema(
                  SchemaType.number,
                ),
              },
            ),
          },
        ),
      ),
      systemInstruction: Content.system(prompt),
    );

    print(prefs.getString('selected_button') ?? 'None');
    final promptold =
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

    print(prompt);

    Uint8List imageBytes = await imgFile.readAsBytes();

    final content = [
      Content.multi(
          [TextPart("Generate json"), DataPart('image/jpeg', imageBytes)]),
    ];
    //   final response = await model.generateContent(content);
    // print(response.text);
    //     Map<String, dynamic> jsonMap = jsonDecode(response.text?? '');

    // FoodData foodData = FoodData.fromJson(jsonMap);
    if (!(Premium.instance.apple!.value >= PremiumTheme.scanPrice)) {
      Get.back();
    } else {
      try {
        final response = await model.generateContent(content);
        // Map<String, dynamic> jsonMap = jsonDecode(response.text ?? '');
        // FoodData foodData = FoodData.fromJson(jsonMap);

        // FoodData foodData = await parseFoodData();
        // Close the loading dialog
        print('Respons: ${response.text}');
        // tempprompt.value = response.text!;
        // print(foodData.item.name);

        print('decoding json');
        Map<String, dynamic> jsonMap1 = jsonDecode(response.text ?? '');
        Map<String, dynamic> jsonMap = {
          "item": jsonMap1["item"], // Copy the original "item"
          "alternate1": jsonMap1["item"], // Duplicate the "item" for alternate1
          "description": "" // Add an empty description
        };
        // print(jsonMap['item']);
        print('decoded json');
        FoodData foodData = FoodData.fromJson(jsonMap);
        Get.back();
        Premium.instance.reduce1(PremiumTheme.scanPrice);
        // HomeController().updatehomedata();
        goToREsponse(foodData, imageBytes);
        // HomeController().updatehomedata();
      } catch (e) {
        // Close the loading dialog
        Get.back();
        print('${e.toString()}');
        // Handle the error
        Get.snackbar(
          'Error',
          // 'Failed to get response: $e',
          'There is something Wrong with your image',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  void goToREsponse(FoodData foodData, Uint8List imgFile) {
    print('inside gotoresponse');
    try {
      navFoodData = foodData;
      navImg = imgFile;

      // ResponseScreenController().transfercallFunction(foodData, imgFile);
      Get.toNamed(Routes.RESPONSE_SCREEN, arguments: [foodData, imgFile]);
      // arguments: [response.text ?? '',Image.file(imgFile)]
      // arguments: [foodData, imgFile]);
      // isrespnse.value = true;
      // index.value = 2;
      // NavbarController().resetFunction();
      // print('index become 2');
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

TempDataAddinDataBase() async {
  List<FoodData> foodDataList = [
    FoodData(
      item: FoodItem(
        name: "Apple",
        quantity: "1 medium",
        fat: 0.3,
        carbs: 25.1,
        protein: 0.5,
        waterQuantity: 85.56,
        exercise: 0.0,
        vitamins: {"Vitamin C": "7%", "Vitamin A": "1%"},
        minerals: {"Potassium": "5%", "Calcium": "1%"},
        additionalNutrients: {"Fiber": 4.4},
        allergens: [],
        dietCompatibility: ["Vegan", "Gluten-Free"],
        warnings: [],
        healthScore: 80,
      ),
      alternate1: FoodItem(
        name: "Banana",
        quantity: "1 medium",
        fat: 0.3,
        carbs: 27.0,
        protein: 1.3,
        waterQuantity: 74.91,
        exercise: 0.0,
        vitamins: {"Vitamin C": "15%", "Vitamin B6": "20%"},
        minerals: {"Potassium": "12%", "Magnesium": "8%"},
        additionalNutrients: {"Fiber": 3.1},
        allergens: [],
        dietCompatibility: ["Vegan", "Gluten-Free"],
        warnings: [],
        healthScore: 82,
      ),
      description: "A delicious and healthy fruit.",
    ),
    FoodData(
      item: FoodItem(
        name: "Chicken Breast",
        quantity: "100g",
        fat: 3.6,
        carbs: 0.0,
        protein: 31.0,
        waterQuantity: 65.0,
        exercise: 0.0,
        vitamins: {"Vitamin B6": "20%", "Niacin": "75%"},
        minerals: {"Phosphorus": "22%", "Selenium": "40%"},
        additionalNutrients: {},
        allergens: [],
        dietCompatibility: ["Paleo", "Keto"],
        warnings: [],
        healthScore: 85,
      ),
      alternate1: FoodItem(
        name: "Turkey Breast",
        quantity: "100g",
        fat: 1.0,
        carbs: 0.0,
        protein: 29.0,
        waterQuantity: 70.0,
        exercise: 0.0,
        vitamins: {"Vitamin B6": "20%", "Niacin": "60%"},
        minerals: {"Phosphorus": "25%", "Selenium": "40%"},
        additionalNutrients: {},
        allergens: [],
        dietCompatibility: ["Paleo", "Keto"],
        warnings: [],
        healthScore: 84,
      ),
      description: "Lean protein source.",
    ),
    FoodData(
      item: FoodItem(
        name: "Brown Rice",
        quantity: "100g",
        fat: 1.0,
        carbs: 23.0,
        protein: 2.6,
        waterQuantity: 11.0,
        exercise: 0.0,
        vitamins: {"Vitamin B1": "12%", "Magnesium": "25%"},
        minerals: {"Iron": "2%", "Manganese": "45%"},
        additionalNutrients: {"Fiber": 1.8},
        allergens: [],
        dietCompatibility: ["Vegan", "Gluten-Free"],
        warnings: [],
        healthScore: 75,
      ),
      alternate1: FoodItem(
        name: "Quinoa",
        quantity: "100g",
        fat: 2.0,
        carbs: 21.0,
        protein: 4.1,
        waterQuantity: 13.0,
        exercise: 0.0,
        vitamins: {"Vitamin B2": "10%", "Vitamin E": "6%"},
        minerals: {"Magnesium": "30%", "Phosphorus": "28%"},
        additionalNutrients: {"Fiber": 2.0},
        allergens: [],
        dietCompatibility: ["Vegan", "Gluten-Free"],
        warnings: [],
        healthScore: 78,
      ),
      description: "A whole grain option.",
    ),
    FoodData(
      item: FoodItem(
        name: "Almonds",
        quantity: "100g",
        fat: 50.0,
        carbs: 22.0,
        protein: 21.0,
        waterQuantity: 4.0,
        exercise: 0.0,
        vitamins: {"Vitamin E": "25%", "Riboflavin": "17%"},
        minerals: {"Magnesium": "66%", "Calcium": "26%"},
        additionalNutrients: {},
        allergens: ["Nuts"],
        dietCompatibility: ["Vegan", "Paleo"],
        warnings: [],
        healthScore: 90,
      ),
      alternate1: FoodItem(
        name: "Cashews",
        quantity: "100g",
        fat: 44.0,
        carbs: 30.0,
        protein: 18.0,
        waterQuantity: 5.0,
        exercise: 0.0,
        vitamins: {"Vitamin K": "34%", "Vitamin B6": "20%"},
        minerals: {"Magnesium": "73%", "Copper": "67%"},
        additionalNutrients: {},
        allergens: ["Nuts"],
        dietCompatibility: ["Vegan", "Paleo"],
        warnings: [],
        healthScore: 88,
      ),
      description: "Rich in healthy fats.",
    ),
    FoodData(
      item: FoodItem(
        name: "Spinach",
        quantity: "100g",
        fat: 0.4,
        carbs: 3.6,
        protein: 2.9,
        waterQuantity: 91.4,
        exercise: 0.0,
        vitamins: {"Vitamin A": "188%", "Vitamin K": "498%"},
        minerals: {"Iron": "15%", "Calcium": "10%"},
        additionalNutrients: {},
        allergens: [],
        dietCompatibility: ["Vegan", "Gluten-Free"],
        warnings: [],
        healthScore: 85,
      ),
      alternate1: FoodItem(
        name: "Kale",
        quantity: "100g",
        fat: 1.5,
        carbs: 9.0,
        protein: 4.3,
        waterQuantity: 84.0,
        exercise: 0.0,
        vitamins: {"Vitamin A": "200%", "Vitamin K": "1030%"},
        minerals: {"Iron": "14%", "Calcium": "15%"},
        additionalNutrients: {},
        allergens: [],
        dietCompatibility: ["Vegan", "Gluten-Free"],
        warnings: [],
        healthScore: 88,
      ),
      description: "Leafy green vegetable.",
    ),
    FoodData(
      item: FoodItem(
        name: "Salmon",
        quantity: "100g",
        fat: 13.0,
        carbs: 0.0,
        protein: 20.0,
        waterQuantity: 64.0,
        exercise: 0.0,
        vitamins: {"Vitamin D": "75%", "Vitamin B12": "150%"},
        minerals: {"Selenium": "58%", "Phosphorus": "20%"},
        additionalNutrients: {},
        allergens: ["Fish"],
        dietCompatibility: ["Paleo", "Keto"],
        warnings: [],
        healthScore: 92,
      ),
      alternate1: FoodItem(
        name: "Tuna",
        quantity: "100g",
        fat: 1.0,
        carbs: 0.0,
        protein: 30.0,
        waterQuantity: 70.0,
        exercise: 0.0,
        vitamins: {"Vitamin D": "30%", "Vitamin B12": "100%"},
        minerals: {"Selenium": "65%", "Phosphorus": "20%"},
        additionalNutrients: {},
        allergens: ["Fish"],
        dietCompatibility: ["Paleo", "Keto"],
        warnings: [],
        healthScore: 90,
      ),
      description: "Rich in omega-3 fatty acids.",
    ),
    FoodData(
      item: FoodItem(
        name: "Broccoli",
        quantity: "100g",
        fat: 0.4,
        carbs: 6.6,
        protein: 2.8,
        waterQuantity: 89.3,
        exercise: 0.0,
        vitamins: {"Vitamin C": "135%", "Vitamin K": "101%"},
        minerals: {"Iron": "4%", "Calcium": "4%"},
        additionalNutrients: {},
        allergens: [],
        dietCompatibility: ["Vegan", "Gluten-Free"],
        warnings: [],
        healthScore: 88,
      ),
      alternate1: FoodItem(
        name: "Cauliflower",
        quantity: "100g",
        fat: 0.3,
        carbs: 4.9,
        protein: 1.9,
        waterQuantity: 92.1,
        exercise: 0.0,
        vitamins: {"Vitamin C": "48%", "Vitamin K": "15%"},
        minerals: {"Iron": "3%", "Calcium": "2%"},
        additionalNutrients: {},
        allergens: [],
        dietCompatibility: ["Vegan", "Gluten-Free"],
        warnings: [],
        healthScore: 88,
      ),
      description: "Rich in omega-3 fatty acids.",
    ),
    FoodData(
      item: FoodItem(
        name: "Greek Yogurt",
        quantity: "1 cup",
        fat: 4.0,
        carbs: 10.0,
        protein: 10.0,
        waterQuantity: 85.0,
        exercise: 0.0,
        vitamins: {"Vitamin B12": "18%", "Calcium": "22%"},
        minerals: {"Phosphorus": "15%", "Potassium": "6%"},
        additionalNutrients: {"Probiotics": 5.0},
        allergens: ["Dairy"],
        dietCompatibility: ["Keto"],
        warnings: ["Lactose intolerance"],
        healthScore: 78,
      ),
      alternate1: FoodItem(
        name: "Cottage Cheese",
        quantity: "1 cup",
        fat: 2.3,
        carbs: 6.1,
        protein: 12.0,
        waterQuantity: 81.0,
        exercise: 0.0,
        vitamins: {"Vitamin B12": "10%", "Calcium": "11%"},
        minerals: {"Phosphorus": "8%", "Sodium": "15%"},
        additionalNutrients: {"Probiotics": 3.0},
        allergens: ["Dairy"],
        dietCompatibility: ["Keto"],
        warnings: ["Lactose intolerance"],
        healthScore: 75,
      ),
      description: "High-protein dairy products.",
    ),
    FoodData(
      item: FoodItem(
        name: "Sweet Potato",
        quantity: "1 medium",
        fat: 0.1,
        carbs: 26.0,
        protein: 2.0,
        waterQuantity: 77.3,
        exercise: 0.0,
        vitamins: {"Vitamin A": "284%", "Vitamin C": "35%"},
        minerals: {"Potassium": "15%", "Calcium": "4%"},
        additionalNutrients: {"Fiber": 4.0},
        allergens: [],
        dietCompatibility: ["Vegan", "Gluten-Free"],
        warnings: [],
        healthScore: 80,
      ),
      alternate1: FoodItem(
        name: "Butternut Squash",
        quantity: "1 cup",
        fat: 0.2,
        carbs: 16.0,
        protein: 1.4,
        waterQuantity: 86.4,
        exercise: 0.0,
        vitamins: {"Vitamin A": "457%", "Vitamin C": "39%"},
        minerals: {"Potassium": "12%", "Magnesium": "6%"},
        additionalNutrients: {"Fiber": 2.8},
        allergens: [],
        dietCompatibility: ["Vegan", "Gluten-Free"],
        warnings: [],
        healthScore: 78,
      ),
      description: "Rich in vitamins and fiber.",
    ),
    FoodData(
      item: FoodItem(
        name: "Avocado",
        quantity: "1 medium",
        fat: 15.0,
        carbs: 9.0,
        protein: 2.0,
        waterQuantity: 73.2,
        exercise: 0.0,
        vitamins: {"Vitamin K": "26%", "Folate": "20%"},
        minerals: {"Potassium": "14%", "Magnesium": "7%"},
        additionalNutrients: {"Fiber": 7.0},
        allergens: [],
        dietCompatibility: ["Vegan", "Keto"],
        warnings: [],
        healthScore: 90,
      ),
      alternate1: FoodItem(
        name: "Olives",
        quantity: "10 large",
        fat: 5.0,
        carbs: 3.0,
        protein: 0.5,
        waterQuantity: 60.0,
        exercise: 0.0,
        vitamins: {"Vitamin E": "7%", "Iron": "3%"},
        minerals: {"Sodium": "15%", "Calcium": "2%"},
        additionalNutrients: {"Fiber": 1.5},
        allergens: [],
        dietCompatibility: ["Vegan", "Mediterranean Diet"],
        warnings: [],
        healthScore: 85,
      ),
      description: "Healthy source of fats.",
    ),
    FoodData(
      item: FoodItem(
        name: "Dark Chocolate",
        quantity: "30g",
        fat: 12.0,
        carbs: 14.0,
        protein: 2.0,
        waterQuantity: 0.5,
        exercise: 0.0,
        vitamins: {"Vitamin A": "2%", "Iron": "19%"},
        minerals: {"Magnesium": "15%", "Copper": "34%"},
        additionalNutrients: {"Caffeine": 20.0},
        allergens: ["Cocoa"],
        dietCompatibility: ["Vegetarian"],
        warnings: ["May contain traces of nuts"],
        healthScore: 70,
      ),
      alternate1: FoodItem(
        name: "Milk Chocolate",
        quantity: "30g",
        fat: 9.0,
        carbs: 19.0,
        protein: 1.5,
        waterQuantity: 1.0,
        exercise: 0.0,
        vitamins: {"Vitamin D": "2%", "Calcium": "8%"},
        minerals: {"Iron": "5%", "Magnesium": "4%"},
        additionalNutrients: {"Caffeine": 12.0},
        allergens: ["Dairy", "Cocoa"],
        dietCompatibility: ["Vegetarian"],
        warnings: ["Contains dairy"],
        healthScore: 65,
      ),
      description: "A treat high in antioxidants.",
    ),
    FoodData(
      item: FoodItem(
        name: "Tofu",
        quantity: "100g",
        fat: 4.8,
        carbs: 2.0,
        protein: 8.0,
        waterQuantity: 83.0,
        exercise: 0.0,
        vitamins: {"Vitamin B1": "6%", "Calcium": "15%"},
        minerals: {"Iron": "30%", "Magnesium": "10%"},
        additionalNutrients: {"Isoflavones": 20.0},
        allergens: ["Soy"],
        dietCompatibility: ["Vegan"],
        warnings: ["Phytoestrogens may affect hormone balance"],
        healthScore: 85,
      ),
      alternate1: FoodItem(
        name: "Tempeh",
        quantity: "100g",
        fat: 8.0,
        carbs: 9.0,
        protein: 15.0,
        waterQuantity: 70.0,
        exercise: 0.0,
        vitamins: {"Vitamin B2": "14%", "Niacin": "12%"},
        minerals: {"Iron": "21%", "Phosphorus": "15%"},
        additionalNutrients: {"Probiotics": 10.0},
        allergens: ["Soy"],
        dietCompatibility: ["Vegan"],
        warnings: [],
        healthScore: 88,
      ),
      description: "Plant-based protein alternatives.",
    ),
    FoodData(
      item: FoodItem(
        name: "Oatmeal",
        quantity: "1 cup",
        fat: 3.5,
        carbs: 27.0,
        protein: 5.0,
        waterQuantity: 84.0,
        exercise: 0.0,
        vitamins: {"Vitamin B1": "14%", "Iron": "10%"},
        minerals: {"Magnesium": "13%", "Zinc": "6%"},
        additionalNutrients: {"Beta-glucan": 4.0},
        allergens: ["Gluten"],
        dietCompatibility: ["Vegetarian"],
        warnings: [],
        healthScore: 78,
      ),
      alternate1: FoodItem(
        name: "Chia Seeds",
        quantity: "30g",
        fat: 8.6,
        carbs: 12.0,
        protein: 4.4,
        waterQuantity: 5.0,
        exercise: 0.0,
        vitamins: {"Vitamin B1": "7%", "Calcium": "18%"},
        minerals: {"Magnesium": "24%", "Phosphorus": "19%"},
        additionalNutrients: {"Omega-3": 5.0},
        allergens: [],
        dietCompatibility: ["Vegan", "Gluten-Free"],
        warnings: [],
        healthScore: 87,
      ),
      description: "Great source of fiber and energy.",
    ),
    FoodData(
      item: FoodItem(
        name: "Egg",
        quantity: "1 large",
        fat: 5.0,
        carbs: 0.6,
        protein: 6.0,
        waterQuantity: 76.0,
        exercise: 0.0,
        vitamins: {"Vitamin D": "10%", "Vitamin B12": "9%"},
        minerals: {"Iron": "3%", "Calcium": "2%"},
        additionalNutrients: {"Choline": 113.0},
        allergens: ["Egg"],
        dietCompatibility: ["Keto", "Paleo"],
        warnings: [],
        healthScore: 82,
      ),
      alternate1: FoodItem(
        name: "Egg White",
        quantity: "1 large",
        fat: 0.0,
        carbs: 0.2,
        protein: 4.0,
        waterQuantity: 88.0,
        exercise: 0.0,
        vitamins: {"Vitamin B2": "7%", "Vitamin B5": "3%"},
        minerals: {"Sodium": "4%", "Potassium": "1%"},
        additionalNutrients: {},
        allergens: ["Egg"],
        dietCompatibility: ["Keto", "Paleo"],
        warnings: [],
        healthScore: 79,
      ),
      description: "A versatile source of protein.",
    ),
  ];
  var dbh = DatabaseHelper();
  await dbh.insertFakeFoodData(foodDataList[0], '10/10/2024');
  await dbh.insertFakeFoodData(foodDataList[1], '10/10/2024');
  await dbh.insertFakeFoodData(foodDataList[2], '11/10/2024');
  await dbh.insertFakeFoodData(foodDataList[3], '11/10/2024');
  await dbh.insertFakeFoodData(foodDataList[4], '11/10/2024');
  await dbh.insertFakeFoodData(foodDataList[5], '11/10/2024');
  await dbh.insertFakeFoodData(foodDataList[6], '12/10/2024');
  await dbh.insertFakeFoodData(foodDataList[7], '12/10/2024');
  await dbh.insertFakeFoodData(foodDataList[8], '13/10/2024');
  await dbh.insertFakeFoodData(foodDataList[9], '14/10/2024');
  await dbh.insertFakeFoodData(foodDataList[10], '14/10/2024');
  await dbh.insertFakeFoodData(foodDataList[11], '14/10/2024');
  await dbh.insertFakeFoodData(foodDataList[12], '15/10/2024');
  await dbh.insertFakeFoodData(foodDataList[13], '16/10/2024');
  HistoryShowController().getdata();
}

Deletedatabases() async {
  await DatabaseHelper().deleteDatabaseFile();
  await DatabaseHelper2().deleteDatabaseFile();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
