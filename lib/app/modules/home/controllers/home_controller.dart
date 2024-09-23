import 'package:calories_detector/app/modules/utills/Themes/current_theme.dart';
import 'package:calories_detector/app/notificationservice/local_notification_service.dart';
import 'package:calories_detector/main.dart';
import 'package:calories_detector/sizeConfig.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
// import 'dart:convert';
import '../../../routes/app_pages.dart';

import 'dart:convert';
import '../../../data/food_item.dart';

final ImagePicker _picker = ImagePicker();

class HomeController extends GetxController {
  //TODO: Implement HomeController
  @override
  void onInit() {
    // TODO: implement onInit
    handlePushNotification();
    super.onInit();
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
                      color: Colors.black,
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

    // final prompt ='Give me json response according to map given in instructions';
    RxString goal = 'gain weight'.obs;
    final prompt =
        'you are an expert dietician. You will be given an image of some food item/items.tell the name/names of the food/foods given in image,and quantity of it/them quantity can be any thing like no. of slice,no.of items with name, mass in kg no. of scoops, no. of litres or anything else suitable for that food. then tell 1 best and healthy alternates for it to consume instead of them if i want to ${goal.value}. Analyze the nutritional content and tell how much water(in liters) should be drank after consuming these and how much exercise should be done(in hours).At last give a short description about why should i consume the alternate how it is better than original. provide a response in JSON format with the following structure:\n'
        '''
{
  "item": {
    "name": "<string>",\n
    "quantity": "<string>",\n
    "fat": <int>,\n
    "carbs": <int>,\n
    "protein": <int>,\n
    "waterquantity": <float>,\n
    "exercise": <float>\n
  },\n
  "alternate1": {
    "name": "<string>",\n
    "quantity": "<string>",\n
    "fat": <int>,\n
    "carbs": <int>,\n
    "protein": <int>,\n
    "waterquantity": <float>,\n
    "exercise": <float>\n
  },\n
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
      Get.back();
      Map<String, dynamic> jsonMap = jsonDecode(response.text ?? '');
      FoodData foodData = FoodData.fromJson(jsonMap);

      goToREsponse(foodData, imgFile);
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

  void goToREsponse(FoodData foodData, File imgFile) {
    try {
      Get.toNamed(Routes.RESPONSE_SCREEN,
          // arguments: [response.text ?? '',Image.file(imgFile)]
          arguments: [foodData, Image.file(imgFile)]);
    } catch (e) {
      Get.snackbar(
        'Error',
        // 'Failed to get response:\nThere is something Wrong with your image',
        'There is something Wrong with your image',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  final count = 0.obs;

  void increment() => count.value++;

  handlePushNotification() async {
    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }
}
