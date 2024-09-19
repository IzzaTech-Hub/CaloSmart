// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:calories_detector/app/modules/home/controllers/age_controller.dart';
import 'package:calories_detector/app/modules/home/views/history_show.dart';
import 'package:calories_detector/app/modules/utills/app_images.dart';
import 'package:calories_detector/sizeConfig.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
            padding: EdgeInsets.symmetric(vertical: size.height * 0.3),
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
                verticalSpace(size.height * 0.15),
                Text(
                  "Please Enter Your Age",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.height * 0.12),
                  textAlign: TextAlign.center,
                ),
                verticalSpace(size.height * 0.8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        print("My age is ");
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
                            DropdownButton<int>(
                              value: _selectedNumber,
                              // icon: const Icon(Icons.arrow_downward),
                              // iconSize: size.height * 0.1,
                              elevation: 16,
                              style: TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 1,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (int? newValue) {
                                // Update the local variable without calling setState
                                _selectedNumber = newValue;
                              },
                              items: numbers
                                  .map<DropdownMenuItem<int>>((int value) {
                                return DropdownMenuItem<int>(
                                  value: value,
                                  child: Text(value.toString()),
                                );
                              }).toList(),
                            ),
                            TextButton(
                              onPressed: () {
                                // Print the selected number
                                print("Selected Number: $_selectedNumber");
                              },
                              child: Text('OK',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w400)),
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
