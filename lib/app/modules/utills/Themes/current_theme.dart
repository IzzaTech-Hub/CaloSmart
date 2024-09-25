import 'package:calories_detector/app/modules/utills/Themes/Theme1.dart';
import 'package:calories_detector/app/modules/utills/app_colors.dart';
import 'package:calories_detector/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppThemeColors {
  static const primarycolor = ThemeColors.primaryColor;
  static const onPrimary1 = ThemeColors.onPrimary1;
  static const onPrimary2 = ThemeColors.onPrimary2;
  static const secondery1 = ThemeColors.secondery1;
  static const secondery2 = ThemeColors.secondery2;
  static const iconColor = Colors.white;
  static const logoColor = ThemeColors.logoColor;
  static const graph1 = ThemeColors.graph1;
  static const graph2 = ThemeColors.graph2;
  static const graph3 = ThemeColors.graph3;
  // static const iconColor = ThemeColors.iconColor;

// static const buttonGradient = LinearGradient(colors: [onPrimary1,onPrimary2],begin: Alignment.topLeft,end: Alignment.bottomRight);
  static const primaryGradient1 = AppGradient.buttonGradient;
  static const secondaryGradient1 = AppGradient.gradient1;
  static const secondaryGradient2 = AppGradient.gradient2;
  static const buttonColor = AppGradient.buttonGradient;
  static const buttonColor1 = secondery1;
  static const bgGradient = AppGradient.bgGradient;
  static const bgColor = ThemeColors.nowhite1;
}

class AppThemeText {
  var headline1 = AppText().headline1;
  var headline2 = AppText().headline2;
  var bodyText1 = AppText().bodyText1;
  var bodyText2 = AppText().bodyText2;
  var buttonText = AppText().buttonText;
}

class AppThemeButton {
  final Function() onPressed; // Function without arguments and return type.
  final String text;

  AppThemeButton({
    required this.onPressed,
    required this.text,
  });

  // Method to create a small button
  Widget smallButton() {
    return InkWell(
      onTap: onPressed,
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: SizeConfig.screenWidth * 0.425,
        height: SizeConfig.screenHeight * 0.05,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10.0,
                offset: Offset(0, 5),
              ),
            ],
            borderRadius: BorderRadius.circular(100),
            // color: AppThemeColors.onPrimary1,
            gradient: AppThemeColors.buttonColor),
        child: Stack(
          children: [
            Positioned(
              right: -SizeConfig.screenWidth * 0.16,
              bottom: -SizeConfig.screenWidth * 0.31,
              child: Container(
                width: SizeConfig.screenWidth * 0.425,
                height: SizeConfig.screenWidth * 0.425,
                // height: 10,
                // width: 10,

                decoration: BoxDecoration(

                    // borderRadius: BorderRadius.circular(100),
                    shape: BoxShape.circle,
                    // color: Colors.black,
                    border: Border.all(
                        color: const Color.fromARGB(150, 255, 255, 255),
                        width: 1),
                    gradient: RadialGradient(colors: [
                      Color.fromARGB(30, 255, 255, 255),
                      Color.fromARGB(60, 255, 255, 255),
                    ])),
              ),
            ),
            Center(
              child: Text(
                text,
                style: AppText().buttonText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget largeButton() {
    return InkWell(
      onTap: onPressed,
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: SizeConfig.screenHeight * 0.05,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10.0,
                offset: Offset(0, 5),
              ),
            ],
            borderRadius: BorderRadius.circular(100),
            // color: AppColors.secondaryColor,
            gradient: AppThemeColors.buttonColor),
        child: Stack(
          children: [
            Positioned(
              right: -SizeConfig.screenWidth * 0.16,
              bottom: -SizeConfig.screenWidth * 0.31,
              child: Container(
                width: SizeConfig.screenWidth * 0.425,
                height: SizeConfig.screenWidth * 0.425,
                // height: 10,
                // width: 10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    // color: Colors.black,
                    border: Border.all(
                        color: const Color.fromARGB(150, 255, 255, 255),
                        width: 1),
                    gradient: RadialGradient(colors: [
                      Color.fromARGB(30, 255, 255, 255),
                      Color.fromARGB(60, 255, 255, 255),
                    ])),
              ),
            ),
            Center(
              child: Text(
                text,
                style: AppText().buttonText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Container appThemeAppBar(context, String title) {
  return Container(
    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    height: 80.0, // Height of AppBar
    decoration: BoxDecoration(
      // color: Colors.blue, // Background color
      gradient: AppThemeColors.primaryGradient1,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 10.0,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () {
            // Menu button action
            Get.back();
          },
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        // SizedBox()
        IconButton(
          icon: Icon(Icons.notifications, color: Colors.transparent),
          onPressed: () {
            // Notification button action
          },
        ),
      ],
    ),
  );
}
