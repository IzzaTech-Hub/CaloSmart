import 'package:calories_detector/app/modules/ResponseScreen/controllers/response_screen_controller.dart';
import 'package:calories_detector/app/modules/home/controllers/comparison_controller.dart';
import 'package:calories_detector/app/modules/home/views/home_view.dart';
import 'package:calories_detector/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:fl_chart/fl_chart.dart';

// Color onSecondaryColor = const Color(0xffFFffff);
Color onSecondaryColor = const Color(0xffFFffff);
Color secondaryColor = Color(0xffFF4D6D);
Color primaryColor = Color.fromARGB(255, 252, 203, 214);
Color onPrimaryColor = Color(0xff1E3A5F);

class ComparisonView extends GetView<ComparisonController> {
  const ComparisonView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final screenWidth = SizeConfig.screenWidth;
    final screenHeight = SizeConfig.screenHeight;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 253, 135, 174),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            size: size.height * 0.2, // Adjusting for a more standardized size
          ),
          onPressed: () {
            Get.back(); // This will take you back to the previous screen
          },
        ),
        title: Text(
          "Comparison",
          style: TextStyle(
              fontSize: size.height * 0.2), // Adjusting for readability
        ),
      ),
      backgroundColor: primaryColor,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(size.height * 0.15),
          Text(
            "  A Piece of cake",
            style: TextStyle(fontSize: size.height * 0.15),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "  Toral Calories",
                style:
                    TextStyle(color: Colors.red, fontSize: size.height * 0.15),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "271",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: size.height * 0.1,
                        fontWeight: FontWeight.w900),
                  ),
                  Text(
                    "Kcal",
                    style: TextStyle(
                        color: Colors.red, fontSize: size.height * 0.08),
                  ),
                  Text(
                    "in 1 cake o.5 kg",
                    style: TextStyle(
                        color: Colors.red, fontSize: size.height * 0.075),
                  ),
                ],
              ),
            ],
          ),
          verticalSpace(size.height * 0.05),
          SizedBox(
            height: screenHeight * 0.12,
            // width: screenWidth * 1,
            child: Stack(
              children: [
                Positioned(
                  right: -25,
                  child: Container(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.1,
                    color: onSecondaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Carbs',
                              style: TextStyle(
                                  color: Color(0xffFF69B4),
                                  fontWeight: FontWeight.w700,
                                  fontSize: size.height * 0.08),
                            ),
                            Text(
                              'Protein',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w700,
                                  fontSize: size.height * 0.08),
                            ),
                            Text(
                              'Fat',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w700,
                                  fontSize: size.height * 0.08),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // '${ResponseScreenController().foodData.value!.item.carbs} g',
                              "35 g",
                              style: TextStyle(
                                  color: Color(0xffFF69B4),
                                  fontWeight: FontWeight.w500,
                                  fontSize: size.height * 0.08),
                            ),
                            Text(
                              // '${ResponseScreenController().foodData.value!.item.protein} g',
                              "45 g",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                  fontSize: size.height * 0.08),
                            ),
                            Text(
                              // '${ResponseScreenController().foodData.value!.item.fat} g',
                              "110 g",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                  fontSize: size.height * 0.08),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // '${ResponseScreenController().foodData.value!.item.percentageCaloriesFromCarbs} %',
                              "10 %",
                              style: TextStyle(
                                  color: Color(0xffFF69B4),
                                  fontWeight: FontWeight.w500,
                                  fontSize: size.height * 0.08),
                            ),
                            Text(
                              // '${ResponseScreenController().foodData.value!.item.percentageCaloriesFromProtein} %',
                              "23 %",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                  fontSize: size.height * 0.08),
                            ),
                            Text(
                              // '${ResponseScreenController().foodData.value!.item.percentageCaloriesFromFat} %',
                              "42 %",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                  fontSize: size.height * 0.08),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  child: Container(
                    height: screenHeight * 0.1,
                    width: screenHeight * 0.1,
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                      child: Container(
                        height: screenHeight * 0.08,
                        width: screenHeight * 0.08,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(100)),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                // // ResponseScreenController().foodData.value!.item.totalCalories
                                //     .toString(),
                                "272",
                                style: TextStyle(
                                  fontSize: size.height * 0.08,
                                  color: onPrimaryColor,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                // // ResponseScreenController().foodData.value!.item.totalCalories
                                //     .toString(),
                                "kcal",
                                style: TextStyle(
                                  fontSize: size.height * 0.08,
                                  color: onPrimaryColor,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              height: size.height * 1.2,
              width: size.width * 2,
              color: tertoryColor,
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "  A Piece of cake",
                      style: TextStyle(fontSize: size.height * 0.15),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "  Toral Calories",
                          style: TextStyle(
                              color: Colors.red, fontSize: size.height * 0.15),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "271",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: size.height * 0.1,
                                  fontWeight: FontWeight.w900),
                            ),
                            Text(
                              "Kcal",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: size.height * 0.08),
                            ),
                            Text(
                              "in 1 cake o.5 kg",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: size.height * 0.075),
                            ),
                          ],
                        ),
                      ],
                    ),
                    verticalSpace(size.height * 0.05),
                    SizedBox(
                      height: screenHeight * 0.12,
                      // width: screenWidth * 1,
                      child: Stack(
                        children: [
                          Positioned(
                            right: 90,
                            child: Container(
                              width: screenWidth * 0.8,
                              height: screenHeight * 0.1,
                              color: onSecondaryColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Carbs',
                                        style: TextStyle(
                                            color: Color(0xffFF69B4),
                                            fontWeight: FontWeight.w700,
                                            fontSize: size.height * 0.08),
                                      ),
                                      Text(
                                        'Protein',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w700,
                                            fontSize: size.height * 0.08),
                                      ),
                                      Text(
                                        'Fat',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.w700,
                                            fontSize: size.height * 0.08),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        // '${ResponseScreenController().foodData.value!.item.carbs} g',
                                        "35 g",
                                        style: TextStyle(
                                            color: Color(0xffFF69B4),
                                            fontWeight: FontWeight.w500,
                                            fontSize: size.height * 0.08),
                                      ),
                                      Text(
                                        // '${ResponseScreenController().foodData.value!.item.protein} g',
                                        "45 g",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w500,
                                            fontSize: size.height * 0.08),
                                      ),
                                      Text(
                                        // '${ResponseScreenController().foodData.value!.item.fat} g',
                                        "110 g",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.w500,
                                            fontSize: size.height * 0.08),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        // '${ResponseScreenController().foodData.value!.item.percentageCaloriesFromCarbs} %',
                                        "10 %",
                                        style: TextStyle(
                                            color: Color(0xffFF69B4),
                                            fontWeight: FontWeight.w500,
                                            fontSize: size.height * 0.08),
                                      ),
                                      Text(
                                        // '${ResponseScreenController().foodData.value!.item.percentageCaloriesFromProtein} %',
                                        "23 %",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w500,
                                            fontSize: size.height * 0.08),
                                      ),
                                      Text(
                                        // '${ResponseScreenController().foodData.value!.item.percentageCaloriesFromFat} %',
                                        "42 %",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.w500,
                                            fontSize: size.height * 0.08),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 225,
                            child: Container(
                              height: screenHeight * 0.1,
                              width: screenHeight * 0.1,
                              decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: BorderRadius.circular(100)),
                              child: Center(
                                child: Container(
                                  height: screenHeight * 0.08,
                                  width: screenHeight * 0.08,
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          // // ResponseScreenController().foodData.value!.item.totalCalories
                                          //     .toString(),
                                          "272",
                                          style: TextStyle(
                                            fontSize: size.height * 0.08,
                                            color: onPrimaryColor,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        Text(
                                          // // ResponseScreenController().foodData.value!.item.totalCalories
                                          //     .toString(),
                                          "kcal",
                                          style: TextStyle(
                                            fontSize: size.height * 0.08,
                                            color: onPrimaryColor,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ])),
          // verticalSpace(size.height * 0.15),
          SizedBox(
            child: Container(
              height: size.height * 1.27,
              width: size.width * 1.12,
              color: const Color.fromARGB(255, 248, 131, 229),
              child: Text(
                "If you want textIf  you want textIf you want textIf you want textIf you want textIf you want text",
                style: TextStyle(
                    fontSize: size.height * 0.15, color: onPrimaryColor),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
