import 'dart:ui';

import 'package:calories_detector/sizeConfig.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/liquidloading_controller.dart';

class LiquidloadingView extends GetView<LiquidloadingController> {
  LiquidloadingView({super.key});
  // GetxController thiscontroller = LiquidloadingController();
  @override
  Widget build(BuildContext context) {
    Get.put(LiquidloadingController());

    return Stack(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            MovingContainer(
              rev: 1,
            ),
            MovingContainer(
              rev: -1,
            ),
            MovingContainer2(
              rev: 1,
            ),
            MovingContainer2(
              rev: -1,
            ),

            // Blurred Black Circles
            Center(
              child: BlurryCircle(
                color: Color(0xff002907),
                blurSigma: largeblureffect,
                size: largesize,
              ),
            ),
          ],
        ),
        Positioned(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            // color: Colors.white.withOpacity(1), // Light source
            foregroundDecoration: BoxDecoration(
              color: Color(0xffD9D9D9).withOpacity(1),
              backgroundBlendMode:
                  BlendMode.colorDodge, // Approximation of Color Dodge
            ),
          ),
        ),
        Positioned(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            // color: Colors.white.withOpacity(1), // Light source
            foregroundDecoration: BoxDecoration(
              color: Colors.black.withOpacity(1),
              backgroundBlendMode:
                  BlendMode.colorBurn, // Approximation of Color Dodge
            ),
          ),
        ),
        Align(
            alignment: Alignment.topCenter,
            child: Padding(
                padding: const EdgeInsets.only(top: 18),
                child: Obx(
                  () => Text(
                    '${controller.loadingnow}',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                  ),
                )))
      ],
    );
    ;
  }
}

// class LiquidEffect extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // double screenHeight = MediaQuery.of(context).size.height;
//     // double screenWidth = MediaQuery.of(context).size.width;
//     return  }
// }
