import 'package:flutter/material.dart';

class ThemeColors {
  static const dark1 = Color(0xff2ECC71);
  static const dark2 = Color(0xffB2FF59);
  static const light1 = Color(0xffE0F5E2);
  static const light2 = Color(0xffD2F8D7);
  static const nowhite1 = Color.fromARGB(255, 244, 250, 245);
  static const nowhite2 = Color.fromARGB(255, 236, 254, 238);
  static const darkBlue = Color(0xff1E3A5F);

  static const primaryColor = nowhite2;
  static const onPrimary1 = dark1;
  static const onPrimary2 = dark2;
  static const secondery1 = light1;
  static const secondery2 = light2;
  static const iconColor = dark1;
  static const logoColor = darkBlue;
  // static const graph1 = Color(0xffA259FF);
  // static const graph1 = Color(0xff3466AF);
  static const graph1 =
      Color.fromARGB(255, 74, 122, 226); // static const graph2 = dark2;
  static const graph2 = Colors.green;
  // static const graph3 = Color(0xffD32F2F);
  static const graph3 = Color.fromARGB(255, 209, 53, 53);
  // static const graph3 = Color.fromARGB(255, 228, 76, 76);
}

class AppGradient {
  static const buttonGradient = LinearGradient(
      colors: [Color(0xff2ECC71), Color(0xffB2FF59)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
  static const bgGradient = LinearGradient(
      colors: [ThemeColors.nowhite1, ThemeColors.nowhite2],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
  // static const bgGradient =LinearGradient(colors: [Color(0xffE0F5E2), Color(0xffD2F8D7)]);
  static const gradient1 = LinearGradient(
      colors: [Color(0xffD2F8D7), Color(0xffE0F5E2)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
  static const gradient2 = LinearGradient(
      colors: [Color(0xffE0F5E2), Color(0xffD2F8D7)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
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
  var bodyText1 = TextStyle(
      height: 1, fontSize: 16.0, color: const Color.fromARGB(255, 0, 0, 0));
  var bodyText2 = TextStyle(height: 1, fontSize: 14.0, color: Colors.white);
  var buttonText = TextStyle(
      height: 1,
      fontSize: 14.0,
      color: Colors.white,
      // color: Colors.black,
      // color: AppColors.onPrimaryColor,
      fontWeight: FontWeight.w500);
}
