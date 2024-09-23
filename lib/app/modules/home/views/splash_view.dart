// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:calories_detector/app/modules/home/controllers/splash_Controller.dart';
import 'package:calories_detector/app/modules/utills/Themes/current_theme.dart';
import 'package:calories_detector/sizeConfig.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppThemeColors.bgGradient,
        ),
        child: 
     Logo_Text()
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
          //       // color: Color(0xffD5C4FF),
          //       'assets/bg_img.png',
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
          //       // color: Color(0xffD5C4FF),
          //       'assets/bg_img.png',
          //       width: MediaQuery.of(context).size.width,
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          // Center(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Text(
          //         'Cal',
          //         style: TextStyle(
          //             fontSize: 90,
          //             color: onPrimaryColor,
          //             fontWeight: FontWeight.w900,
          //             height: 1),
          //       ),
          //       Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             'ories',
          //             style: TextStyle(
          //                 fontSize: 45,
          //                 color: onPrimaryColor,
          //                 fontWeight: FontWeight.w900,
          //                 letterSpacing: 1,
          //                 height: 0.8),
          //           ),
          //           Text(
          //             'culator',
          //             style: TextStyle(
          //                 letterSpacing: 1,
          //                 fontSize: 45,
          //                 color: onPrimaryColor,
          //                 fontWeight: FontWeight.w900,
          //                 height: 0.8),
          //           )
          //         ],
          //       )
          //     ],
          //   ),
          // ),
     
       
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
