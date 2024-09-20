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
              padding: EdgeInsets.only(top: size.height * 0.35),
              child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.start, // Aligns to the top
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
                    verticalSpace(size.height * 0.2),
                    Text(
                      "Please Enter Your Age",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.1),
                    Obx(() => InkWell(
                          onTap: () =>
                              print("My age is ${controller.selectedNumber}"),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              NumberPicker(
                                value: controller.selectedNumber.value,
                                minValue: 1,
                                maxValue: 100,
                                itemHeight: 55,
                                itemWidth: 325,
                                textStyle: TextStyle(fontSize: 15),
                                selectedTextStyle: TextStyle(
                                    fontSize: 35,
                                    color: AppColors.secondaryColor),
                                axis: Axis.vertical,
                                onChanged: (newValue) =>
                                    controller.selectedNumber.value = newValue,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                        color: AppColors.secondaryColor),
                                    shape: BoxShape.rectangle),
                              ),
                              verticalSpace(size.height * 1.15),
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
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.secondaryColor,
                                  ),
                                  height: SizeConfig.screenHeight * 0.06,
                                  width: SizeConfig.screenWidth * 0.87,
                                  child: Center(
                                    child: Text('Next',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 20,
                                            color: Colors.white)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ])),
        ]),
      ),
    );
  }
}
