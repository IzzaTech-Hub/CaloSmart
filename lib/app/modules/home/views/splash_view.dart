// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:calories_detector/app/modules/home/controllers/splash_Controller.dart';
import 'package:calories_detector/sizeConfig.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

Color onSecondaryColor = const Color(0xffFFffff);
Color secondaryColor = Color(0xffFF4D6D);
Color primaryColor = Color(0xffFFD1DC);
Color onPrimaryColor = Color(0xff1E3A5F);
Color tertoryColor = Color(0xffE3D7FF);

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Container(
            color: tertoryColor,
            child: Center(
                child: Row(
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
            ))));
  }
}
