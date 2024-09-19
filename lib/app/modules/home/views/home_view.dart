// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, avoid_print

// import 'dart:io';
// import 'package:calories_detector/app/modules/ResponseScreen/views/response_screen_view.dart';
import 'package:calories_detector/app/data/Data_Base.dart';
import 'package:calories_detector/app/modules/home/controllers/history_show_controller.dart';
import 'package:calories_detector/app/modules/home/views/history_show.dart';
import 'package:calories_detector/app/routes/app_pages.dart';
import 'package:calories_detector/sizeConfig.dart';
import 'package:flutter/material.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'dart:convert';
import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
import '../controllers/home_controller.dart';
// import '../../../routes/app_pages.dart';

Size size = Size(
    SizeConfig.blockSizeHorizontal * 90, SizeConfig.blockSizeHorizontal * 50);

Color onSecondaryColor = const Color(0xffFFffff);
Color secondaryColor = Color(0xffFF4D6D);
Color primaryColor = Color(0xffFFD1DC);
Color onPrimaryColor = Color(0xff1E3A5F);
Color tertoryColor = Color(0xffE3D7FF);

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  // NutritionInfo? proteinInfo;
  // NutritionInfo? fatInfo;
  // NutritionInfo? carbsInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        child: Column(
          children: [
            Logo_Text(),
            Text(
              "Analyze your image now",
              style: TextStyle(
                  fontSize: size.height * 0.15, color: onPrimaryColor),
            ),
            SizedBox(height: size.height * 0.15),
            Container(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.1),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          controller.pickImageFromGallery();
                        },
                        child:
                            Icon_Method("Choose from", "Gallery", Icons.image),
                      ),
                      InkWell(
                        onTap: () {
                          controller.pickImageFromCamera();
                        },
                        child: Icon_Method(
                            "Capture from", "Camera", Icons.camera_alt_rounded),
                      )
                    ],
                  ),
                  verticalSpace(size.height * 0.1),
                  InkWell(
                    onTap: () {
                      // DatabaseHelper().deleteDatabaseFile();
                      Get.toNamed(Routes.HISTORY_VIEW_SCREEN);
                    },
                    child: Container(
                      height: size.height * 0.35,
                      width: size.width * 0.97,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(size.height * 0.1),
                          color: secondaryColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.history,
                            size: size.height * 0.28,
                            color: onSecondaryColor,
                          ),
                          Text(
                            "Previous Logs",
                            style: TextStyle(
                                color: onSecondaryColor,
                                fontSize: size.height * 0.16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),

                  verticalSpace(size.height * 0.1),
                  // Container(
                  //   height: size.height * 1,
                  //   width: size.width * 1,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(size.height * 0.15),
                  //       color: Colors.deepOrange),
                  //   child: Column(
                  //     children: [
                  //       if (proteinInfo != null)
                  //         Text(
                  //           'Protein: ${proteinInfo!.grams} grams (${proteinInfo!.calories} calories)',
                  //           style: TextStyle(color: Colors.white),
                  //         ),
                  //       SizedBox(height: 10),
                  //       if (fatInfo != null)
                  //         Text(
                  //           'Fat: ${fatInfo!.grams} grams (${fatInfo!.calories} calories)',
                  //           style: TextStyle(color: Colors.white),
                  //         ),
                  //       SizedBox(height: 10),
                  //       if (carbsInfo != null)
                  //         Text(
                  //           'Carbs: ${carbsInfo!.grams} grams (${carbsInfo!.calories} calories)',
                  //           style: TextStyle(color: Colors.white),
                  //         ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container Icon_Method(String smallTexted, String largeTexted, IconData icon) {
    return Container(
      height: size.height * 0.9,
      width: size.width * 0.45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.height * 0.12),
          color: secondaryColor),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              size: size.height * 0.4,
              color: onSecondaryColor,
            ),
            Text(
              smallTexted,
              style:
                  TextStyle(fontSize: size.height * 0.08, color: tertoryColor),
            ),
            Text(
              largeTexted,
              style: TextStyle(
                  fontSize: size.height * 0.16,
                  color: onSecondaryColor,
                  fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }

  // Function to capture image from camera
}

//   void sendImageToGoogleAI(File imageFile) async {
//     final apiKey =
//         'AIzaSyBNwVLoxY4jj1IZOZbUjqrO10SEL3db060'; // Ensure you provide your actual API key

//     final model = GenerativeModel(
//       // model: 'gemini-1.5-flash',
//       model: 'gemini-1.5-pro',
//       apiKey: apiKey,
//       generationConfig: GenerationConfig(
//         temperature: 1,
//         topK: 64,
//         topP: 0.95,
//         maxOutputTokens: 8192,
//         responseMimeType: 'text/plain',
//       ),
//       systemInstruction: Content.system(
//           'you are an expert dietician. You will be given an image of some food item/items. Analyze the nutritional content and provide a response in JSON format with the following structure:\n'
//           '{\n'
//           '  "protein": {\n'
//           '    "grams": <int>,\n'
//           '    "calories": <int>\n'
//           '  },\n'
//           '  "fat": {\n'
//           '    "grams": <int>,\n'
//           '    "calories": <int>\n'
//           '  },\n'
//           '  "carbs": {\n'
//           '    "grams": <int>,\n'
//           '    "calories": <int>\n'
//           '  }\n'
//           '}'),
//     );

//     final imageBytes = await imageFile.readAsBytes();

//     final prompt = TextPart("");
//     final imageParts = [
//       DataPart('image/jpeg', imageBytes),
//     ];

//     final response = await model.generateContent([
//       Content.multi([prompt, ...imageParts])
//     ]);

//     // Assuming the response is in a simple text format
//     final responseText = response.text;
//     final jsonResponse = jsonDecode(responseText!);
//     print(responseText);

// // Create NutritionInfo objects from the JSON data
//     final proteinInfo = NutritionInfo.fromJson(jsonResponse['protein']);
//     final fatInfo = NutritionInfo.fromJson(jsonResponse['fat']);
//     final carbsInfo = NutritionInfo.fromJson(jsonResponse['carbs']);

// // Print the extracted information using the data classes
//     print(
//         'Protein: ${proteinInfo.grams} grams (${proteinInfo.calories} calories)');
//     print('Fat: ${fatInfo.grams} grams (${fatInfo.calories} calories)');
//     print('Carbs: ${carbsInfo.grams} grams (${carbsInfo.calories} calories)');

//     // Print the raw response
//     print(responseText);
//   }

// class NutritionInfo {
//   final int grams;
//   final int calories;

//   NutritionInfo({required this.grams, required this.calories});

//   factory NutritionInfo.fromJson(Map<String, dynamic> json) {
//     return NutritionInfo(
//       grams: json['grams'] as int,
//       calories: json['calories'] as int,
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'grams': grams,
//         'calories': calories,
//       };
// }

Row Logo_Text() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        'Cal',
        style: TextStyle(
            fontSize: size.height * 0.5,
            color: onPrimaryColor,
            fontWeight: FontWeight.w900,
            height: size.height * 0.016),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ories',
            style: TextStyle(
                fontSize: size.height * 0.28,
                color: onPrimaryColor,
                fontWeight: FontWeight.w900,
                // letterSpacing: 1,
                height: size.height * 0.004),
          ),
          Text(
            'culator',
            style: TextStyle(
                // letterSpacing: 1,
                fontSize: size.height * 0.19,
                color: onPrimaryColor,
                fontWeight: FontWeight.w900,
                height: size.height * 0.005),
          )
        ],
      )
    ],
  );
}
