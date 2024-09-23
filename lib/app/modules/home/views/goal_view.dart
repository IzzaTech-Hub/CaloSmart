// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:calories_detector/app/modules/home/controllers/goal_controller.dart';
import 'package:calories_detector/app/modules/home/views/history_show.dart';
import 'package:calories_detector/app/modules/utills/Themes/current_theme.dart';
import 'package:calories_detector/app/modules/utills/app_colors.dart';
import 'package:calories_detector/app/modules/utills/app_images.dart';
import 'package:calories_detector/app/routes/app_pages.dart';
import 'package:calories_detector/sizeConfig.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class goalView extends GetView<GoalController> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        // color: AppColors.tertoryColor,
        decoration: BoxDecoration(gradient: AppThemeColors.bgGradient),
        child: Stack(children: [
          // Positioned(
          //   top: 0,
          //   child: ShaderMask(
          //     shaderCallback: (Rect bounds) {
          //       return LinearGradient(
          //         begin: Alignment.topCenter,
          //         end: Alignment.bottomCenter,
          //         colors: [
          //           Colors.white, // Fully visible
          //           Colors.transparent // Fully transparent
          //         ],
          //       ).createShader(bounds);
          //     },
          //     blendMode:
          //         BlendMode.dstIn, // This blends the gradient with the image
          //     child: Image.asset(
          //       AppImages.bkgImage,
          //       width: MediaQuery.of(context).size.width,
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          // Positioned(
          //   bottom: 0,
          //   child: ShaderMask(
          //     shaderCallback: (Rect bounds) {
          //       return LinearGradient(
          //         begin: Alignment.topCenter,
          //         end: Alignment.bottomCenter,
          //         colors: [
          //           Colors.transparent, // Fully visible
          //           Colors.white // Fully transparent
          //         ],
          //       ).createShader(bounds);
          //     },
          //     blendMode:
          //         BlendMode.dstIn, // This blends the gradient with the image
          //     child: Image.asset(
          //       AppImages.bkgImage,
          //       width: MediaQuery.of(context).size.width,
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),

          Padding(
            padding:
                EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 0.1),
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
                          color: AppColors.onPrimaryColor,
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
                              color: AppColors.onPrimaryColor,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                              height: 0.8),
                        ),
                        Text(
                          'culator',
                          style: TextStyle(
                              letterSpacing: 1,
                              fontSize: 45,
                              color: AppColors.onPrimaryColor,
                              fontWeight: FontWeight.w900,
                              height: 0.8),
                        )
                      ],
                    )
                  ],
                ),
                verticalSpace(size.height * 0.15),
                Text(
                  "What is Your Goal?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                verticalSpace(size.height * 0.5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () async {
                        print("Lose Weight Print");
                        // Obtain shared preferences
                        final prefs = await SharedPreferences.getInstance();

                        // Save a value
                        await prefs.setString('selected_button', 'Lose Weight');
                        String selectedButton =
                            prefs.getString('selected_button') ?? 'None';
                        print("Selected button: $selectedButton");
                        Get.toNamed(Routes.GENDER_SCREEN);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(size.height * 0.15)),
                        height: size.height * 0.29,
                        width: size.width * 0.5,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.run_circle_outlined,
                              color: Colors.lightBlueAccent,
                            ),
                            Text(
                              "Loose Weight",
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                            SizedBox()
                          ],
                        ),
                      ),
                    ),
                    verticalSpace(size.height * 0.15),
                    InkWell(
                      onTap: () async {
                        print("Gain Weight Print");
                        // Obtain shared preferences
                        final prefs = await SharedPreferences.getInstance();

                        // Save a value
                        await prefs.setString('selected_button', 'Gain Weight');
                        String selectedButton =
                            prefs.getString('selected_button') ?? 'None';
                        print("Selected button: $selectedButton");
                        Get.toNamed(Routes.GENDER_SCREEN);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(size.height * 0.15)),
                        height: size.height * 0.29,
                        width: size.width * 0.5,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.restaurant_menu,
                              color: Colors.pink,
                            ),
                            Text(
                              "Gain Weight",
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                            SizedBox()
                          ],
                        ),
                      ),
                    ),
                    verticalSpace(size.height * 0.15),
                    InkWell(
                      onTap: () async {
                        print("Maintain Weight Print");
                        // Obtain shared preferences
                        final prefs = await SharedPreferences.getInstance();

                        // Save a value
                        await prefs.setString(
                            'selected_button', 'Maintain Weight');
                        String selectedButton =
                            prefs.getString('selected_button') ?? 'None';
                        print("Selected button: $selectedButton");
                        Get.toNamed(Routes.GENDER_SCREEN);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(size.height * 0.15)),
                        height: size.height * 0.29,
                        width: size.width * 0.5,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.sports_hockey_rounded,
                              color: Colors.green,
                            ),
                            Text(
                              "Maintain Weight",
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
