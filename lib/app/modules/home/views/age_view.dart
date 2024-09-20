// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:calories_detector/app/modules/home/controllers/age_controller.dart';
import 'package:calories_detector/app/modules/home/views/history_show.dart';
import 'package:calories_detector/app/modules/utills/app_colors.dart';
import 'package:calories_detector/app/modules/utills/app_images.dart';
import 'package:calories_detector/app/routes/app_pages.dart';
import 'package:calories_detector/sizeConfig.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color onSecondaryColor = const Color(0xffFFffff);
Color secondaryColor = Color(0xffFF4D6D);
Color primaryColor = Color(0xffFFD1DC);
Color onPrimaryColor = Color(0xff1E3A5F);
Color tertoryColor = Color(0xffE3D7FF);
int? _selectedNumber;
List<int> numbers = List<int>.generate(90, (i) => i + 6);

class AgeView extends GetView<AgeController> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        color: tertoryColor,
        child: Stack(children: [
          Positioned(
            top: 0,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white, // Fully visible
                    Colors.transparent // Fully transparent
                  ],
                ).createShader(bounds);
              },
              blendMode:
                  BlendMode.dstIn, // This blends the gradient with the image
              child: Image.asset(
                AppImages.bkgImage,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent, // Fully visible
                    Colors.white // Fully transparent
                  ],
                ).createShader(bounds);
              },
              blendMode:
                  BlendMode.dstIn, // This blends the gradient with the image
              child: Image.asset(
                AppImages.bkgImage,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // Aligns to the top
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Cal',
                      style: TextStyle(
                          fontSize: 90,
                          color: onPrimaryColor,
                          fontWeight: FontWeight.w900,
                          height: 1),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ories',
                          style: TextStyle(
                              fontSize: 45,
                              color: onPrimaryColor,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                              height: 0.8),
                        ),
                        Text(
                          'culator',
                          style: TextStyle(
                              letterSpacing: 1,
                              fontSize: 45,
                              color: onPrimaryColor,
                              fontWeight: FontWeight.w900,
                              height: 0.8),
                        )
                      ],
                    )
                  ],
                ),
                verticalSpace(size.height * 0.15),
                Text(
                  "Please Enter Your Age",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.height * 0.12),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.015),
                Obx(() => InkWell(
                      onTap: () =>
                          print("My age is ${controller.selectedNumber}"),
                      child: Container(
                        decoration: BoxDecoration(
                            // color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                SizeConfig.screenHeight * 0.05)),
                        height: SizeConfig.screenHeight * 0.49,
                        width: SizeConfig.screenWidth * 0.75,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            NumberPicker(
                              value: controller.selectedNumber.value,
                              minValue: 6,
                              maxValue: 95,
                              onChanged: (newValue) =>
                                  controller.selectedNumber.value = newValue,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.deepPurpleAccent),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setInt('selected_number',
                                    controller.selectedNumber.value);
                                print(
                                    "Selected Number: ${controller.selectedNumber.value}");
                                Get.toNamed(Routes.HOME);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(size.height * 0.15),
                                  color: AppColors.primaryColor,
                                ),
                                height: size.height * 0.25,
                                width: size.width * 0.25,
                                child: Center(
                                  child: Text('OK',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.onPrimaryColor)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
