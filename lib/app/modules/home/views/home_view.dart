// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, avoid_print

// import 'dart:io';
// import 'package:calories_detector/app/modules/ResponseScreen/views/response_screen_view.dart';
// import 'package:calories_detector/app/data/Data_Base.dart';
// import 'package:calories_detector/app/modules/home/controllers/history_show_controller.dart';
// import 'package:calories_detector/app/modules/home/views/history_show.dart';
import 'package:calories_detector/app/modules/utills/app_colors.dart';
import 'package:calories_detector/app/routes/app_pages.dart';
import 'package:calories_detector/sizeConfig.dart';
import 'package:calories_detector/app/modules/utills/Themes/current_theme.dart';
import 'package:flutter/material.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'dart:convert';
import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
import '../controllers/home_controller.dart';
// import '../../../routes/app_pages.dart';

// Size size = Size(
//     SizeConfig.blockSizeHorizontal * 90, SizeConfig.blockSizeHorizontal * 50);

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  // NutritionInfo? proteinInfo;
  // NutritionInfo? fatInfo;
  // NutritionInfo? carbsInfo;

  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);
    return Scaffold(
      // backgroundColor: AppThemeColors.primarycolor,
      body: Container(
        decoration: BoxDecoration(
          // color: Colors.red
            // gradient: AppThemeColors.bgGradient
            ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            verticalSpace(SizeConfig.screenHeight * 0.05),
            Logo_Text(),
            verticalSpace(SizeConfig.screenHeight * 0.05),
            Text("Analyze your image now", style: AppThemeText().headline2),
            SizedBox(height: SizeConfig.screenHeight * 0.05),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.pickImageFromGallery();
                      },
                      child: Icon_Method("Choose from", "Gallery", Icons.image),
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
                verticalSpace(SizeConfig.screenWidth * 0.05),
                InkWell(
                  onTap: () {
                    // DatabaseHelper().deleteDatabaseFile();
                    Get.toNamed(Routes.HISTORY_VIEW_SCREEN);
                  },
                  child: Container(
                    height: SizeConfig.screenWidth * 0.2,
                    width: SizeConfig.screenWidth * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            SizeConfig.screenWidth * 0.05),
                        // color: AppThemeColors.buttonColor1
                        gradient: AppThemeColors.buttonColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: SizeConfig.screenWidth * 0.05),
                        Icon(
                          Icons.history,
                          size: SizeConfig.screenWidth * 0.15,
                          color: AppThemeColors.iconColor,
                        ),
                        SizedBox(width: SizeConfig.screenWidth * 0.05),
                        Text(
                          "Previous Logs",
                          style: AppThemeText().bodyText1,
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
    );
  }

  Container Icon_Method(String smallTexted, String largeTexted, IconData icon) {
    return Container(
      height: SizeConfig.screenWidth * 0.5,
      width: SizeConfig.screenWidth * 0.425,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConfig.screenWidth * 0.05),
          gradient: AppThemeColors.buttonColor
          // color: AppThemeColors.buttonColor1
          ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: SizeConfig.screenWidth * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              size: SizeConfig.screenWidth * 0.15,
              // color: AppThemeColors.iconColor,
              color: AppThemeColors.iconColor,
              // color: AppColors.onSecondaryColor,
            ),
            Text(smallTexted, style: AppThemeText().bodyText1),
            Text(largeTexted, style: AppThemeText().bodyText1),
          ],
        ),
      ),
    );
  }
}

Row Logo_Text() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        'Cal',
        style: TextStyle(
          fontSize: 80,
          color: AppThemeColors.logoColor,
          fontWeight: FontWeight.w900,
          // height: size.height * 0.016
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ories',
            style: TextStyle(
                fontSize: 35,
                color: AppThemeColors.logoColor,
                fontWeight: FontWeight.w900,
                // letterSpacing: 1,
                height: 1),
          ),
          Text(
            'culator',
            style: TextStyle(
                // letterSpacing: 1,
                fontSize: 35,
                color: AppThemeColors.logoColor,
                fontWeight: FontWeight.w900,
                height: 1),
          )
        ],
      )
    ],
  );
}
