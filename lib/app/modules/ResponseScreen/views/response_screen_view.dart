import 'package:calories_detector/app/modules/utills/Themes/current_theme.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:calories_detector/sizeConfig.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/response_screen_controller.dart';
import '../../../routes/app_pages.dart';

class ResponseScreenView extends GetView<ResponseScreenController> {
  const ResponseScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // backgroundColor: AppColors.onSecondaryColor,
      // backgroundColor: primaryColor,
      body: Container(
        decoration: BoxDecoration(gradient: AppThemeColors.bgGradient),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  height: SizeConfig.screenWidth * 0.65,
                  // height: screenHeight * 0.286,
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                      gradient: AppThemeColors.primaryGradient1,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                              SizeConfig.blockSizeHorizontal * 5),
                          bottomRight: Radius.circular(
                              SizeConfig.blockSizeHorizontal * 5))),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    // child: controller.imageFile.value,
                    child: Image.memory(controller.imageFile2!),
                  ),
                ),
                Positioned(
                    child: SafeArea(
                  child: Container(
                    height: SizeConfig.blockSizeVertical * 5,
                    width: SizeConfig.blockSizeHorizontal * 15,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.4)),
                    child: Center(
                      child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppThemeColors.iconColor,
                          )),
                    ),
                  ),
                ))
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 1,
                  left: SizeConfig.blockSizeHorizontal * 4,
                  bottom: SizeConfig.blockSizeVertical * 1),
              width: SizeConfig.blockSizeHorizontal * 95,
              child: Text(controller.foodData.value!.item.name,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 6,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2ECC71)),
                    // AppThemeText().headline1,
                  )

                  // TextStyle(
                  //     fontWeight: FontWeight.w500,
                  //     fontSize: 30,
                  //     color: Colors.black),
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
                    Text('Total',
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 5,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo),
                        )
                        // AppThemeText().headline2,
                        // TextStyle(
                        //     fontSize: 35,
                        //     fontWeight: FontWeight.w700,
                        //     color: secondaryColor,
                        //     height: 1),
                        ),
                    Text('Calories',
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 5,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo),
                        )
                        //  AppThemeText().headline2,
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
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                        controller.foodData.value!.item.totalCalories
                            .toString(),
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 5,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                        //  AppThemeText().headline2,
                        // TextStyle(
                        //     fontSize: 35,
                        //     fontWeight: FontWeight.w900,
                        //     color: onPrimaryColor,
                        //     height: 1),
                        ),
                    Text('Kcal',
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo),
                        )
                        // TextStyle(
                        //   fontSize: 14,
                        //   fontWeight: FontWeight.w500,
                        //   color: AppThemeColors.onPrimary1,
                        // ),
                        ),
                    // ? // // // ------Commented by jamal uncomment after prompt setting------ // // //
                    // Text(
                    //   // quantity,
                    //   controller.foodData.value!.item.quantity,
                    //   style: TextStyle(
                    //       fontSize: 10,
                    //       fontWeight: FontWeight.w500,
                    //       color: AppThemeColors.onPrimary1,
                    //       height: 1),
                    // )
                    // // // ------------------------------------------------ // // //
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(),
                              Text('Carbs',
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal *
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
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 3.5,
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
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 3.5,
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(),
                              Text(
                                  // '$carbsW g',
                                  '${controller.foodData.value!.item.carbs} g',
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 3.5,
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
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 3.5,
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
                              Text('${controller.foodData.value!.item.fat} g',
                                  // '$fatW g',
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 3.5,
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(),
                              Text(
                                  '${controller.foodData.value!.item.percentageCaloriesFromCarbs} %',
                                  // '$carbsp %',
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 3.5,
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
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 3.5,
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
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 3.5,
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
                            sectionsSpace: 0, // No space between sections
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
                                  controller.foodData.value!.item.totalCalories
                                      .toString(),
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal * 6,
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
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal *
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('After Consuming this:',
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 4,
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(width: 10),
                                  Icon(Icons.circle, size: 8),
                                  Text(
                                      // '  $waterQ',
                                      '  Drink ${controller.foodData.value!.item.waterquantity} ltr(s) of water',
                                      style: GoogleFonts.roboto(
                                        textStyle:
                                            TextStyle(color: Colors.black),
                                      )
                                      // TextStyle(height: 0),
                                      ),
                                ]),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(width: 10),
                                  Icon(Icons.circle, size: 8),
                                  Text(
                                      // '  $exerciseQ',
                                      '  Exercise for ${controller.foodData.value!.item.exercise} hour(s)',
                                      style: GoogleFonts.roboto(
                                        textStyle:
                                            TextStyle(color: Colors.black),
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
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal * 6,
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
                          controller.Comparefunction(context);
                        },
                        text: 'Compare')
                    .smallButton(),
                AppThemeButton(
                        onPressed: () {
                          Get.toNamed(Routes.COMPARISON_VIEW_SCREEN,
                              arguments: [
                                controller.foodData.value!.item,
                                controller.foodData.value!.alternate1,
                                'Alternate',
                                controller.foodData.value!.description,
                              ]);
                        },
                        text: 'Alternative')
                    .smallButton(),
              ],
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.005),
            Center(
              child: AppThemeButton(
                      onPressed: () {
                        controller.logFeed(controller.foodData.value!);
                      },
                      // onPressed: () async {
                      //   SharedPreferences prefs =
                      //       await SharedPreferences.getInstance();
                      //   await prefs.clear();
                      //   DatabaseHelper().deleteDatabaseFile();
                      //   print('done');
                      // },

                      text: 'Log Food')
                  .largeButton(),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.025),
          ],
        ),
      ),
    );
  }
}
