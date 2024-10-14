import 'package:calories_detector/app/modules/home/controllers/comparison_controller.dart';
import 'package:calories_detector/app/modules/utills/Themes/current_theme.dart';
import 'package:calories_detector/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:fl_chart/fl_chart.dart';

// // Color onSecondaryColor = const Color(0xffFFffff);
// Color onSecondaryColor = const Color(0xffFFffff);
// Color secondaryColor = Color(0xffFF4D6D);
// Color primaryColor = Color.fromARGB(255, 247, 226, 230);
// // Color primaryColor = Color.fromARGB(255, 252, 203, 214);
// Color onPrimaryColor = Color(0xff1E3A5F);

class ComparisonView extends GetView<ComparisonController> {
  const ComparisonView({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final screenWidth = SizeConfig.screenWidth;
    final screenHeight = SizeConfig.screenHeight;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: appThemeAppBar2(context, controller.name.value!)),
      // backgroundColor: ,
      body: Container(
        decoration: BoxDecoration(gradient: AppThemeColors.bgGradient),
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 10, bottom: 5),
                  child: Text(
                    controller.food1.value!.name,
                    textAlign: TextAlign.left,
                    style: AppThemeText().headline1,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total', style: AppThemeText().headline2,
                          // TextStyle(
                          //     fontSize: 35,
                          //     fontWeight: FontWeight.w700,
                          //     color: secondaryColor,
                          //     height: 1),
                        ),
                        Text(
                          'Calories',
                          style: AppThemeText().headline2,
                          // TextStyle(
                          //     fontSize: 35,
                          //     fontWeight: FontWeight.w700,
                          //     color: secondaryColor,
                          //     height: 1)
                        ),
                      ],
                    ),
                    SizedBox(),
                    SizedBox(),
                    SizedBox(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.food1.value!.totalCalories.toString(),
                          style: AppThemeText().headline2,
                          // TextStyle(
                          //     fontSize: 35,
                          //     fontWeight: FontWeight.w900,
                          //     color: onPrimaryColor,
                          //     height: 1),
                        ),
                        Text(
                          'Kcal',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppThemeColors.onPrimary1,
                              height: 1),
                        ),
                        Text(
                          // quantity,
                          controller.food1.value!.quantity,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: AppThemeColors.onPrimary1,
                              height: 1),
                        )
                      ],
                    ),
                    SizedBox(),
                  ],
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.025),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.1225,
                  width: SizeConfig.screenWidth,
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        child: Container(
                          width: SizeConfig.screenWidth * 0.8,
                          height: SizeConfig.screenHeight * 0.1225,
                          // height: 100,
                          // color: onSecondaryColor,
                          decoration: BoxDecoration(
                              gradient: AppThemeColors.secondaryGradient1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(),
                                  Text(
                                    'Carbs',
                                    style: TextStyle(
                                        color: AppThemeColors.graph1,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    'Protien',
                                    style: TextStyle(
                                        // color: Color(0xffFFD700),
                                        color: AppThemeColors.graph2,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    'Fat',
                                    style: TextStyle(
                                        color: AppThemeColors.graph3,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                                  SizedBox(),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(),
                                  Text(
                                    // '$carbsW g',
                                    '${controller.food1.value!.carbs} g',
                                    style: TextStyle(
                                        color: AppThemeColors.graph1,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    // '$protienW g',
                                    '${controller.food1.value!.protein} g',
                                    style: TextStyle(
                                        color: AppThemeColors.graph2,
                                        // color: Color(0xffFFD700),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    '${controller.food1.value!.fat} g',
                                    // '$fatW g',
                                    style: TextStyle(
                                        color: AppThemeColors.graph3,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  SizedBox(),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(),
                                  Text(
                                    '${controller.food1.value!.percentageCaloriesFromCarbs} %',
                                    // '$carbsp %',
                                    style: TextStyle(
                                        color: AppThemeColors.graph1,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    '${controller.food1.value!.percentageCaloriesFromProtein} %',
                                    // '$protienp %',
                                    style: TextStyle(
                                        color: AppThemeColors.graph2,
                                        // color: Color(0xffFFD700),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    '${controller.food1.value!.percentageCaloriesFromFat} %',
                                    // '$fatp %',
                                    style: TextStyle(
                                        color: AppThemeColors.graph3,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  SizedBox(),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        // right: screenWidth * 0,
                        // top: 0,
                        left: 0,
                        child: Center(
                          child: SizedBox(
                            // Set the overall size of the container to constrain the pie chart
                            height: SizeConfig.screenHeight * 0.1225,

                            width: SizeConfig.screenWidth *
                                0.4, // Set the desired width
                            child: PieChart(
                              PieChartData(
                                sectionsSpace: 0, // No space between sections
                                centerSpaceRadius: 0, // No space in the center
                                sections: [
                                  PieChartSectionData(
                                    color: AppThemeColors.graph1,
                                    // value: carbsp.toDouble(),
                                    value: controller.food1.value!
                                        .percentageCaloriesFromCarbs
                                        .toDouble(),
                                    // Remove text by setting an empty string for the title
                                    title: '',
                                    radius: SizeConfig.screenHeight *
                                        0.06125, // Adjust radius to fit within the container
                                  ),
                                  PieChartSectionData(
                                    // color: Color(0xffFFD700),
                                    color: AppThemeColors.graph2,
                                    value: controller.food1.value!
                                        .percentageCaloriesFromProtein
                                        .toDouble(),
                                    // value: protienp.toDouble(),
                                    title: '',
                                    radius: SizeConfig.screenHeight *
                                        0.06125, // Adjust radius to fit within the container
                                  ),
                                  PieChartSectionData(
                                    color: AppThemeColors.graph3,
                                    value: controller
                                        .food1.value!.percentageCaloriesFromFat
                                        .toDouble(),
                                    // value: fatp.toDouble(),
                                    title: '',
                                    radius: SizeConfig.screenHeight *
                                        0.06125, // Adjust radius to fit within the container
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        // right: screenWidth * 0,
                        // top: 0,
                        left: SizeConfig.screenWidth * 0.2 -
                            SizeConfig.screenHeight * 0.06125,
                        child: SizedBox(
                          height: SizeConfig.screenHeight * 0.1225,
                          width: SizeConfig.screenHeight * 0.1225,
                          child: Center(
                            child: Container(
                              // Set the overall size of the container to constrain the pie chart
                              height: SizeConfig.screenHeight * 0.1,
                              width: SizeConfig.screenHeight * 0.1,
                              decoration: BoxDecoration(
                                  color: AppThemeColors.secondery2,
                                  // color: primaryColor,
                                  borderRadius: BorderRadius.circular(100)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.food1.value!.totalCalories
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 23,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800,
                                        height: 1.1),
                                  ),
                                  Text(
                                    'Kcal',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        height: 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.025),
              ],
            ),
            Divider(
              height: 5,
              thickness: 2,
              color: AppThemeColors.secondery2,
              indent: SizeConfig.screenWidth * 0.1,
              endIndent: SizeConfig.screenWidth * 0.1,
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 10, bottom: 5),
                  child: Text(
                    controller.food2.value!.name,
                    textAlign: TextAlign.left,
                    // style: TextStyle(
                    // fontWeight: FontWeight.w500,
                    // fontSize: 30,
                    // color: Colors.black),
                    style: AppThemeText().headline1,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total',
                          style: AppThemeText().headline2,
                        ),
                        Text(
                          'Calories',
                          style: AppThemeText().headline2,
                        )
                      ],
                    ),
                    SizedBox(
                      width: 0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.food2.value!.totalCalories.toString(),
                          style: AppThemeText().headline2,
                        ),
                        Text(
                          'Kcal',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppThemeColors.onPrimary1,
                              height: 1),
                        ),
                        Text(
                          // quantity,
                          controller.food2.value!.quantity,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: AppThemeColors.onPrimary1,
                              height: 1),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.025),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.1225,
                  width: SizeConfig.screenWidth,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        child: Container(
                          width: SizeConfig.screenWidth * 0.8,
                          height: SizeConfig.screenHeight * 0.1225,
                          // height: 100,
                          // color: onSecondaryColor,
                          decoration: BoxDecoration(
                              gradient: AppThemeColors.secondaryGradient1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(),
                                  Text(
                                    'Carbs',
                                    style: TextStyle(
                                        color: AppThemeColors.graph1,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    'Protien',
                                    style: TextStyle(
                                        // color: Color(0xffFFD700),
                                        color: AppThemeColors.graph2,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    'Fat',
                                    style: TextStyle(
                                        color: AppThemeColors.graph3,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                                  SizedBox(),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(),
                                  Text(
                                    // '$carbsW g',
                                    '${controller.food2.value!.carbs} g',
                                    style: TextStyle(
                                        color: AppThemeColors.graph1,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    // '$protienW g',
                                    '${controller.food2.value!.protein} g',
                                    style: TextStyle(
                                        color: AppThemeColors.graph2,
                                        // color: Color(0xffFFD700),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    '${controller.food2.value!.fat} g',
                                    // '$fatW g',
                                    style: TextStyle(
                                        color: AppThemeColors.graph3,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  SizedBox(),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(),
                                  Text(
                                    '${controller.food2.value!.percentageCaloriesFromCarbs} %',
                                    // '$carbsp %',
                                    style: TextStyle(
                                        color: AppThemeColors.graph1,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    '${controller.food2.value!.percentageCaloriesFromProtein} %',
                                    // '$protienp %',
                                    style: TextStyle(
                                        color: AppThemeColors.graph2,
                                        // color: Color(0xffFFD700),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    '${controller.food2.value!.percentageCaloriesFromFat} %',
                                    // '$fatp %',
                                    style: TextStyle(
                                        color: AppThemeColors.graph3,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  SizedBox(),
                                ],
                              ),
                              SizedBox(),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        // right: screenWidth * 0,
                        // top: 0,
                        // left: 0,
                        right: 0,
                        child: Center(
                          child: SizedBox(
                            // Set the overall size of the container to constrain the pie chart
                            height: SizeConfig.screenHeight * 0.1225,

                            width: SizeConfig.screenWidth *
                                0.4, // Set the desired width
                            child: PieChart(
                              PieChartData(
                                sectionsSpace: 0, // No space between sections
                                centerSpaceRadius: 0, // No space in the center
                                sections: [
                                  PieChartSectionData(
                                    color: AppThemeColors.graph1,
                                    // value: carbsp.toDouble(),
                                    value: controller.food2.value!
                                        .percentageCaloriesFromCarbs
                                        .toDouble(),
                                    // Remove text by setting an empty string for the title
                                    title: '',
                                    radius: SizeConfig.screenHeight *
                                        0.06125, // Adjust radius to fit within the container
                                  ),
                                  PieChartSectionData(
                                    // color: Color(0xffFFD700),
                                    color: AppThemeColors.graph2,
                                    value: controller.food2.value!
                                        .percentageCaloriesFromProtein
                                        .toDouble(),
                                    // value: protienp.toDouble(),
                                    title: '',
                                    radius: SizeConfig.screenHeight *
                                        0.06125, // Adjust radius to fit within the container
                                  ),
                                  PieChartSectionData(
                                    color: AppThemeColors.graph3,
                                    value: controller
                                        .food2.value!.percentageCaloriesFromFat
                                        .toDouble(),
                                    // value: fatp.toDouble(),
                                    title: '',
                                    radius: SizeConfig.screenHeight *
                                        0.06125, // Adjust radius to fit within the container
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        // right: screenWidth * 0,
                        // top: 0,
                        right: SizeConfig.screenWidth * 0.2 -
                            SizeConfig.screenHeight * 0.06125,
                        // left: SizeConfig.screenWidth * 0.2 -
                        //     SizeConfig.screenHeight * 0.06125,
                        child: SizedBox(
                          height: SizeConfig.screenHeight * 0.1225,
                          width: SizeConfig.screenHeight * 0.1225,
                          child: Center(
                            child: Container(
                              // Set the overall size of the container to constrain the pie chart
                              height: SizeConfig.screenHeight * 0.1,
                              width: SizeConfig.screenHeight * 0.1,
                              decoration: BoxDecoration(
                                  color: AppThemeColors.secondery2,
                                  // color: primaryColor,
                                  borderRadius: BorderRadius.circular(100)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.food2.value!.totalCalories
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 23,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800,
                                        height: 1.1),
                                  ),
                                  Text(
                                    'Kcal',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        height: 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.025),
              ],
            ),
            Divider(
              height: 5,
              thickness: 0,
              color: Colors.transparent,
              // color: AppThemeColors.secondery2,
              indent: SizeConfig.screenWidth * 0.1,
              endIndent: SizeConfig.screenWidth * 0.1,
            ),
            Expanded(
              child: Container(
                width: screenWidth,
                padding: EdgeInsets.fromLTRB(15, 15, 5, 15),
                decoration: BoxDecoration(
                  gradient: AppThemeColors.secondaryGradient1,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description:',
                      style: AppThemeText().headline2,
                    ),
                    SizedBox(height: 15),
                    // Add a Scrollbar with padding to push it to the right
                    Expanded(
                      child: Scrollbar(
                        thumbVisibility:
                            true, // Makes the scrollbar thumb always visible
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right:
                                  10.0), // Adds space between scrollbar and text
                          child: SingleChildScrollView(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),

                              padding: EdgeInsets.all(8),
                              // color: AppThemeColors.primarycolor,
                              child: Text(
                                '${controller.description}',
                                textAlign: TextAlign.justify,
                                // Long text
                                style: AppThemeText().bodyText1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}





   //    Column(
    //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       verticalSpace(size.height * 0.15),
    //       Text(
    //         controller.food1.value!.name,
    //         style: TextStyle(fontSize: size.height * 0.15),
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(
    //             "  Total Calories",
    //             style:
    //                 TextStyle(color: Colors.red, fontSize: size.height * 0.15),
    //           ),
    //           Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             mainAxisAlignment: MainAxisAlignment.spaceAround,
    //             children: [
    //               Text(
    //                 controller.food1.value!.totalCalories.toString(),
    //                 style: TextStyle(
    //                     color: Colors.red,
    //                     fontSize: size.height * 0.1,
    //                     fontWeight: FontWeight.w900),
    //               ),
    //               Text(
    //                 "Kcal",
    //                 style: TextStyle(
    //                     color: Colors.red, fontSize: size.height * 0.08),
    //               ),
    //               Text(
    //                 controller.food1.value!.quantity,
    //                 style: TextStyle(
    //                     color: Colors.red, fontSize: size.height * 0.075),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //       verticalSpace(size.height * 0.05),
    //       SizedBox(
    //         height: screenHeight * 0.12,
    //         // width: screenWidth * 1,
    //         child: Stack(
    //           children: [
    //             Positioned(
    //               right: -25,
    //               child: Container(
    //                 width: screenWidth * 0.9,
    //                 height: screenHeight * 0.1,
    //                 color: onSecondaryColor,
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                   children: [
    //                     Column(
    //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           'Carbs',
    //                           style: TextStyle(
    //                               color: AppThemeColors.graph1,
    //                               fontWeight: FontWeight.w700,
    //                               fontSize: size.height * 0.08),
    //                         ),
    //                         Text(
    //                           'Protein',
    //                           style: TextStyle(
    //                               color: AppThemeColors.graph2,
    //                               fontWeight: FontWeight.w700,
    //                               fontSize: size.height * 0.08),
    //                         ),
    //                         Text(
    //                           'Fat',
    //                           style: TextStyle(
    //                               color: AppThemeColors.graph3,
    //                               fontWeight: FontWeight.w700,
    //                               fontSize: size.height * 0.08),
    //                         ),
    //                       ],
    //                     ),
    //                     Column(
    //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           // '${ResponseScreenController().foodData.value!.item.carbs} g',
    //                           "${controller.food1.value!.carbs} g",
    //                           style: TextStyle(
    //                               color: AppThemeColors.graph1,
    //                               fontWeight: FontWeight.w500,
    //                               fontSize: size.height * 0.08),
    //                         ),
    //                         Text(
    //                           // '${ResponseScreenController().foodData.value!.item.protein} g',
    //                           "${controller.food1.value!.protein} g",
    //                           style: TextStyle(
    //                               color: AppThemeColors.graph2,
    //                               fontWeight: FontWeight.w500,
    //                               fontSize: size.height * 0.08),
    //                         ),
    //                         Text(
    //                           // '${ResponseScreenController().foodData.value!.item.fat} g',
    //                           "${controller.food1.value!.fat} g",
    //                           style: TextStyle(
    //                               color: AppThemeColors.graph3,
    //                               fontWeight: FontWeight.w500,
    //                               fontSize: size.height * 0.08),
    //                         ),
    //                       ],
    //                     ),
    //                     Column(
    //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           // '${ResponseScreenController().foodData.value!.item.percentageCaloriesFromCarbs} %',
    //                           "${controller.food1.value!.percentageCaloriesFromCarbs} %",
    //                           style: TextStyle(
    //                               color: AppThemeColors.graph1,
    //                               fontWeight: FontWeight.w500,
    //                               fontSize: size.height * 0.08),
    //                         ),
    //                         Text(
    //                           // '${ResponseScreenController().foodData.value!.item.percentageCaloriesFromProtein} %',
    //                           "${controller.food1.value!.percentageCaloriesFromProtein} %",
    //                           style: TextStyle(
    //                               color: AppThemeColors.graph2,
    //                               fontWeight: FontWeight.w500,
    //                               fontSize: size.height * 0.08),
    //                         ),
    //                         Text(
    //                           // '${ResponseScreenController().foodData.value!.item.percentageCaloriesFromFat} %',
    //                           "${controller.food1.value!.percentageCaloriesFromFat} %",
    //                           style: TextStyle(
    //                               color: AppThemeColors.graph3,
    //                               fontWeight: FontWeight.w500,
    //                               fontSize: size.height * 0.08),
    //                         ),
    //                       ],
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             Positioned(
    //               left: 10,
    //               child: Container(
    //                 height: screenHeight * 0.1,
    //                 width: screenHeight * 0.1,
    //                 decoration: BoxDecoration(
    //                     color: secondaryColor,
    //                     borderRadius: BorderRadius.circular(100)),
    //                 child: Center(
    //                   child: Container(
    //                     height: screenHeight * 0.08,
    //                     width: screenHeight * 0.08,
    //                     decoration: BoxDecoration(
    //                         color: primaryColor,
    //                         borderRadius: BorderRadius.circular(100)),
    //                     child: Center(
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.center,
    //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                         children: [
    //                           Text(
    //                             // // ResponseScreenController().foodData.value!.item.totalCalories
    //                             //     .toString(),
    //                             "272",
    //                             style: TextStyle(
    //                               fontSize: size.height * 0.08,
    //                               color: onPrimaryColor,
    //                               fontWeight: FontWeight.w800,
    //                             ),
    //                           ),
    //                           Text(
    //                             // // ResponseScreenController().foodData.value!.item.totalCalories
    //                             //     .toString(),
    //                             "kcal",
    //                             style: TextStyle(
    //                               fontSize: size.height * 0.08,
    //                               color: onPrimaryColor,
    //                               fontWeight: FontWeight.w800,
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       Container(
    //           height: size.height * 1.2,
    //           width: size.width * 2,
    //           color: tertoryColor,
    //           child: Column(
    //               // mainAxisAlignment: MainAxisAlignment.start,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(
    //                   "  A Piece of cake",
    //                   style: TextStyle(fontSize: size.height * 0.15),
    //                 ),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       "  Toral Calories",
    //                       style: TextStyle(
    //                           color: Colors.red, fontSize: size.height * 0.15),
    //                     ),
    //                     Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                       children: [
    //                         Text(
    //                           "271",
    //                           style: TextStyle(
    //                               color: Colors.red,
    //                               fontSize: size.height * 0.1,
    //                               fontWeight: FontWeight.w900),
    //                         ),
    //                         Text(
    //                           "Kcal",
    //                           style: TextStyle(
    //                               color: Colors.red,
    //                               fontSize: size.height * 0.08),
    //                         ),
    //                         Text(
    //                           "in 1 cake o.5 kg",
    //                           style: TextStyle(
    //                               color: Colors.red,
    //                               fontSize: size.height * 0.075),
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //                 verticalSpace(size.height * 0.05),
    //                 SizedBox(
    //                   height: screenHeight * 0.12,
    //                   // width: screenWidth * 1,
    //                   child: Stack(
    //                     children: [
    //                       Positioned(
    //                         right: 90,
    //                         child: Container(
    //                           width: screenWidth * 0.8,
    //                           height: screenHeight * 0.1,
    //                           color: onSecondaryColor,
    //                           child: Row(
    //                             mainAxisAlignment:
    //                                 MainAxisAlignment.spaceEvenly,
    //                             children: [
    //                               Column(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceEvenly,
    //                                 crossAxisAlignment:
    //                                     CrossAxisAlignment.start,
    //                                 children: [
    //                                   Text(
    //                                     'Carbs',
    //                                     style: TextStyle(
    //                                         color: AppThemeColors.graph1,
    //                                         fontWeight: FontWeight.w700,
    //                                         fontSize: size.height * 0.08),
    //                                   ),
    //                                   Text(
    //                                     'Protein',
    //                                     style: TextStyle(
    //                                         color: AppThemeColors.graph2,
    //                                         fontWeight: FontWeight.w700,
    //                                         fontSize: size.height * 0.08),
    //                                   ),
    //                                   Text(
    //                                     'Fat',
    //                                     style: TextStyle(
    //                                         color: AppThemeColors.graph3,
    //                                         fontWeight: FontWeight.w700,
    //                                         fontSize: size.height * 0.08),
    //                                   ),
    //                                 ],
    //                               ),
    //                               Column(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceEvenly,
    //                                 crossAxisAlignment:
    //                                     CrossAxisAlignment.start,
    //                                 children: [
    //                                   Text(
    //                                     // '${ResponseScreenController().foodData.value!.item.carbs} g',
    //                                     "35 g",
    //                                     style: TextStyle(
    //                                         color: AppThemeColors.graph1,
    //                                         fontWeight: FontWeight.w500,
    //                                         fontSize: size.height * 0.08),
    //                                   ),
    //                                   Text(
    //                                     // '${ResponseScreenController().foodData.value!.item.protein} g',
    //                                     "45 g",
    //                                     style: TextStyle(
    //                                         color: AppThemeColors.graph2,
    //                                         fontWeight: FontWeight.w500,
    //                                         fontSize: size.height * 0.08),
    //                                   ),
    //                                   Text(
    //                                     // '${ResponseScreenController().foodData.value!.item.fat} g',
    //                                     "110 g",
    //                                     style: TextStyle(
    //                                         color: AppThemeColors.graph3,
    //                                         fontWeight: FontWeight.w500,
    //                                         fontSize: size.height * 0.08),
    //                                   ),
    //                                 ],
    //                               ),
    //                               Column(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceEvenly,
    //                                 crossAxisAlignment:
    //                                     CrossAxisAlignment.start,
    //                                 children: [
    //                                   Text(
    //                                     // '${ResponseScreenController().foodData.value!.item.percentageCaloriesFromCarbs} %',
    //                                     "10 %",
    //                                     style: TextStyle(
    //                                         color: AppThemeColors.graph1,
    //                                         fontWeight: FontWeight.w500,
    //                                         fontSize: size.height * 0.08),
    //                                   ),
    //                                   Text(
    //                                     // '${ResponseScreenController().foodData.value!.item.percentageCaloriesFromProtein} %',
    //                                     "23 %",
    //                                     style: TextStyle(
    //                                         color: AppThemeColors.graph2,
    //                                         fontWeight: FontWeight.w500,
    //                                         fontSize: size.height * 0.08),
    //                                   ),
    //                                   Text(
    //                                     // '${ResponseScreenController().foodData.value!.item.percentageCaloriesFromFat} %',
    //                                     "42 %",
    //                                     style: TextStyle(
    //                                         color: AppThemeColors.graph3,
    //                                         fontWeight: FontWeight.w500,
    //                                         fontSize: size.height * 0.08),
    //                                   ),
    //                                 ],
    //                               )
    //                             ],
    //                           ),
    //                         ),
    //                       ),
    //                       Positioned(
    //                         left: 225,
    //                         child: Container(
    //                           height: screenHeight * 0.1,
    //                           width: screenHeight * 0.1,
    //                           decoration: BoxDecoration(
    //                               color: secondaryColor,
    //                               borderRadius: BorderRadius.circular(100)),
    //                           child: Center(
    //                             child: Container(
    //                               height: screenHeight * 0.08,
    //                               width: screenHeight * 0.08,
    //                               decoration: BoxDecoration(
    //                                   color: primaryColor,
    //                                   borderRadius: BorderRadius.circular(100)),
    //                               child: Center(
    //                                 child: Column(
    //                                   crossAxisAlignment:
    //                                       CrossAxisAlignment.center,
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.spaceEvenly,
    //                                   children: [
    //                                     Text(
    //                                       // // ResponseScreenController().foodData.value!.item.totalCalories
    //                                       //     .toString(),
    //                                       "272",
    //                                       style: TextStyle(
    //                                         fontSize: size.height * 0.08,
    //                                         color: onPrimaryColor,
    //                                         fontWeight: FontWeight.w800,
    //                                       ),
    //                                     ),
    //                                     Text(
    //                                       // // ResponseScreenController().foodData.value!.item.totalCalories
    //                                       //     .toString(),
    //                                       "kcal",
    //                                       style: TextStyle(
    //                                         fontSize: size.height * 0.08,
    //                                         color: onPrimaryColor,
    //                                         fontWeight: FontWeight.w800,
    //                                       ),
    //                                     ),
    //                                   ],
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ])),
    //       // verticalSpace(size.height * 0.15),
    //       SizedBox(
    //         child: Container(
    //           height: size.height * 1.27,
    //           width: size.width * 1.12,
    //           color: const Color.fromARGB(255, 248, 131, 229),
    //           child: Text(
    //             "If you want textIf  you want textIf you want textIf you want textIf you want textIf you want text",
    //             style: TextStyle(
    //                 fontSize: size.height * 0.15, color: onPrimaryColor),
    //             textAlign: TextAlign.center,
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
 

