import 'package:calories_detector/app/modules/liquidloading/views/liquidloading_view.dart';
import 'package:calories_detector/app/modules/navbar/controllers/navbar_controller.dart';
import 'package:calories_detector/app/modules/utills/Themes/current_theme.dart';
import 'package:calories_detector/app/modules/utills/remoteConfigVariables.dart';
import 'package:calories_detector/sizeConfig.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../data/food_item.dart';
import '../../../data/Data_Base.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import '../../../routes/app_pages.dart';

final ImagePicker _picker = ImagePicker();

// Color onSecondaryColor = const Color(0xffFFffff);
// Color secondaryColor = Color(0xffFF4D6D);
// Color primaryColor = Color(0xffFFD1DC);
// Color onPrimaryColor = Color(0xff1E3A5F);
Rxn<FoodData> foodData = Rxn<FoodData>();
Rxn<Image> imageFile = Rxn<Image>();
RxBool isrespnse = false.obs;
Uint8List? imageFile2;

Rxn<FoodItem> compairFood2 = Rxn<FoodItem>();
RxBool checkFirst = true.obs;
Rxn<FoodItem> compairFood1 = Rxn<FoodItem>();

class ResponseScreenController extends GetxController {
  // void Comparefunction(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Compare this item'),
  //         content: Text('Choose another item from'),
  //         actions: <Widget>[
  //           Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //                 pickImageFromGallery(); // Close the dialog
  //                 // Handle button 1 action here
  //               },
  //               child: Text('Gallery'),
  //             ),
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //                 pickImageFromCamera(); // Close the dialog
  //                 // Handle button 2 action here
  //               },
  //               child: Text('Camera'),
  //             ),
  //           ])
  //         ],
  //       );
  //     },
  //   );
  // }
  void Comparefunction(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Rounded corners
          ),
          child: Container(
            decoration: BoxDecoration(
              // gradient: LinearGradient(
              //   colors: [Colors.lightBlueAccent, Colors.blueAccent],
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              // ),
              gradient: AppThemeColors.buttonColor,
              borderRadius: BorderRadius.circular(15), // Keep gradient rounded
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Compare Your Item',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Make title stand out on gradient
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Would you like to select an item from your gallery or take a new picture?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      // color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop();
                          pickImageFromGallery(); // Close dialog and open gallery
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              // Colors.green, // Gallery button background
                              Colors.white,
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon:
                            Icon(Icons.photo, color: AppThemeColors.onPrimary1),
                        label: Text('Gallery',
                            style: TextStyle(color: Colors.black)),
                      ),
                      SizedBox(),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop();
                          // pickImageFromCamera();
                          // Get.toNamed(Routes.CAMERA_SCREEN);
                          pickImageFromCamera();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.white, // Camera button background
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: Icon(Icons.camera_alt,
                            color: AppThemeColors.onPrimary1),
                        label: Text('Camera',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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
      Get.snackbar('Permission denied',
          "Unable to Scan from camera. now finding image from gallery",
          snackPosition: SnackPosition.BOTTOM);
      print('after snackbar');
      await Future.delayed(Duration(seconds: 2));
      pickImageFromGallery();
      print('Failed to pick image: $e');
    }
  }

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
      apiKey: RCVariables.GemeniAPIKey.value,
    );
    String goal = 'gain Weight';
    final prefs = await SharedPreferences.getInstance();

    // final prompt ='Give me json response according to map given in instructions';
    final prompt =
        'you are an expert dietician. You will be given an image of some food item/items.tell the name/names of the food/foods given in image,and quantity of it/them quantity can be any thing like no. of slice,no.of items, mass in kg no. of scoops, no. of litres or anything else suitable for that food. Analyze the nutritional content and tell how much water(in liters) should be drank after consuming these and how much exercise should be done(in hours)..Dietary Labels:Vegan,Vegetarian,Paleo,Keto,Gluten-Free,Dairy-Free,Low-Fat,Low-Carb,High-Fiber,Allergens:Gluten,Dairy,Eggs,Nuts,Soy,Shellfish,Warnings/Alerts:High in Sugar,High in Sodium,High in Saturated Fat,Contains Additives (e.g., preservatives, colorants) or you can tell none if there is not any in health score give it rating from five stars .in description string compare this food with ${compairFood1.value!.name} which have ${compairFood1.value!.totalCalories}. tell which food is best if my goal is to ${prefs.getString('selected_button') ?? 'None'} provide a response in JSON format with the following structure:\n'
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
  "description": "<string>"\n
}

