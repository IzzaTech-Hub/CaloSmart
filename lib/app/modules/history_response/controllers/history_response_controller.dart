import 'package:calories_detector/app/modules/utills/Themes/current_theme.dart';
import 'package:calories_detector/sizeConfig.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
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

class HistoryResponseController extends GetxController {
  // Rxn<Image> imageFile = Rxn<Image>();
  Rxn<FoodData> foodData = Rxn<FoodData>();
  Rxn<FoodItem> compairFood1 = Rxn<FoodItem>();
  Rxn<FoodItem> compairFood2 = Rxn<FoodItem>();
  RxBool checkFirst = true.obs;
  void Comparefunction(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Compare this item'),
          content: Text('Choose another item from'),
          actions: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  pickImageFromGallery(); // Close the dialog
                  // Handle button 1 action here
                },
                child: Text('Gallery'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  pickImageFromCamera(); // Close the dialog
                  // Handle button 2 action here
                },
                child: Text('Camera'),
              ),
            ])
          ],
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
      Expanded(
          child: Container(
              color: AppThemeColors.secondery1.withOpacity(0.6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Analyzing your image',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.1,
                  ),
                  CircularProgressIndicator(
                    strokeWidth: 5,
                    // value: 100,
                    color: AppThemeColors.onPrimary1,
                  )
                ],
              ))), // Loading screen
      barrierDismissible:
          false, // Prevents dismissing the dialog by tapping outside
    );

    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: 'AIzaSyD4cCpD7lP-Q9raPF59L8npR8H5NF3pLIo',
    );
    String goal = 'gain Weight';
    // final prompt ='Give me json response according to map given in instructions';
    final prompt =
        'you are an expert dietician. You will be given an image of some food item/items.tell the name/names of the food/foods given in image,and quantity of it/them quantity can be any thing like no. of slice,no.of items, mass in kg no. of scoops, no. of litres or anything else suitable for that food. Analyze the nutritional content and tell how much water(in liters) should be drank after consuming these and how much exercise should be done(in hours).in description string compare this food with ${compairFood1.value!.name} which have ${compairFood1.value!.totalCalories}. tell which food is best if my goal is to $goal. provide a response in JSON format with the following structure:\n'
        '''
{
  "name": "<string>",\n
  "quantity": "<string>",\n
  "fat": <int>,\n
  "carbs": <int>,\n
  "protein": <int>,\n
  "waterquantity": <float>,\n
  "exercise": <float>\n
  "description":<string>\n
}
'''
        'dont give me any text or disclaimer or note your response should start from { bracket of json structure and end with } json bracket';
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
      // print(foodData.item.name);
      Map<String, dynamic> jsonMap = jsonDecode(response.text ?? '');
      FoodItem fooditem2 = FoodItem.fromJson(jsonMap);
      String description = jsonMap['description'] ?? '';
      print('this is description: $description');
      print('Converted to FoodItem');
      compairFood2.value = fooditem2;
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
    final dbHelper = DatabaseHelper(); // Create an instance of DatabaseHelper
    if (checkFirst.value) // dbHelper.deleteDatabaseFile();
    {
      try {
        await dbHelper.insertFoodData(foodData);
        // Insert FoodData into the database
        // checkFirst.value == false;
        checkFirst.toggle();

        print('value of check ${checkFirst.value}');
        print('Food data logged successfully.');
      } catch (e) {
        print('Error logging food data: $e');
      }
    } else {
      Get.snackbar(
        "Unable to log",
        // 'Failed to get response:\nThere is something Wrong with your image',
        'Already Saved',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onInit() {
    checkFirst.value = true;
    print('check first become true');
    final arguments = Get.arguments;
    final FoodData response = arguments[0];
    // imageFile.value = arguments[1];
    print("Argument $response");
    foodData.value = response;
    compairFood1.value = response.item;
    // Map<String, dynamic> jsonMap = jsonDecode(response);
    // foodData.value = FoodData.fromJson(jsonMap);

    super.onInit();
  }


  final count = 0.obs;

  void increment() => count.value++;
}
