import 'package:calories_detector/app/modules/utills/Themes/Theme1.dart';
import 'package:calories_detector/app/modules/utills/app_images.dart';
import 'package:calories_detector/app/premium/premium.dart';
import 'package:calories_detector/app/routes/app_pages.dart';
import 'package:calories_detector/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AppThemeColors {
  static const primarycolor = ThemeColors.primaryColor;
  static const splashColor = Colors.green;
  static const onPrimary1 = ThemeColors.onPrimary1;
  static const onPrimary2 = ThemeColors.onPrimary2;
  static const onPrimary2light = Color(0xffD1FF9B);
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
  final Function() onPressed;
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
            Positioned(
                child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.05), BlendMode.colorBurn),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  // Colors.black.withOpacity(0.2),
                  // AppThemeColors.onPrimary1.withOpacity(0.4),

                  const Color.fromARGB(255, 0, 108, 32).withOpacity(0.3),
                  // const Color.fromARGB(255, 0, 255, 106).withOpacity(0.3),
                  Colors.white.withOpacity(0.1),
                  const Color.fromARGB(255, 0, 108, 32).withOpacity(0.3),
                  // AppThemeColors.onPrimary1.withOpacity(0.4),
                  // Colors.black.withOpacity(0.2)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              ),
            )),
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

  Widget AdditionalrewardsmallButton() {
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
            Positioned(
                child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.05), BlendMode.colorBurn),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  // Colors.black.withOpacity(0.2),
                  // AppThemeColors.onPrimary1.withOpacity(0.4),

                  const Color.fromARGB(255, 0, 108, 32).withOpacity(0.3),
                  // const Color.fromARGB(255, 0, 255, 106).withOpacity(0.3),
                  Colors.white.withOpacity(0.1),
                  const Color.fromARGB(255, 0, 108, 32).withOpacity(0.3),
                  // AppThemeColors.onPrimary1.withOpacity(0.4),
                  // Colors.black.withOpacity(0.2)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              ),
            )),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: AppText().buttonText,
                  ),
                  SizedBox(width: 15),
                  Image.asset(
                    AppImages.iconAdVedio,
                    height: SizeConfig.screenHeight * 0.03,
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget smallButtonwithprice(int Price) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: SizeConfig.screenWidth * 0.425,
        height: SizeConfig.screenHeight * 0.05,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 7.0,
                offset: Offset(0, 3),
                spreadRadius: 1,
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
            Positioned(
                child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.05), BlendMode.colorBurn),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  // Colors.black.withOpacity(0.2),
                  // AppThemeColors.onPrimary1.withOpacity(0.4),

                  const Color.fromARGB(255, 0, 108, 32).withOpacity(0.3),
                  // const Color.fromARGB(255, 0, 255, 106).withOpacity(0.3),
                  Colors.white.withOpacity(0.1),
                  const Color.fromARGB(255, 0, 108, 32).withOpacity(0.3),
                  // AppThemeColors.onPrimary1.withOpacity(0.4),
                  // Colors.black.withOpacity(0.2)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              ),
            )),
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: AppText().buttonText,
                  ),
                  if (!(Premium.instance.isPremium.value))
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Image.asset(
                        AppImages.premiumIcon,
                        height: 25,
                        color: Colors.amber,
                      ),
                    ),
                  if (Premium.instance.isPremium.value)
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          AppImages.apple2,
                          height: 35,
                          color: PremiumTheme.appleColor,
                        ),
                        Text(
                          '$Price',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        )
                      ],
                    ),
                ],
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
                color: Colors.black.withOpacity(0.3),
                blurRadius: 7.0,
                offset: Offset(0, 3),
                spreadRadius: 1,
              ),
            ],
            borderRadius: BorderRadius.circular(100),
            // color: AppColors.secondaryColor,
            gradient: AppThemeColors.buttonColor),
        child: Stack(
          children: [
            Positioned(
              // top: 0,
              // right: -SizeConfig.screenWidth * 0.4,
              right: -SizeConfig.screenWidth * 0.16,
              bottom: -SizeConfig.screenWidth * 0.31,
              child: Container(
                width: SizeConfig.screenWidth * 0.425,
                height: SizeConfig.screenWidth * 0.425,
                // width: SizeConfig.screenWidth * 1,
                // height: SizeConfig.screenWidth * 1,
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
            Positioned(
                child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.05), BlendMode.colorBurn),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  // Colors.black.withOpacity(0.2),
                  // AppThemeColors.onPrimary1.withOpacity(0.4),

                  const Color.fromARGB(255, 0, 108, 32).withOpacity(0.3),
                  // const Color.fromARGB(255, 0, 255, 106).withOpacity(0.3),
                  Colors.white.withOpacity(0.1),
                  const Color.fromARGB(255, 0, 108, 32).withOpacity(0.3),
                  // AppThemeColors.onPrimary1.withOpacity(0.4),
                  // Colors.black.withOpacity(0.2)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              ),
            )),
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

Widget rewardbutton(int day, int currentday) {
  return Container(
    clipBehavior: Clip.hardEdge,
    width: SizeConfig.screenWidth * 0.2,
    height: SizeConfig.screenHeight * 0.025,
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 3.0,
            offset: Offset(1, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(100),
        // color: AppThemeColors.onPrimary1,
        gradient: day < currentday
            ? LinearGradient(
                colors: [Colors.grey.shade500, Colors.grey.shade500])
            : (day == currentday
                ? AppThemeColors.buttonColor
                : LinearGradient(
                    colors: [ThemeColors.onPrimary1, ThemeColors.onPrimary2]))),
    child: Stack(
      children: [
        if (day != currentday)
          Container(
            width: 500,
            height: 500,
            color: Colors.white.withOpacity(0.6),
          ),
        Positioned(
          right: -SizeConfig.screenWidth * 0.14,
          top: 0,
          // bottom: -SizeConfig.screenWidth * 0.09,
          child: Container(
            width: SizeConfig.screenWidth * 0.3,
            height: SizeConfig.screenWidth * 0.2,
            // height: 10,
            // width: 10,

            decoration: BoxDecoration(

                // borderRadius: BorderRadius.circular(100),
                shape: BoxShape.circle,
                // color: Colors.black,
                border: Border.all(
                    color: const Color.fromARGB(150, 255, 255, 255), width: 1),
                gradient: RadialGradient(colors: [
                  Color.fromARGB(30, 255, 255, 255),
                  Color.fromARGB(60, 255, 255, 255),
                ])),
          ),
        ),
        Center(
          child: Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                      day < currentday ||
                              day == currentday &&
                                  Premium.instance.isrewardCollected!.value
                          ? 'Collected'
                          : 'Collect',
                      style: TextStyle(
                          fontSize: day < currentday ||
                                  day == currentday &&
                                      Premium.instance.isrewardCollected!.value
                              ? 11
                              : 12,
                          color: Colors.black)),
                  if (!Premium.instance.isPremium.value &&
                      day == currentday &&
                      !Premium.instance.isrewardCollected!.value)
                    Image.asset(
                      AppImages.iconAdVedio,
                      height: SizeConfig.screenWidth * 0.028,
                      color: Colors.black,
                    )
                ],
              )),
        ),
      ],
    ),
  );
}