'''
        'dont give me any text or disclaimer or note your response should start from { bracket of json structure and end with } json bracket';
    Uint8List imageBytes = await imgFile.readAsBytes();
    print(prompt);
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
      // print(foodData.item.name);
      Map<String, dynamic> jsonMap = jsonDecode(response.text ?? '');
      print('mapdone');
      CommpareItem compitem = CommpareItem.fromJson(jsonMap);
      print('Comparing class start');
      // String description = jsonMap['description'] ?? '';
      String description = compitem.description;
      print('this is description: $description');
      FoodItem fooditem2 = compitem.item;
      //  FoodItem fooditem2 = FoodItem.fromJson(temp);
      print('foditemdone : $Error');

      print('Converted to FoodItem');
      compairFood2.value = fooditem2;
      compairFood1.value = navFoodData!.item;

      Get.back();
      print('closeed dialoge');
      goToCompare(compairFood1.value!, compairFood2.value!, description);
      print('gone');
      // goToREsponse(foodData, imgFile);
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

  void goToCompare(FoodItem fooditem1, FoodItem fooditem2, String description) {
    print(description);
    try {
      Get.toNamed(Routes.COMPARISON_VIEW_SCREEN,
          // arguments: [response.text ?? '',Image.file(imgFile)]
          arguments: [fooditem1, fooditem2, 'Comparison', description]);
    } catch (e) {
      Get.snackbar(
        'Error',
        // 'Failed to get response:\nThere is something Wrong with your image',
        'There is something Wrong with your image',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void logFeed(FoodData foodData) async {
    final dbHelper = DatabaseHelper();
    print(checkFirst.value);
    if (checkFirst.value) {
      // dbHelper.deleteDatabaseFile();
      // if (0 == 0) {
      try {
        await dbHelper.insertFoodData(foodData);
        // Insert FoodData into the database
        // checkFirst.value == false;
        checkFirst.toggle();

        print('value of check ${checkFirst.value}');
        print('Food data logged successfully.');
        Get.snackbar(
          "Saved",
          // 'Failed to get response:\nThere is something Wrong with your image',
          '',
          snackPosition: SnackPosition.BOTTOM,
        );
      } catch (e) {
        print('Error logging food data: $e');
        Get.snackbar(
          "Try again",
          // 'Failed to get response:\nThere is something Wrong with your image',
          'Something Went wrong',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      Get.snackbar(
        "Saved",
        // 'Failed to get response:\nThere is something Wrong with your image',
        '',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void transfercallFunction(FoodData response, Uint8List img) {
    print(checkFirst.value);
    if (!checkFirst.value) {
      checkFirst.toggle();
      print('checkFirstChanged');
    }
    foodData.value = response;
    print('response in');
    compairFood1.value = response.item;
    print('response item in');

    imageFile2 = img;
    print('img in');
  }

  @override
  void onInit() {
    checkFirst.value = true;
    foodData.value = navFoodData;
    print('response in');
    compairFood1.value = navFoodData!.item;
    print('response item in');

    imageFile2 = navImg;
    print('img in');
    super.onInit();
  }

  final count = 0.obs;

  void increment() => count.value++;
}

class FoodDetailsDialog extends StatelessWidget {
  final FoodData foodData;

  const FoodDetailsDialog({super.key, required this.foodData});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'More Details',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      // title: Text('Food Details: ${foodData.item.name}'),
      content: SizedBox(
        width: SizeConfig.screenWidth * 0.8,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display main food item details
              _buildSectionTitle("Main Item"),

              _buildDetailRow('Name', foodData.item.name),
              _buildDetailRow('Quantity', foodData.item.quantity),
              _buildDetailRow('Fat', '${foodData.item.fat.toInt()}g'),
              _buildDetailRow('Carbs', '${foodData.item.carbs.toInt()}g'),
              _buildDetailRow('Protein', '${foodData.item.protein.toInt()}g'),
              // _buildDetailRow(
              //     'Water Quantity', '${foodData.item.waterQuantity}L'),
              // _buildDetailRow('Exercise Time', '${foodData.item.exercise} hrs'),
              _buildDetailRow('Health Score', '${foodData.item.healthScore}/5'),
              Divider(),

              // Display vitamins
              _buildSectionTitle("Vitamins (% DV)"),
              ..._buildNutrientList(foodData.item.vitamins),
              Divider(),

              // Display minerals
              _buildSectionTitle("Minerals (% DV)"),
              ..._buildNutrientList(foodData.item.minerals),
              Divider(),

              // Display additional nutrients
              _buildSectionTitle("Additional Nutrients"),
              ..._buildAdditionalNutrientList(
                  foodData.item.additionalNutrients),
              Divider(),

              // Display allergens
              _buildSectionTitle("Allergens"),
              _buildList(foodData.item.allergens),
              Divider(),

              // Display diet compatibility
              _buildSectionTitle("Diet Compatibility"),
              _buildList(foodData.item.dietCompatibility),
              Divider(),

              // Display warnings
              _buildSectionTitle("Warnings"),
              _buildList(foodData.item.warnings),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text('Close'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$label:', style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(width: 10),
          Expanded(child: Text(value, textAlign: TextAlign.end)),
        ],
      ),
    );
  }

  List<Widget> _buildNutrientList(Map<String, String> nutrients) {
    return nutrients.entries.map((entry) {
      return _buildDetailRow(entry.key, entry.value);
    }).toList();
  }

  List<Widget> _buildAdditionalNutrientList(Map<String, double> nutrients) {
    return nutrients.entries.map((entry) {
      return _buildDetailRow(entry.key, '${entry.value.toInt()} mg');
    }).toList();
  }

  Widget _buildList(List<String> items) {
    if (items.isEmpty) {
      return Text('None');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) => Text('- $item')).toList(),
    );
  }
}
