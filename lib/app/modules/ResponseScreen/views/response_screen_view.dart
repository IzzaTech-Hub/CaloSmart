import 'package:calories_detector/app/modules/home/controllers/home_controller.dart';
import 'package:calories_detector/app/modules/navbar/controllers/navbar_controller.dart';
import 'package:calories_detector/app/modules/utills/Themes/current_theme.dart';
import 'package:calories_detector/app/premium/premium.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:calories_detector/sizeConfig.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:shimmer/shimmer.dart';
import '../controllers/response_screen_controller.dart';
import '../../../routes/app_pages.dart';
// import 'package:shimmer/shimmer.dart';

class ResponseScreenView extends GetView<ResponseScreenController> {
  const ResponseScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: appThemeAppBar2(context, 'Response')),
      body: Container(
        decoration: BoxDecoration(gradient: AppThemeColors.bgGradient),
        child: Column(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              height: SizeConfig.screenWidth * 0.65,
              // height: screenHeight * 0.286,
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                  gradient: AppThemeColors.primaryGradient1,
                  borderRadius: BorderRadius.only(
                      bottomLeft:
                          Radius.circular(SizeConfig.blockSizeHorizontal * 5),
                      bottomRight:
                          Radius.circular(SizeConfig.blockSizeHorizontal * 5))),
              // bottomLeft: Radius.circular(
              //     SizeConfig.blockSizeHorizontal * 5),
              // bottomRight: Radius.circular(
              //     SizeConfig.blockSizeHorizontal * 5))),
              child: FittedBox(
                fit: BoxFit.cover,
                // child: controller.imageFile.value,
                child: Image.memory(controller.imageFile2.value!),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 1,
                          left: SizeConfig.blockSizeHorizontal * 5,
                          bottom: SizeConfig.blockSizeVertical * 1),
                      width: SizeConfig.blockSizeHorizontal * 95,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(controller.foodData.value!.item.name,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 6,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff2ECC71)),
                                // AppThemeText().headline1,
                              )

                              // TextStyle(
                              //     fontWeight: FontWeight.w500,
                              //     fontSize: 30,
                              //     color: Colors.black),
                              ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 20),
                                // width: 100,
                                // height: SizeConfig.blockSizeHorizontal * 6,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: controller.foodData.value!.item
                                                  .healthScore >
                                              0
                                          ? Colors.amber
                                          : Colors.black26,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: controller.foodData.value!.item
                                                  .healthScore >
                                              1
                                          ? Colors.amber
                                          : Colors.black26,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: controller.foodData.value!.item
                                                  .healthScore >
                                              2
                                          ? Colors.amber
                                          : Colors.black26,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: controller.foodData.value!.item
                                                  .healthScore >
                                              3
                                          ? Colors.amber
                                          : Colors.black26,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: controller.foodData.value!.item
                                                  .healthScore >
                                              4
                                          ? Colors.amber
                                          : Colors.black26,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: GestureDetector(
                                  onTap: () {
                                    // if (!Premium
                                    //     .instance.isPremium!.value) {
                                    //   showDialog(
                                    //     context: context,
                                    //     builder: (BuildContext context) {
                                    //       return FoodDetailsDialog(
                                    //           foodData: controller.foodData.value!);
                                    //     },
                                    //   );
                                    // } else {
                                    //   Get.toNamed(Routes.PAYWALL);
                                    // }
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return FoodDetailsDialog(
                                            foodData:
                                                controller.foodData.value!);
                                      },
                                    );
                                  },
                                  child: Text(
                                    'view more',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.transparent,
                                      // height: 1,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.deepPurple,
                                      decorationThickness: 1.5,
                                      shadows: [
                                        Shadow(
                                          color: Colors.deepPurple,
                                          offset: Offset(0,
                                              -1), // Pushes the underline lower
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.005),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total',
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 5,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo),
                                )),
                            Text('Calories',
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 5,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo),
                                )),
                          ],
                        ),
                        SizedBox(),
                        SizedBox(),
                        SizedBox(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                controller.foodData.value!.item.totalCalories
                                    .toString(),
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      // height: 1,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                )),
                            Text('Kcal',
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      // height: 1,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo),
                                )),
                          ],
                        ),
                        SizedBox(),
                      ],
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.015),
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
                              decoration: BoxDecoration(
                                  // border: Border.symmetric(
                                  //     horizontal: BorderSide(
                                  //         color: AppThemeColors.secondery2, width: 1)),
                                  // color: AppThemeColors.secondery1,
                                  gradient: AppThemeColors.secondaryGradient1),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(),
                                      Text('Carbs',
                                          style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    3.5,
                                                fontWeight: FontWeight.bold,
                                                color: AppThemeColors.graph1),
                                          )),
                                      //   TextStyle(
                                      //       color: AppThemeColors.graph1,
                                      //       fontWeight: FontWeight.w700,
                                      //       fontSize: 16),
                                      // ),
                                      Text('Protien',
                                          style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3.5,
                                              fontWeight: FontWeight.bold,
                                              color: AppThemeColors.graph2,
                                            ),
                                          )),
                                      //    TextStyle(
                                      //       // color: Color(0xffFFD700),
                                      //       color: AppThemeColors.graph2,
                                      //       fontWeight: FontWeight.w700,
                                      //       fontSize: 16),
                                      // ),
                                      Text('Fat',
                                          style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3.5,
                                              fontWeight: FontWeight.bold,
                                              color: AppThemeColors.graph3,
                                            ),
                                          )),
                                      //   TextStyle(
                                      //       color: AppThemeColors.graph3,
                                      //       fontWeight: FontWeight.w700,
                                      //       fontSize: 16),
                                      // ),
                                      SizedBox(),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(),
                                      Text(
                                          // '$carbsW g',
                                          '${controller.foodData.value!.item.carbs} g',
                                          style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3.5,
                                              fontWeight: FontWeight.bold,
                                              color: AppThemeColors.graph1,
                                            ),
                                          )),
                                      //    TextStyle(
                                      //       color: AppThemeColors.graph1,
                                      //       fontWeight: FontWeight.w500,
                                      //       fontSize: 16),
                                      // ),
                                      Text(
                                          // '$protienW g',
                                          '${controller.foodData.value!.item.protein} g',
                                          style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3.5,
                                              fontWeight: FontWeight.bold,
                                              color: AppThemeColors.graph2,
                                            ),
                                          )
                                          // TextStyle(
                                          //     color: AppThemeColors.graph2,
                                          //     // color: Color(0xffFFD700),
                                          //     fontWeight: FontWeight.w500,
                                          //     fontSize: 16),
                                          ),
                                      Text(
                                          '${controller.foodData.value!.item.fat} g',
                                          // '$fatW g',
                                          style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3.5,
                                              fontWeight: FontWeight.bold,
                                              color: AppThemeColors.graph3,
                                            ),
                                          )

                                          // TextStyle(
                                          //     color: AppThemeColors.graph3,
                                          //     fontWeight: FontWeight.w500,
                                          //     fontSize: 16),
                                          ),
                                      SizedBox(),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(),
                                      Text(
                                          '${controller.foodData.value!.item.percentageCaloriesFromCarbs} %',
                                          // '$carbsp %',
                                          style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3.5,
                                              fontWeight: FontWeight.bold,
                                              color: AppThemeColors.graph1,
                                            ),
                                          )
                                          // TextStyle(
                                          //     color: AppThemeColors.graph1,
                                          //     fontWeight: FontWeight.w500,
                                          //     fontSize: 16),
                                          ),
                                      Text(
                                          '${controller.foodData.value!.item.percentageCaloriesFromProtein} %',
                                          // '$protienp %',
                                          style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3.5,
                                              fontWeight: FontWeight.bold,
                                              color: AppThemeColors.graph2,
                                            ),
                                          )
                                          //  TextStyle(
                                          //     color: AppThemeColors.graph2,
                                          //     // color: Color(0xffFFD700),
                                          //     fontWeight: FontWeight.w500,
                                          //     fontSize: 16),
                                          ),
                                      Text(
                                          '${controller.foodData.value!.item.percentageCaloriesFromFat} %',
                                          // '$fatp %',
                                          style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3.5,
                                              fontWeight: FontWeight.bold,
                                              color: AppThemeColors.graph3,
                                            ),
                                          )
                                          // TextStyle(
                                          //     color: AppThemeColors.graph3,
                                          //     fontWeight: FontWeight.w500,
                                          //     fontSize: 16),
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
                                    sectionsSpace:
                                        0, // No space between sections
                                    centerSpaceRadius: 0,
                                    // No space in the center

                                    sections: [
                                      PieChartSectionData(
                                        // color: AppThemeColors.graph1,
                                        gradient: LinearGradient(
                                            colors: [
                                              Colors.indigo.shade300,
                                              Colors.indigo
                                            ],
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft),
                                        // value: carbsp.toDouble(),
                                        value: controller.foodData.value!.item
                                            .percentageCaloriesFromCarbs
                                            .toDouble(),
                                        // Remove text by setting an empty string for the title
                                        title: '',
                                        radius: SizeConfig.screenHeight *
                                            0.06125, // Adjust radius to fit within the container
                                      ),
                                      PieChartSectionData(
                                        // color: Color(0xffFFD700),
                                        // color: AppThemeColors.graph2,
                                        gradient: LinearGradient(
                                            colors: [
                                              Colors.green.shade300,
                                              Colors.green
                                            ],
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft),
                                        value: controller.foodData.value!.item
                                            .percentageCaloriesFromProtein
                                            .toDouble(),
                                        // value: protienp.toDouble(),
                                        title: '',
                                        radius: SizeConfig.screenHeight *
                                            0.06125, // Adjust radius to fit within the container
                                      ),
                                      PieChartSectionData(
                                        // color: AppThemeColors.graph3,
                                        gradient: LinearGradient(
                                            colors: [
                                              Colors.red.shade200,
                                              Colors.red.shade700
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight),
                                        value: controller.foodData.value!.item
                                            .percentageCaloriesFromFat
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
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          controller.foodData.value!.item
                                              .totalCalories
                                              .toString(),
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    6,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                height: 1.11),
                                          )
                                          // TextStyle(
                                          //     fontSize: 23,
                                          //     color: Colors.black,
                                          //     fontWeight: FontWeight.w800,
                                          //     height: 1.1),
                                          ),
                                      Text('Kcal',
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    2.5,
                                                color: Colors.grey,
                                                height: 1.11),
                                          )
                                          // TextStyle(
                                          //     fontSize: 18,
                                          //     color: Colors.black,
                                          //     fontWeight: FontWeight.w400,
                                          //     height: 1),
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
                                gradient: AppThemeColors.secondaryGradient2,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(15, 8, 0, 8),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('After Consuming this:',
                                        style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  4,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green.shade800),
                                        )
                                        //  TextStyle(
                                        //     height: 1,
                                        //     fontSize: 18,
                                        //     fontWeight: FontWeight.w700
                                        //     ),
                                        ),
                                    SizedBox(),
                                    // List of bullet points
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(width: 10),
                                          Icon(Icons.circle, size: 8),
                                          Text(
                                              // '  $waterQ',
                                              '  Drink ${controller.foodData.value!.item.waterQuantity} ltr(s) of water',
                                              style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    color: Colors.black),
                                              )
                                              // TextStyle(height: 0),
                                              ),
                                        ]),
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(width: 10),
                                          Icon(Icons.circle, size: 8),
                                          Text(
                                              // '  $exerciseQ',
                                              '  Exercise for ${controller.foodData.value!.item.exercise} hour(s)',
                                              style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    color: Colors.black),
                                              )
                                              // TextStyle(height: 0),
                                              ),
                                        ]),
                                    SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            // right: screenWidth * 0,
                            // top: 0,
                            right: SizeConfig.screenWidth * 0.2 -
                                SizeConfig.screenHeight * 0.06125,
                            child: Container(
                              height: SizeConfig.screenHeight * 0.1225,
                              width: SizeConfig.screenHeight * 0.1225,
                              decoration: BoxDecoration(
                                  color: AppThemeColors.onPrimary1,
                                  borderRadius: BorderRadius.circular(100)),
                              child: Center(
                                child: Container(
                                  // Set the overall size of the container to constrain the pie chart
                                  height: SizeConfig.screenHeight * 0.1,
                                  width: SizeConfig.screenHeight * 0.1,
                                  decoration: BoxDecoration(
                                      color: AppThemeColors.secondery2,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Center(
                                      child: Text('Tips',
                                          style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    6,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          )
                                          // TextStyle(
                                          //     color: Colors.black,
                                          //     fontSize: 25,
                                          //     fontWeight: FontWeight.w600),
                                          )),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.025),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AppThemeButton(
                                onPressed: () {
                                  if (!(Premium.instance.isPremium.value)) {
                                    Get.toNamed(Routes.PAYWALL);
                                  } else {
                                    if (Premium.instance.apple!.value >=
                                        PremiumTheme.comparisonPrice) {
                                      controller.Comparefunction(context);
                                    } else {
                                      Get.toNamed(Routes.STREAK);
                                    }
                                  }
                                },
                                text: 'Compare')
                            .smallButtonwithprice(PremiumTheme.comparisonPrice),
                        AppThemeButton(
                                onPressed: () {
                                  if (!(Premium.instance.isPremium.value)) {
                                    Get.toNamed(Routes.PAYWALL);
                                  } else {
                                    if (Premium.instance.apple!.value >=
                                        PremiumTheme.alternatePrice) {
                                      // Premium.instance
                                      //     .reduce1(PremiumTheme.alternatePrice);
                                      // Get.toNamed(Routes.COMPARISON_VIEW_SCREEN,
                                      //     arguments: [
                                      //       controller.foodData.value!.item,
                                      //       controller.foodData.value!.alternate1,
                                      //       'Alternate',
                                      //       controller
                                      //           .foodData.value!.description,
                                      //     ]);
                                      controller.Alternatefunction();
                                    } else {
                                      Get.toNamed(Routes.STREAK);
                                    }
                                  }
                                },
                                text: 'Alternative')
                            .smallButtonwithprice(PremiumTheme.alternatePrice),
                      ],
                    ),
                    SizedBox(height: SizeConfig.screenWidth * 0.03),
                    Center(
                      child: AppThemeButton(
                              onPressed: () {
                                controller.logFeed(controller.foodData.value!);
                              },
                              text: 'Log Food')
                          .largeButton(),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class ResponseScreenView extends GetView<ResponseScreenController> {
//   const ResponseScreenView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // double screenHeight = MediaQuery.of(context).size.height;
//     // double screenWidth = MediaQuery.of(context).size.width;

//     return Obx(() {
//       if (!(isrespnse.value)) {
//         return Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // SizedBox(height: SizeConfig.screenHeight * 0.2),
//               Text('Please analyze an image first'),
//               SizedBox(height: SizeConfig.screenHeight * 0.06),
//               AppThemeButton(
//                       onPressed: () {
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return Dialog(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(
//                                     15), // Rounded corners
//                               ),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   // gradient: LinearGradient(
//                                   //   colors: [Colors.lightBlueAccent, Colors.blueAccent],
//                                   //   begin: Alignment.topLeft,
//                                   //   end: Alignment.bottomRight,
//                                   // ),
//                                   gradient: AppThemeColors.buttonColor,
//                                   borderRadius: BorderRadius.circular(
//                                       15), // Keep gradient rounded
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(20.0),
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Text(
//                                         'Compare Your Item',
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                           fontSize: 22,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors
//                                               .white, // Make title stand out on gradient
//                                         ),
//                                       ),
//                                       SizedBox(height: 15),
//                                       Text(
//                                         'Would you like to select an item from your gallery or take a new picture?',
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                           fontSize: 15,
//                                           color: Colors.black,
//                                           // color: Colors.white,
//                                         ),
//                                       ),
//                                       SizedBox(height: 25),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceEvenly,
//                                         children: [
//                                           ElevatedButton.icon(
//                                             onPressed: () {
//                                               Navigator.of(context).pop();
//                                               NavbarController()
//                                                   .pickImageFromGallery();
//                                             },
//                                             style: ElevatedButton.styleFrom(
//                                               backgroundColor:
//                                                   // Colors.green, // Gallery button background
//                                                   Colors.white,
//                                               padding: EdgeInsets.symmetric(
//                                                   vertical: 12, horizontal: 20),
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                               ),
//                                             ),
//                                             icon: Icon(Icons.photo,
//                                                 color:
//                                                     AppThemeColors.onPrimary1),
//                                             label: Text('Gallery',
//                                                 style: TextStyle(
//                                                     color: Colors.black)),
//                                           ),
//                                           SizedBox(),
//                                           ElevatedButton.icon(
//                                             onPressed: () {
//                                               Navigator.of(context).pop();
//                                               // pickImageFromCamera();
//                                               Get.toNamed(Routes.CAMERA_SCREEN);
//                                             },
//                                             style: ElevatedButton.styleFrom(
//                                               backgroundColor: Colors
//                                                   .white, // Camera button background
//                                               padding: EdgeInsets.symmetric(
//                                                   vertical: 12, horizontal: 20),
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                               ),
//                                             ),
//                                             icon: Icon(Icons.camera_alt,
//                                                 color:
//                                                     AppThemeColors.onPrimary1),
//                                             label: Text('Camera',
//                                                 style: TextStyle(
//                                                     color: Colors.black)),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         );
//                       },
//                       text: 'Click to start')
//                   .smallButton(),
//             ],
//           ),
//         );
//       }
//       // else {
//       //   print(isrespnse.value);
//       //   return Container();
//       // }
//       else {
//         return Obx(
//           () => Container(
//             decoration: BoxDecoration(gradient: AppThemeColors.bgGradient),
//             child: Column(
//               children: [
//                 Container(
//                   clipBehavior: Clip.hardEdge,
//                   height: SizeConfig.screenWidth * 0.65,
//                   // height: screenHeight * 0.286,
//                   width: SizeConfig.screenWidth,
//                   decoration: BoxDecoration(
//                       gradient: AppThemeColors.primaryGradient1,
//                       borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(
//                               SizeConfig.blockSizeHorizontal * 5),
//                           bottomRight: Radius.circular(
//                               SizeConfig.blockSizeHorizontal * 5))),
//                   // bottomLeft: Radius.circular(
//                   //     SizeConfig.blockSizeHorizontal * 5),
//                   // bottomRight: Radius.circular(
//                   //     SizeConfig.blockSizeHorizontal * 5))),
//                   child: FittedBox(
//                     fit: BoxFit.cover,
//                     // child: controller.imageFile.value,
//                     child: Image.memory(imageFile2!),
//                   ),
//                 ),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           margin: EdgeInsets.only(
//                               top: SizeConfig.blockSizeVertical * 1,
//                               left: SizeConfig.blockSizeHorizontal * 5,
//                               bottom: SizeConfig.blockSizeVertical * 1),
//                           width: SizeConfig.blockSizeHorizontal * 95,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(controller.foodData.value!.item.name,
//                                   textAlign: TextAlign.left,
//                                   style: GoogleFonts.poppins(
//                                     textStyle: TextStyle(
//                                         fontSize:
//                                             SizeConfig.blockSizeHorizontal * 6,
//                                         fontWeight: FontWeight.bold,
//                                         color: Color(0xff2ECC71)),
//                                     // AppThemeText().headline1,
//                                   )

//                                   // TextStyle(
//                                   //     fontWeight: FontWeight.w500,
//                                   //     fontSize: 30,
//                                   //     color: Colors.black),
//                                   ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     margin: EdgeInsets.only(right: 20),
//                                     // width: 100,
//                                     // height: SizeConfig.blockSizeHorizontal * 6,
//                                     child: Row(
//                                       children: [
//                                         Icon(
//                                           Icons.star,
//                                           color:
//                                               controller.foodData.value!.item.healthScore >
//                                                       0
//                                                   ? Colors.amber
//                                                   : Colors.black26,
//                                         ),
//                                         Icon(
//                                           Icons.star,
//                                           color:
//                                               controller.foodData.value!.item.healthScore >
//                                                       1
//                                                   ? Colors.amber
//                                                   : Colors.black26,
//                                         ),
//                                         Icon(
//                                           Icons.star,
//                                           color:
//                                               controller.foodData.value!.item.healthScore >
//                                                       2
//                                                   ? Colors.amber
//                                                   : Colors.black26,
//                                         ),
//                                         Icon(
//                                           Icons.star,
//                                           color:
//                                               controller.foodData.value!.item.healthScore >
//                                                       3
//                                                   ? Colors.amber
//                                                   : Colors.black26,
//                                         ),
//                                         Icon(
//                                           Icons.star,
//                                           color:
//                                               controller.foodData.value!.item.healthScore >
//                                                       4
//                                                   ? Colors.amber
//                                                   : Colors.black26,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(right: 30),
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         // if (!Premium
//                                         //     .instance.isPremium!.value) {
//                                         //   showDialog(
//                                         //     context: context,
//                                         //     builder: (BuildContext context) {
//                                         //       return FoodDetailsDialog(
//                                         //           foodData: controller.foodData.value!);
//                                         //     },
//                                         //   );
//                                         // } else {
//                                         //   Get.toNamed(Routes.PAYWALL);
//                                         // }
//                                         showDialog(
//                                           context: context,
//                                           builder: (BuildContext context) {
//                                             return FoodDetailsDialog(
//                                                 foodData: controller.foodData.value!);
//                                           },
//                                         );
//                                       },
//                                       child: Text(
//                                         'view more',
//                                         style: TextStyle(
//                                           fontSize: 12,
//                                           color: Colors.transparent,
//                                           // height: 1,
//                                           decoration: TextDecoration.underline,
//                                           decorationColor: Colors.deepPurple,
//                                           decorationThickness: 1.5,
//                                           shadows: [
//                                             Shadow(
//                                               color: Colors.deepPurple,
//                                               offset: Offset(0,
//                                                   -1), // Pushes the underline lower
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: SizeConfig.screenHeight * 0.005),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             SizedBox(),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text('Total',
//                                     style: GoogleFonts.openSans(
//                                       textStyle: TextStyle(
//                                           fontSize:
//                                               SizeConfig.blockSizeHorizontal *
//                                                   5,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.indigo),
//                                     )),
//                                 Text('Calories',
//                                     style: GoogleFonts.openSans(
//                                       textStyle: TextStyle(
//                                           fontSize:
//                                               SizeConfig.blockSizeHorizontal *
//                                                   5,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.indigo),
//                                     )),
//                               ],
//                             ),
//                             SizedBox(),
//                             SizedBox(),
//                             SizedBox(),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                     controller.foodData.value!.item.totalCalories
//                                         .toString(),
//                                     style: GoogleFonts.openSans(
//                                       textStyle: TextStyle(
//                                           // height: 1,
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black),
//                                     )),
//                                 Text('Kcal',
//                                     style: GoogleFonts.openSans(
//                                       textStyle: TextStyle(
//                                           // height: 1,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.indigo),
//                                     )),
//                               ],
//                             ),
//                             SizedBox(),
//                           ],
//                         ),
//                         SizedBox(height: SizeConfig.screenHeight * 0.015),
//                         SizedBox(
//                           height: SizeConfig.screenHeight * 0.1225,
//                           width: SizeConfig.screenWidth,
//                           child: Stack(
//                             children: [
//                               Positioned(
//                                 right: 0,
//                                 child: Container(
//                                   width: SizeConfig.screenWidth * 0.8,
//                                   height: SizeConfig.screenHeight * 0.1225,
//                                   // height: 100,
//                                   decoration: BoxDecoration(
//                                       // border: Border.symmetric(
//                                       //     horizontal: BorderSide(
//                                       //         color: AppThemeColors.secondery2, width: 1)),
//                                       // color: AppThemeColors.secondery1,
//                                       gradient:
//                                           AppThemeColors.secondaryGradient1),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       SizedBox(),
//                                       Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceEvenly,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           SizedBox(),
//                                           Text('Carbs',
//                                               style: GoogleFonts.openSans(
//                                                 textStyle: TextStyle(
//                                                     fontSize: SizeConfig
//                                                             .blockSizeHorizontal *
//                                                         3.5,
//                                                     fontWeight: FontWeight.bold,
//                                                     color:
//                                                         AppThemeColors.graph1),
//                                               )),
//                                           //   TextStyle(
//                                           //       color: AppThemeColors.graph1,
//                                           //       fontWeight: FontWeight.w700,
//                                           //       fontSize: 16),
//                                           // ),
//                                           Text('Protien',
//                                               style: GoogleFonts.openSans(
//                                                 textStyle: TextStyle(
//                                                   fontSize: SizeConfig
//                                                           .blockSizeHorizontal *
//                                                       3.5,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: AppThemeColors.graph2,
//                                                 ),
//                                               )),
//                                           //    TextStyle(
//                                           //       // color: Color(0xffFFD700),
//                                           //       color: AppThemeColors.graph2,
//                                           //       fontWeight: FontWeight.w700,
//                                           //       fontSize: 16),
//                                           // ),
//                                           Text('Fat',
//                                               style: GoogleFonts.openSans(
//                                                 textStyle: TextStyle(
//                                                   fontSize: SizeConfig
//                                                           .blockSizeHorizontal *
//                                                       3.5,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: AppThemeColors.graph3,
//                                                 ),
//                                               )),
//                                           //   TextStyle(
//                                           //       color: AppThemeColors.graph3,
//                                           //       fontWeight: FontWeight.w700,
//                                           //       fontSize: 16),
//                                           // ),
//                                           SizedBox(),
//                                         ],
//                                       ),
//                                       Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceEvenly,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           SizedBox(),
//                                           Text(
//                                               // '$carbsW g',
//                                               '${controller.foodData.value!.item.carbs} g',
//                                               style: GoogleFonts.openSans(
//                                                 textStyle: TextStyle(
//                                                   fontSize: SizeConfig
//                                                           .blockSizeHorizontal *
//                                                       3.5,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: AppThemeColors.graph1,
//                                                 ),
//                                               )),
//                                           //    TextStyle(
//                                           //       color: AppThemeColors.graph1,
//                                           //       fontWeight: FontWeight.w500,
//                                           //       fontSize: 16),
//                                           // ),
//                                           Text(
//                                               // '$protienW g',
//                                               '${controller.foodData.value!.item.protein} g',
//                                               style: GoogleFonts.openSans(
//                                                 textStyle: TextStyle(
//                                                   fontSize: SizeConfig
//                                                           .blockSizeHorizontal *
//                                                       3.5,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: AppThemeColors.graph2,
//                                                 ),
//                                               )
//                                               // TextStyle(
//                                               //     color: AppThemeColors.graph2,
//                                               //     // color: Color(0xffFFD700),
//                                               //     fontWeight: FontWeight.w500,
//                                               //     fontSize: 16),
//                                               ),
//                                           Text('${controller.foodData.value!.item.fat} g',
//                                               // '$fatW g',
//                                               style: GoogleFonts.openSans(
//                                                 textStyle: TextStyle(
//                                                   fontSize: SizeConfig
//                                                           .blockSizeHorizontal *
//                                                       3.5,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: AppThemeColors.graph3,
//                                                 ),
//                                               )

//                                               // TextStyle(
//                                               //     color: AppThemeColors.graph3,
//                                               //     fontWeight: FontWeight.w500,
//                                               //     fontSize: 16),
//                                               ),
//                                           SizedBox(),
//                                         ],
//                                       ),
//                                       Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceEvenly,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           SizedBox(),
//                                           Text(
//                                               '${controller.foodData.value!.item.percentageCaloriesFromCarbs} %',
//                                               // '$carbsp %',
//                                               style: GoogleFonts.openSans(
//                                                 textStyle: TextStyle(
//                                                   fontSize: SizeConfig
//                                                           .blockSizeHorizontal *
//                                                       3.5,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: AppThemeColors.graph1,
//                                                 ),
//                                               )
//                                               // TextStyle(
//                                               //     color: AppThemeColors.graph1,
//                                               //     fontWeight: FontWeight.w500,
//                                               //     fontSize: 16),
//                                               ),
//                                           Text(
//                                               '${controller.foodData.value!.item.percentageCaloriesFromProtein} %',
//                                               // '$protienp %',
//                                               style: GoogleFonts.openSans(
//                                                 textStyle: TextStyle(
//                                                   fontSize: SizeConfig
//                                                           .blockSizeHorizontal *
//                                                       3.5,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: AppThemeColors.graph2,
//                                                 ),
//                                               )
//                                               //  TextStyle(
//                                               //     color: AppThemeColors.graph2,
//                                               //     // color: Color(0xffFFD700),
//                                               //     fontWeight: FontWeight.w500,
//                                               //     fontSize: 16),
//                                               ),
//                                           Text(
//                                               '${controller.foodData.value!.item.percentageCaloriesFromFat} %',
//                                               // '$fatp %',
//                                               style: GoogleFonts.openSans(
//                                                 textStyle: TextStyle(
//                                                   fontSize: SizeConfig
//                                                           .blockSizeHorizontal *
//                                                       3.5,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: AppThemeColors.graph3,
//                                                 ),
//                                               )
//                                               // TextStyle(
//                                               //     color: AppThemeColors.graph3,
//                                               //     fontWeight: FontWeight.w500,
//                                               //     fontSize: 16),
//                                               ),
//                                           SizedBox(),
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                 // right: screenWidth * 0,
//                                 // top: 0,
//                                 left: 0,
//                                 child: Center(
//                                   child: SizedBox(
//                                     // Set the overall size of the container to constrain the pie chart
//                                     height: SizeConfig.screenHeight * 0.1225,

//                                     width: SizeConfig.screenWidth *
//                                         0.4, // Set the desired width
//                                     child: PieChart(
//                                       PieChartData(
//                                         sectionsSpace:
//                                             0, // No space between sections
//                                         centerSpaceRadius: 0,
//                                         // No space in the center

//                                         sections: [
//                                           PieChartSectionData(
//                                             // color: AppThemeColors.graph1,
//                                             gradient: LinearGradient(
//                                                 colors: [
//                                                   Colors.indigo.shade300,
//                                                   Colors.indigo
//                                                 ],
//                                                 begin: Alignment.topRight,
//                                                 end: Alignment.bottomLeft),
//                                             // value: carbsp.toDouble(),
//                                             value: controller.foodData.value!.item
//                                                 .percentageCaloriesFromCarbs
//                                                 .toDouble(),
//                                             // Remove text by setting an empty string for the title
//                                             title: '',
//                                             radius: SizeConfig.screenHeight *
//                                                 0.06125, // Adjust radius to fit within the container
//                                           ),
//                                           PieChartSectionData(
//                                             // color: Color(0xffFFD700),
//                                             // color: AppThemeColors.graph2,
//                                             gradient: LinearGradient(
//                                                 colors: [
//                                                   Colors.green.shade300,
//                                                   Colors.green
//                                                 ],
//                                                 begin: Alignment.topRight,
//                                                 end: Alignment.bottomLeft),
//                                             value: controller.foodData.value!.item
//                                                 .percentageCaloriesFromProtein
//                                                 .toDouble(),
//                                             // value: protienp.toDouble(),
//                                             title: '',
//                                             radius: SizeConfig.screenHeight *
//                                                 0.06125, // Adjust radius to fit within the container
//                                           ),
//                                           PieChartSectionData(
//                                             // color: AppThemeColors.graph3,
//                                             gradient: LinearGradient(
//                                                 colors: [
//                                                   Colors.red.shade200,
//                                                   Colors.red.shade700
//                                                 ],
//                                                 begin: Alignment.topLeft,
//                                                 end: Alignment.bottomRight),
//                                             value: controller.foodData.value!.item
//                                                 .percentageCaloriesFromFat
//                                                 .toDouble(),
//                                             // value: fatp.toDouble(),
//                                             title: '',
//                                             radius: SizeConfig.screenHeight *
//                                                 0.06125, // Adjust radius to fit within the container
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                 // right: screenWidth * 0,
//                                 // top: 0,
//                                 left: SizeConfig.screenWidth * 0.2 -
//                                     SizeConfig.screenHeight * 0.06125,
//                                 child: SizedBox(
//                                   height: SizeConfig.screenHeight * 0.1225,
//                                   width: SizeConfig.screenHeight * 0.1225,
//                                   child: Center(
//                                     child: Container(
//                                       // Set the overall size of the container to constrain the pie chart
//                                       height: SizeConfig.screenHeight * 0.1,
//                                       width: SizeConfig.screenHeight * 0.1,
//                                       decoration: BoxDecoration(
//                                           color: AppThemeColors.secondery2,
//                                           borderRadius:
//                                               BorderRadius.circular(100)),
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                               controller.foodData.value!.item.totalCalories
//                                                   .toString(),
//                                               style: GoogleFonts.roboto(
//                                                 textStyle: TextStyle(
//                                                     fontSize: SizeConfig
//                                                             .blockSizeHorizontal *
//                                                         6,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.black,
//                                                     height: 1.11),
//                                               )
//                                               // TextStyle(
//                                               //     fontSize: 23,
//                                               //     color: Colors.black,
//                                               //     fontWeight: FontWeight.w800,
//                                               //     height: 1.1),
//                                               ),
//                                           Text('Kcal',
//                                               style: GoogleFonts.roboto(
//                                                 textStyle: TextStyle(
//                                                     fontSize: SizeConfig
//                                                             .blockSizeHorizontal *
//                                                         2.5,
//                                                     color: Colors.grey,
//                                                     height: 1.11),
//                                               )
//                                               // TextStyle(
//                                               //     fontSize: 18,
//                                               //     color: Colors.black,
//                                               //     fontWeight: FontWeight.w400,
//                                               //     height: 1),
//                                               ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: SizeConfig.screenHeight * 0.025),
//                         SizedBox(
//                           height: SizeConfig.screenHeight * 0.1225,
//                           width: SizeConfig.screenWidth,
//                           child: Stack(
//                             children: [
//                               Positioned(
//                                 left: 0,
//                                 child: Container(
//                                   width: SizeConfig.screenWidth * 0.8,
//                                   height: SizeConfig.screenHeight * 0.1225,
//                                   // height: 100,
//                                   // color: onSecondaryColor,
//                                   decoration: BoxDecoration(
//                                     gradient: AppThemeColors.secondaryGradient2,
//                                   ),
//                                   child: Padding(
//                                     padding:
//                                         const EdgeInsets.fromLTRB(15, 8, 0, 8),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text('After Consuming this:',
//                                             style: GoogleFonts.openSans(
//                                               textStyle: TextStyle(
//                                                   fontSize: SizeConfig
//                                                           .blockSizeHorizontal *
//                                                       4,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Colors.green.shade800),
//                                             )
//                                             //  TextStyle(
//                                             //     height: 1,
//                                             //     fontSize: 18,
//                                             //     fontWeight: FontWeight.w700
//                                             //     ),
//                                             ),
//                                         SizedBox(),
//                                         // List of bullet points
//                                         Row(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             children: [
//                                               SizedBox(width: 10),
//                                               Icon(Icons.circle, size: 8),
//                                               Text(
//                                                   // '  $waterQ',
//                                                   '  Drink ${controller.foodData.value!.item.waterQuantity} ltr(s) of water',
//                                                   style: GoogleFonts.roboto(
//                                                     textStyle: TextStyle(
//                                                         color: Colors.black),
//                                                   )
//                                                   // TextStyle(height: 0),
//                                                   ),
//                                             ]),
//                                         Row(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             children: [
//                                               SizedBox(width: 10),
//                                               Icon(Icons.circle, size: 8),
//                                               Text(
//                                                   // '  $exerciseQ',
//                                                   '  Exercise for ${controller.foodData.value!.item.exercise} hour(s)',
//                                                   style: GoogleFonts.roboto(
//                                                     textStyle: TextStyle(
//                                                         color: Colors.black),
//                                                   )
//                                                   // TextStyle(height: 0),
//                                                   ),
//                                             ]),
//                                         SizedBox(),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                 // right: screenWidth * 0,
//                                 // top: 0,
//                                 right: SizeConfig.screenWidth * 0.2 -
//                                     SizeConfig.screenHeight * 0.06125,
//                                 child: Container(
//                                   height: SizeConfig.screenHeight * 0.1225,
//                                   width: SizeConfig.screenHeight * 0.1225,
//                                   decoration: BoxDecoration(
//                                       color: AppThemeColors.onPrimary1,
//                                       borderRadius: BorderRadius.circular(100)),
//                                   child: Center(
//                                     child: Container(
//                                       // Set the overall size of the container to constrain the pie chart
//                                       height: SizeConfig.screenHeight * 0.1,
//                                       width: SizeConfig.screenHeight * 0.1,
//                                       decoration: BoxDecoration(
//                                           color: AppThemeColors.secondery2,
//                                           borderRadius:
//                                               BorderRadius.circular(100)),
//                                       child: Center(
//                                           child: Text('Tips',
//                                               style: GoogleFonts.openSans(
//                                                 textStyle: TextStyle(
//                                                     fontSize: SizeConfig
//                                                             .blockSizeHorizontal *
//                                                         6,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.black),
//                                               )
//                                               // TextStyle(
//                                               //     color: Colors.black,
//                                               //     fontSize: 25,
//                                               //     fontWeight: FontWeight.w600),
//                                               )),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: SizeConfig.screenHeight * 0.025),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             AppThemeButton(
//                                     onPressed: () {
//                                       if (Premium.instance.apple!.value >=
//                                           PremiumTheme.comparisonPrice) {
//                                         controller.Comparefunction(context);
//                                       } else {
//                                         Get.toNamed(Routes.STREAK);
//                                       }
//                                     },
//                                     text: 'Compare')
//                                 .smallButtonwithprice(
//                                     PremiumTheme.comparisonPrice),
//                             AppThemeButton(
//                                     onPressed: () {
//                                       if (Premium.instance.apple!.value >=
//                                           PremiumTheme.alternatePrice) {
//                                         Premium.instance.reduce1(
//                                             PremiumTheme.alternatePrice);
//                                         Get.toNamed(
//                                             Routes.COMPARISON_VIEW_SCREEN,
//                                             arguments: [
//                                               controller.foodData.value!.item,
//                                               controller.foodData.value!.alternate1,
//                                               'Alternate',
//                                               controller.foodData.value!.description,
//                                             ]);
//                                       } else {
//                                         Get.toNamed(Routes.STREAK);
//                                       }
//                                     },
//                                     text: 'Alternative')
//                                 .smallButtonwithprice(
//                                     PremiumTheme.alternatePrice),
//                           ],
//                         ),
//                         SizedBox(height: SizeConfig.screenWidth * 0.03),
//                         Center(
//                           child: AppThemeButton(
//                                   onPressed: () {
//                                     controller.logFeed(controller.foodData.value!);
//                                   },
//                                   text: 'Log Food')
//                               .largeButton(),
//                         ),
//                         SizedBox(height: 50),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       }
//     });
//   }
// }

class ResponseScreenAppBar extends GetView<ResponseScreenController> {
  const ResponseScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return appThemeAppBar(context, 'Response');
  }
}
