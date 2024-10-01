import 'package:flutter/material.dart';
class ThemeColors{
static const dark1 = Color(0xff2ECC71);
static const dark2 = Color(0xffB2FF59);
static const light1 = Color(0xffE0F5E2);
static const light2 = Color(0xffD2F8D7);
static const nowhite = Color(0xffEEFFF0);

static const primaryColor = nowhite;
static const onPrimary1 = dark1;
static const onPrimary2 = dark2;
static const secondery1 = light1;
static const secondery2 = light2;

}
class AppGradient {
  static const buttonGradient = LinearGradient(
      colors: [Color(0xff2ECC71), Color(0xffB2FF59)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
  static const bgGradient =
      LinearGradient(colors: [Color(0xffE0F5E2), Color(0xffD2F8D7)]);
  static const gradient =
      LinearGradient(colors: [Color(0xffE0F5E2), Color(0xffD2F8D7)]);
}

class AppText {
  var headline1 = TextStyle(
      height: 1,
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      // color: Colors.white
      color: ThemeColors.onPrimary1);
  var headline2 = TextStyle(
      height: 1,
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      color: const Color.fromARGB(255, 0, 0, 0));
  var bodyText1 = TextStyle(height: 1, fontSize: 16.0, color: Colors.white);
  var bodyText2 = TextStyle(height: 1, fontSize: 14.0, color: Colors.white);
  var buttonText = TextStyle(
      height: 1,
      fontSize: 14.0,
      color: Colors.white,
      // color: Colors.black,
      // color: AppColors.onPrimaryColor,
      fontWeight: FontWeight.w500);
}