Widget rewardbuttonfor7(int day, int currentday) {
  return Container(
    clipBehavior: Clip.hardEdge,
    width: SizeConfig.screenWidth * 0.2,
    height: SizeConfig.screenHeight * 0.025,
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 3.0,
            offset: Offset(1, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(100),
        // color: AppThemeColors.onPrimary1,
        gradient: LinearGradient(
            colors: [ThemeColors.onPrimary1, ThemeColors.onPrimary2])),
    child: Stack(
      children: [
        if (currentday <= day)
          Container(
            width: 500,
            height: 500,
            color: Colors.white.withOpacity(0.6),
          ),
        Positioned(
          right: -SizeConfig.screenWidth * 0.14,
          top: 0,
          // bottom: -SizeConfig.screenWidth * 0.09,
          child: Container(
            width: SizeConfig.screenWidth * 0.3,
            height: SizeConfig.screenWidth * 0.2,
            // height: 10,
            // width: 10,

            decoration: BoxDecoration(

                // borderRadius: BorderRadius.circular(100),
                shape: BoxShape.circle,
                // color: Colors.black,
                border: Border.all(
                    color: const Color.fromARGB(150, 255, 255, 255), width: 1),
                gradient: RadialGradient(colors: [
                  Color.fromARGB(30, 255, 255, 255),
                  Color.fromARGB(60, 255, 255, 255),
                ])),
          ),
        ),
        Center(
          child: Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                      day < currentday ||
                              day == currentday &&
                                  Premium.instance.isrewardCollected!.value
                          ? 'Collected'
                          : 'Collect',
                      style: TextStyle(
                          fontSize: day < currentday ||
                                  day == currentday &&
                                      Premium.instance.isrewardCollected!.value
                              ? 11
                              : 12,
                          color: Colors.black)),
                  if (!Premium.instance.isPremium.value &&
                      day == currentday &&
                      !Premium.instance.isrewardCollected!.value)
                    Image.asset(
                      AppImages.iconAdVedio,
                      height: SizeConfig.screenWidth * 0.028,
                      color: Colors.black,
                    )
                ],
              )),
        ),
      ],
    ),
  );
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
    child: Stack(
      children: [
        Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!(Premium.instance.isPremium.value))
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.PAYWALL);
                  },
                  child: SizedBox(
                    // color: Colors.red,
                    height: 30,
                    // width: 30,
                    child: Image.asset(
                      AppImages.premiumIcon,
                      color: Colors.amber,
                    ),
                  ),
                ),
              SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.STREAK);
                  },
                  child: SizedBox(
                    // color: Colors.red,
                    width: 70,
                    height: 40,
                    child: Stack(
                      // alignment: Alignment.centerRight,
                      children: [
                        // Rounded background container
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: 20,
                            width: 60,
                            // margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              // color: Colors.grey[100],
                              borderRadius:
                                  BorderRadius.circular(20), // Rounded edges
                              border: Border.all(
                                color: Color(0xff2ECC71), // Green border color
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                ),
                                BoxShadow(
                                  color: Colors.green,
                                  spreadRadius: -20.0,
                                  blurRadius: 20.0,
                                ),
                              ],
                            ),
                            // alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(left: 16),
                            child: Center(
                              child: Row(
                                children: [
                                  Image(
                                    image: AssetImage(AppImages.applecenter),
                                    color: PremiumTheme.appleColor,
                                    // color: Colors.red,
                                    alignment: Alignment.centerLeft,
                                    // width: 12,
                                    // height: 35,
                                  ),
                                  Obx(() => Text(
                                        // 'X10',
                                        'X${Premium.instance.apple!.value}',
                                        // textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontSize:
                                              Premium.instance.apple!.value <
                                                      100
                                                  ? 10
                                                  : 8,
                                          // height: 1,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child:
                              // Image(
                              //   image: AssetImage(AppImages.apple2),
                              //   color: PremiumTheme.appleColor,
                              //   // color: Colors.red,
                              //   alignment: Alignment.centerLeft,
                              //   width: 35,
                              //   height: 35,
                              // ),
                              Container(
                            decoration: BoxDecoration(
                                color: Colors.black, shape: BoxShape.circle),
                            width: 26,
                            height: 26,
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    shape: BoxShape.circle),
                                width: 22,
                                height: 22,
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                    width: 18,
                                    height: 18,
                                    child: Center(
                                      child: Obx(() => Premium
                                              .instance.isrewardCollected!.value
                                          ? Text(
                                              '${Premium.instance.currentStreak}',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  height: 1,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Lottie.asset(
                                              LottieAnimations.giftbox,
                                              repeat:
                                                  true, // Loop the animation
                                              reverse:
                                                  false, // Play animation forward only
                                              animate:
                                                  true, // Start animation automatically
                                            )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}

Container appThemeAppBarforaichat(context, String title) {
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
    child: Stack(
      children: [
        Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!(Premium.instance.isPremium.value))
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.PAYWALL);
                  },
                  child: SizedBox(
                    // color: Colors.red,
                    height: 30,
                    // width: 30,
                    child: Image.asset(
                      AppImages.premiumIcon,
                      color: Colors.amber,
                    ),
                  ),
                ),
              SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.STREAK);
                  },
                  child: SizedBox(
                    // color: Colors.red,
                    width: 70,
                    height: 40,
                    child: Stack(
                      // alignment: Alignment.centerRight,
                      children: [
                        // Rounded background container
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: 20,
                            width: 60,
                            // margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              // color: Colors.grey[100],
                              borderRadius:
                                  BorderRadius.circular(20), // Rounded edges
                              border: Border.all(
                                color: Color(0xff2ECC71), // Green border color
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                ),
                                BoxShadow(
                                  color: Colors.green,
                                  spreadRadius: -20.0,
                                  blurRadius: 20.0,
                                ),
                              ],
                            ),
                            // alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(left: 16),
                            child: Center(
                              child: Row(
                                children: [
                                  Image(
                                    image: AssetImage(AppImages.applecenter),
                                    color: PremiumTheme.appleColor,
                                    // color: Colors.red,
                                    alignment: Alignment.centerLeft,
                                    // width: 12,
                                    // height: 35,
                                  ),
                                  Obx(() => Text(
                                        // 'X10',
                                        'X${Premium.instance.apple!.value}',
                                        // textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontSize:
                                              Premium.instance.apple!.value <
                                                      100
                                                  ? 10
                                                  : 8,
                                          // height: 1,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child:
                              // Image(
                              //   image: AssetImage(AppImages.apple2),
                              //   color: PremiumTheme.appleColor,
                              //   // color: Colors.red,
                              //   alignment: Alignment.centerLeft,
                              //   width: 35,
                              //   height: 35,
                              // ),
                              Container(
                            decoration: BoxDecoration(
                                color: Colors.black, shape: BoxShape.circle),
                            width: 26,
                            height: 26,
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    shape: BoxShape.circle),
                                width: 22,
                                height: 22,
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                    width: 18,
                                    height: 18,
                                    child: Center(
                                      child: Obx(() => Text(
                                            '${Premium.instance.currentStreak}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                height: 1,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
              onPressed: () {
                // Menu button action
                Get.back();
              },
            ),

            // Text(
            //   title,
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 20.0,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // SizedBox()
            IconButton(
              icon: Icon(Icons.notifications, color: Colors.transparent),
              onPressed: () {
                // Notification button action
              },
            ),
          ],
        ),
      ],
    ),
  );
}

Container appThemeAppBar2(context, String title) {
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

Container appThemeAppBar3(context, String title) {
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
    child: Stack(
      children: [
        Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration:
                    BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                width: 26,
                height: 26,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.amber, shape: BoxShape.circle),
                    width: 22,
                    height: 22,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        width: 18,
                        height: 18,
                        child: Center(
                          child: Text(
                            '10',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                height: 1,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: SizedBox(
                  width: 55,
                  height: 50,
                  child: Stack(
                    // alignment: Alignment.centerRight,
                    children: [
                      // Rounded background container
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: 18,
                          width: 40,
                          // margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            // color: Colors.grey[100],
                            borderRadius:
                                BorderRadius.circular(20), // Rounded edges
                            border: Border.all(
                              color: Color(0xff2ECC71), // Green border color
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                              ),
                              BoxShadow(
                                color: Colors.green,
                                spreadRadius: -20.0,
                                blurRadius: 20.0,
                              ),
                            ],
                          ),
                          // alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(left: 5),
                          child: Center(
                            child: Obx(() => Text(
                                  // '1',
                                  '${Premium.instance.apple!.value}',
                                  // textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 12,
                                    height: 1,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image(
                          image: AssetImage(AppImages.apple2),
                          color: PremiumTheme.appleColor,
                          // color: Colors.red,
                          alignment: Alignment.centerLeft,
                          width: 35,
                          height: 35,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}
