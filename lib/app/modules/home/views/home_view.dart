import 'dart:ffi';

import 'package:calories_detector/app/data/food_item.dart';
import 'package:calories_detector/app/modules/navbar/controllers/navbar_controller.dart';
import 'package:calories_detector/app/modules/utills/app_images.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:calories_detector/SizeConfig.dart';
import 'package:calories_detector/app/modules/utills/Themes/current_theme.dart';
import 'package:calories_detector/app/premium/premium.dart';
import 'package:calories_detector/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:path/path.dart';
import '../controllers/home_controller.dart';

double convertToGlasses(int quantity, String unit) {
  switch (unit) {
    case 'cups':
      return quantity *
          0.96; // 1 cup = 0.24 liters, 1 glass = 0.25 liters, so 1 cup = 0.96 glasses
    case 'liters':
      print('${quantity * 4}');
      return quantity * 4.0; // 1 liter = 4 glasses (1 glass = 0.25 liters)
    case 'glasses':
    default:
      return quantity
          .toDouble(); // If the unit is already 'glasses', return as is
  }
}

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  // GetxController controlller = HomeController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Obx(() => SingleChildScrollView(
          child: Container(
            height: SizeConfig.screenHeight,
            // color: Colors.white.withOpacity(0.9),
            color: Colors.grey.shade100,
            // color: Colors.grey[],
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        // color: Colors.black12,
                      ),
                      child: Column(
                        children: [
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Graph(
                                    size: size1,
                                    color: color1,
                                    progress: progress1.value,
                                  ),
                                  Graph(
                                    size: size2,
                                    color: color2,
                                    progress: progress2.value,
                                  ),
                                  Graph(
                                    size: size3,
                                    color: color3,
                                    progress: progress3.value,
                                  ),
                                  Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          caloriestarget!.value -
                                                      caloriesProgress!.value <
                                                  0
                                              ? 'Completed'
                                              : '${caloriestarget!.value - caloriesProgress!.value}',
                                          style: TextStyle(
                                              color: caloriestarget!.value -
                                                          caloriesProgress!
                                                              .value <
                                                      0
                                                  ? Colors.green
                                                  : Colors.black87,
                                              fontSize: caloriestarget!.value -
                                                          caloriesProgress!
                                                              .value <
                                                      0
                                                  ? 16
                                                  : 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        if (caloriestarget!.value -
                                                caloriesProgress!.value >
                                            0)
                                          Text(
                                            'Remaining',
                                            style: TextStyle(
                                                color: Colors.black38),
                                          )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(),
                              SizedBox(
                                height: size - padsize,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(),
                                    // SizedBox(),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        AutoSizeText(
                                          "Today's Goal ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                          minFontSize: 8,
                                          maxLines: 1,
                                          maxFontSize: 30,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox()
                                      ],
                                    ),
                                    SizedBox(),
                                    // SizedBox(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            // color: Colors.black,
                                            height: 30,
                                            width: 30,
                                            child: Image.asset(
                                              AppImages.iconCalories,
                                              color: Colors.green,
                                            )),
                                        Column(
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              ' Food',
                                              style: TextStyle(height: 1),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  '$caloriesProgress',
                                                  style: TextStyle(
                                                      fontSize: 18, height: 1),
                                                ),
                                                Text(
                                                  '/$caloriestarget',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black38,
                                                      height: 1),
                                                ),
                                                Text(
                                                  ' Kcal',
                                                  style: TextStyle(
                                                      fontSize: 8,
                                                      color: Colors.black26,
                                                      height: 1),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox()
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            // color: Colors.black,
                                            height: 30,
                                            width: 30,
                                            child: Image.asset(
                                              AppImages.iconWater,
                                              color: Colors.blue,
                                            )),
                                        Column(
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              ' Water',
                                              style: TextStyle(height: 1),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  '${(waterProgress!.value % 1 == 0 ? waterProgress!.value.toInt() : waterProgress!.value.toStringAsFixed(1))}',
                                                  style: TextStyle(
                                                      fontSize: 18, height: 1),
                                                ),
                                                Text(
                                                  '/$watertarget',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black38,
                                                      height: 1),
                                                ),
                                                Text(
                                                  ' Glass',
                                                  style: TextStyle(
                                                      fontSize: 8,
                                                      color: Colors.black26,
                                                      height: 1),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox()
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            // color: Colors.black,
                                            height: 30,
                                            width: 30,
                                            child: Image.asset(
                                              AppImages.iconExercise,
                                              color: Colors.red,
                                            )),
                                        Column(
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              ' Exercise',
                                              style: TextStyle(height: 1),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  '${(exerciseProgress!.value % 1 == 0 ? exerciseProgress!.value.toInt() : exerciseProgress!.value.toStringAsFixed(1))}',
                                                  style: TextStyle(
                                                      fontSize: 18, height: 1),
                                                ),
                                                Text(
                                                  '/${(exercisetarget!.value % 1 == 0 ? exercisetarget!.value.toInt() : exercisetarget!.value.toStringAsFixed(1))}',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black38,
                                                      height: 1),
                                                ),
                                                Text(
                                                  ' hrs',
                                                  style: TextStyle(
                                                      fontSize: 8,
                                                      color: Colors.black26,
                                                      height: 1),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox()
                                      ],
                                    ),
                                    SizedBox(),
                                    // SizedBox(),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // SizedBox(
                              //   // color: Colors.amber,
                              //   height: 50,
                              //   width: (SizeConfig.screenWidth - 40 - 160) / 3,
                              //   child: Column(
                              //     mainAxisAlignment: MainAxisAlignment.start,
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Text('Carbs'),
                              //       Expanded(
                              //         child: ClipRRect(
                              //           borderRadius: BorderRadius.circular(
                              //               20), // Round the edges
                              //           child: SizedBox(
                              //             height:
                              //                 10, // Adjust the height of the progress bar
                              //             child: LinearProgressIndicator(
                              //               value: carbsPercentage.value,
                              //               backgroundColor: Colors.black12,
                              //               // backgroundColor: Colors.black12,
                              //               valueColor: AlwaysStoppedAnimation<
                              //                   Color>(carbsPercentage.value <
                              //                       0.3
                              //                   ? Colors.red
                              //                   : (carbsPercentage.value < 0.6
                              //                       ? Colors.orange
                              //                       : (carbsPercentage.value <
                              //                               0.8
                              //                           ? Colors.amber
                              //                           : Colors.green))),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //       Text('$carbsProgress/$carbstarget')
                              //     ],
                              //   ),
                              // ),
                              // SizedBox(
                              //   // color: Colors.amber,
                              //   height: 50,
                              //   width: (SizeConfig.screenWidth - 40 - 160) / 3,
                              //   child: Column(
                              //     mainAxisAlignment: MainAxisAlignment.start,
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Text('Protien'),
                              //       Expanded(
                              //         child: ClipRRect(
                              //           borderRadius: BorderRadius.circular(
                              //               20), // Round the edges
                              //           child: SizedBox(
                              //             height:
                              //                 10, // Adjust the height of the progress bar
                              //             child: LinearProgressIndicator(
                              //               value: protienPercentage.value,
                              //               backgroundColor: Colors.black12,
                              //               // backgroundColor: Colors.black12,
                              //               valueColor: AlwaysStoppedAnimation<
                              //                   Color>(protienPercentage.value <
                              //                       0.3
                              //                   ? Colors.red
                              //                   : (protienPercentage.value < 0.5
                              //                       ? Colors.orange
                              //                       : (protienPercentage.value <
                              //                               0.8
                              //                           ? Colors.amber
                              //                           : Colors.green))),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //       Text('$protienProgress/$protientarget')
                              //     ],
                              //   ),
                              // ),
                              // SizedBox(
                              //   // color: Colors.amber,
                              //   height: 50,
                              //   width: (SizeConfig.screenWidth - 40 - 160) / 3,
                              //   child: Column(
                              //     mainAxisAlignment: MainAxisAlignment.start,
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Text('Fat'),
                              //       Expanded(
                              //         child: ClipRRect(
                              //           borderRadius: BorderRadius.circular(
                              //               20), // Round the edges
                              //           child: SizedBox(
                              //             height:
                              //                 10, // Adjust the height of the progress bar
                              //             child: LinearProgressIndicator(
                              //               value: fatPercentage.value,
                              //               backgroundColor: Colors.black12,
                              //               // backgroundColor: Colors.black12,
                              //               valueColor: AlwaysStoppedAnimation<
                              //                   Color>(fatPercentage.value <
                              //                       0.3
                              //                   ? Colors.red
                              //                   : (fatPercentage.value < 0.5
                              //                       ? Colors.orange
                              //                       : (fatPercentage.value < 0.8
                              //                           ? Colors.amber
                              //                           : Colors.green))),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //       Text('$fatProgress/$fattarget')
                              //     ],
                              //   ),
                              // ),

                              // Container(
                              //   color: Colors.amber,
                              //   // height: 50,
                              //   // width: (SizeConfig.screenWidth - 40) / 3,
                              //   // width: (SizeConfig.screenWidth - 40 - 160) / 3,
                              //   child: Image.asset(AppImages.iconProtien,
                              //       width: (SizeConfig.screenWidth - 60) / 3),
                              // ),
                              // Stack(
                              //   alignment: Alignment.center,
                              //   children: [
                              //     Image.asset(AppImages.iconFat,
                              //         width: (SizeConfig.screenWidth - 60) / 3),
                              //     Text(
                              //       '100',
                              //       style: TextStyle(color: Colors.white),
                              //     ),
                              //   ],
                              // ),

                              IconNeutrants(
                                  AppImages.iconProtien,
                                  'Protien',
                                  protienProgress!,
                                  protientarget!,
                                  protienPercentage,
                                  const Color(0xff0164FD)),

                              IconNeutrants(
                                  AppImages.iconFat,
                                  'Fat',
                                  fatProgress!,
                                  fattarget!,
                                  fatPercentage,
                                  const Color(0xffFF8000)),

                              IconNeutrants(
                                  AppImages.iconCarbs,
                                  'Carbs',
                                  carbsProgress!,
                                  carbstarget!,
                                  carbsPercentage,
                                  const Color(0xff039D09)),

                              // SizedBox(
                              //   // color: Colors.amber,
                              //   height: 50,
                              //   width: (SizeConfig.screenWidth - 40 - 160) / 3,
                              //   child: Column(
                              //     mainAxisAlignment: MainAxisAlignment.start,
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Text('Fat'),
                              //       Expanded(
                              //         child: ClipRRect(
                              //           borderRadius: BorderRadius.circular(
                              //               20), // Round the edges
                              //           child: SizedBox(
                              //             height:
                              //                 10, // Adjust the height of the progress bar
                              //             child: LinearProgressIndicator(
                              //               value: fatPercentage.value,
                              //               backgroundColor: Colors.black12,
                              //               // backgroundColor: Colors.black12,
                              //               valueColor: AlwaysStoppedAnimation<
                              //                   Color>(fatPercentage.value <
                              //                       0.3
                              //                   ? Colors.red
                              //                   : (fatPercentage.value < 0.5
                              //                       ? Colors.orange
                              //                       : (fatPercentage.value < 0.8
                              //                           ? Colors.amber
                              //                           : Colors.green))),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //       Text('$fatProgress/$fattarget')
                              //     ],
                              //   ),
                              // ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      // Padding(
                      //   padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(20),
                      //       color: Colors.white,
                      //     ),
                      //     height: 70,
                      //     // width: SizeConfig.screenWidth * 0.9,
                      //     child: Stack(
                      //       children: [
                      //         ClipRRect(
                      //           borderRadius: BorderRadius.circular(20),
                      //           child: Opacity(
                      //             opacity: 0.6,
                      //             child: Image.asset(
                      //               AppImages.foodBanner,
                      //               fit: BoxFit.fitHeight,
                      //               alignment: Alignment.centerLeft,
                      //               width: double.infinity,
                      //               height: 100,
                      //             ),
                      //           ),
                      //         ),
                      //         Center(
                      //           child: Row(
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               Padding(
                      //                 padding:
                      //                     const EdgeInsets.only(left: 24.0),
                      //                 child: Text(
                      //                   'Food',
                      //                   style: TextStyle(
                      //                       fontSize: 20,
                      //                       fontWeight: FontWeight.bold),
                      //                 ),
                      //               ),
                      //               Padding(
                      //                 padding:
                      //                     const EdgeInsets.only(right: 12.0),
                      //                 child: IconButton(
                      //                     onPressed: () {
                      //                       dialogueforfood(context);
                      //                     },
                      //                     icon: Icon(
                      //                       Icons.add_circle,
                      //                       color: Colors.black26,
                      //                       size: 30,
                      //                     )),
                      //               ),
                      //             ],
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(20),
                      //       color: Colors.white,
                      //     ),
                      //     height: 70,
                      //     // width: SizeConfig.screenWidth * 0.9,
                      //     child: Stack(
                      //       children: [
                      //         ClipRRect(
                      //           borderRadius: BorderRadius.circular(20),
                      //           child: Opacity(
                      //             opacity: 0.6,
                      //             child: Image.asset(
                      //               AppImages.waterBanner,
                      //               fit: BoxFit.fitHeight,
                      //               alignment: Alignment.centerLeft,
                      //               width: double.infinity,
                      //               height: 100,
                      //             ),
                      //           ),
                      //         ),
                      //         Center(
                      //           child: Row(
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               Padding(
                      //                 padding:
                      //                     const EdgeInsets.only(left: 24.0),
                      //                 child: Text(
                      //                   'Water',
                      //                   style: TextStyle(
                      //                       fontSize: 20,
                      //                       fontWeight: FontWeight.bold),
                      //                 ),
                      //               ),
                      //               Padding(
                      //                 padding:
                      //                     const EdgeInsets.only(right: 12.0),
                      //                 child: IconButton(
                      //                     onPressed: () {
                      //                       dialogueforwater(context);
                      //                     },
                      //                     icon: Icon(
                      //                       Icons.add_circle,
                      //                       color: Colors.black26,
                      //                       size: 30,
                      //                     )),
                      //               ),
                      //             ],
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(20),
                      //       color: Colors.white,
                      //     ),
                      //     height: 70,
                      //     // width: SizeConfig.screenWidth * 0.9,
                      //     child: Stack(
                      //       children: [
                      //         ClipRRect(
                      //           borderRadius: BorderRadius.circular(20),
                      //           child: Opacity(
                      //             opacity: 0.6,
                      //             child: Image.asset(
                      //               AppImages.exersicebanner,
                      //               fit: BoxFit.fitHeight,
                      //               alignment: Alignment.centerLeft,
                      //               width: double.infinity,
                      //               height: 100,
                      //             ),
                      //           ),
                      //         ),
                      //         Center(
                      //           child: Row(
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               Padding(
                      //                 padding:
                      //                     const EdgeInsets.only(left: 24.0),
                      //                 child: Text(
                      //                   'Exercise',
                      //                   style: TextStyle(
                      //                       fontSize: 20,
                      //                       fontWeight: FontWeight.bold),
                      //                 ),
                      //               ),
                      //               Padding(
                      //                 padding:
                      //                     const EdgeInsets.only(right: 12.0),
                      //                 child: IconButton(
                      //                     onPressed: () {
                      //                       dialogueforexercise(context);
                      //                     },
                      //                     icon: Icon(
                      //                       Icons.add_circle,
                      //                       color: Colors.black26,
                      //                       size: 30,
                      //                     )),
                      //               ),
                      //             ],
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),

                      CustomCard(
                        title: 'Food',
                        imagePath: AppImages.foodBanner,
                        onPressed: () {
                          dialogueforfood(context);
                        },
                        clr: Colors.green,
                      ),
                      CustomCard(
                        title: 'Water',
                        imagePath: AppImages.waterBanner,
                        onPressed: () {
                          dialogueforwater(context);
                        },
                        clr: Colors.blue,
                      ),
                      CustomCard(
                        title: 'Exercise',
                        imagePath: AppImages.exersicebanner,
                        onPressed: () {
                          dialogueforexercise(context);
                        },
                        clr: Colors.red,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
    // return Scaffold(
    //   // backgroundColor: AppThemeColors.primarycolor,
    //   body: Container(
    //     decoration: BoxDecoration(gradient: AppThemeColors.bgGradient),
    //     child: Column(
    //       // mainAxisAlignment: MainAxisAlignment.center,
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         verticalSpace(SizeConfig.screenHeight * 0.05),
    //         Logo_Text(),
    //         verticalSpace(SizeConfig.screenHeight * 0.05),
    //         Text("Analyze your image now", style: AppThemeText().headline2),
    //         SizedBox(height: SizeConfig.screenHeight * 0.05),
    //         Column(
    //           children: [
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //               children: [
    //                 InkWell(
    //                   onTap: () {
    //                     pickImageFromGallery();
    //                   },
    //                   child: Icon_Method("Choose from", "Gallery", Icons.image),
    //                 ),
    //                 InkWell(
    //                   onTap: () {
    //                     // pickImageFromCamera();
    //                     Get.toNamed(Routes.CAMERA_SCREEN);
    //                   },
    //                   child: Icon_Method(
    //                       "Capture from", "Camera", Icons.camera_alt_rounded),
    //                 )
    //               ],
    //             ),
    //             verticalSpace(SizeConfig.screenWidth * 0.05),
    //             InkWell(
    //               onTap: () {
    //                 // DatabaseHelper().deleteDatabaseFile();
    //                 Get.toNamed(Routes.HISTORY_VIEW_SCREEN);
    //               },
    //               child: Container(
    //                 height: SizeConfig.screenWidth * 0.2,
    //                 width: SizeConfig.screenWidth * 0.9,
    //                 decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(
    //                         SizeConfig.screenWidth * 0.05),
    //                     // color: AppThemeColors.buttonColor1
    //                     gradient: AppThemeColors.buttonColor),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     SizedBox(width: SizeConfig.screenWidth * 0.05),
    //                     Icon(
    //                       Icons.history,
    //                       size: SizeConfig.screenWidth * 0.15,
    //                       color: AppThemeColors.iconColor,
    //                     ),
    //                     SizedBox(width: SizeConfig.screenWidth * 0.05),
    //                     Text(
    //                       "Previous Logs",
    //                       style: AppThemeText().bodyText1,
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  Column IconNeutrants(String img, String name, RxInt value, RxInt target,
      RxDouble progress, Color clr) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          name,
          style:
              TextStyle(fontWeight: FontWeight.bold, color: clr, fontSize: 16),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(img, width: (SizeConfig.screenWidth * 0.85) / 3),
            SizedBox(
              // color: Colors.amber,
              // height: 51,
              width: (SizeConfig.screenWidth * 0.5) / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(name),
                  Text(
                    ' $value/$target',
                    style: TextStyle(
                      color: Colors.white,
                      // fontWeight: FontWeight.bold
                    ),
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(20), // Round the edges
                          child: SizedBox(
                            height: 10, // Adjust the height of the progress bar
                            child: LinearProgressIndicator(
                              value: progress.value,
                              backgroundColor: Colors.black12,
                              // backgroundColor: Colors.black12,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  progress.value < 0.3
                                      ? Colors.red
                                      : (progress.value < 0.5
                                          ? Colors.orange
                                          : (progress.value < 0.8
                                              ? Colors.amber
                                              : Colors.green))),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: SizeConfig.screenWidth * 0.02),
                    ],
                  ),
                  Text('')
                  // Text('$value/$target')
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onPressed;
  final Color clr;

  const CustomCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onPressed,
    required this.clr,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          // color: clr,
        ),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Image.asset(
                imagePath,
                fit: BoxFit.fitHeight,
                alignment: Alignment.centerLeft,
                // width: double.infinity,
                height: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0),
              // padding: const EdgeInsets.only(left: 24.0),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: clr
                    // color: Colors.white
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.add_circle,
                  color: clr,
                  // color: Colors.white,
                  // color: Colors.black26,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//   Container Icon_Method(String smallTexted, String largeTexted, IconData icon) {
//     return Container(
//       height: SizeConfig.screenWidth * 0.5,
//       width: SizeConfig.screenWidth * 0.425,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(SizeConfig.screenWidth * 0.05),
//           gradient: AppThemeColors.buttonColor
//           // color: AppThemeColors.buttonColor1
//           ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(vertical: SizeConfig.screenWidth * 0.05),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Icon(
//               icon,
//               size: SizeConfig.screenWidth * 0.15,
//               // color: AppThemeColors.iconColor,
//               color: AppThemeColors.iconColor,
//               // color: AppColors.onSecondaryColor,
//             ),
//             Text(smallTexted, style: AppThemeText().bodyText1),
//             Text(largeTexted, style: AppThemeText().bodyText1),
//           ],
//         ),
//       ),
//     );
//   }
// }
// Row Logo_Text() {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       Text(
//         'Cal',
//         style: TextStyle(
//           fontSize: 80,
//           color: AppThemeColors.logoColor,
//           fontWeight: FontWeight.w900,
//           // height: size.height * 0.016
//         ),
//       ),
//       Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'ories',
//             style: TextStyle(
//                 fontSize: 35,
//                 color: AppThemeColors.logoColor,
//                 fontWeight: FontWeight.w900,
//                 // letterSpacing: 1,
//                 height: 1),
//           ),
//           Text(
//             'culator',
//             style: TextStyle(
//                 // letterSpacing: 1,
//                 fontSize: 35,
//                 color: AppThemeColors.logoColor,
//                 fontWeight: FontWeight.w900,
//                 height: 1),
//           )
//         ],
//       )
//     ],
//   );
// }

class HomeViewAppBar extends GetView<HomeController> {
  const HomeViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return appThemeAppBar(context, 'Home');
  }
}

dialogueforfood(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: AppThemeColors.buttonColor,
            borderRadius: BorderRadius.circular(15), // Keep gradient rounded
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select an Option',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Make title stand out on gradient
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Would you like to enter data manually or scan an item?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        if ((Premium.instance.apple!.value >=
                            PremiumTheme.manualEntryPrice)) {
                          dialogueformanualdata(context);
                        } else {
                          Get.toNamed(Routes.STREAK);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Not enough Apples."),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text('Manual Data',
                              style: TextStyle(color: Colors.black)),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                AppImages.apple2,
                                height: 35,
                                color: Colors.red,
                              ),
                              Text(
                                '${PremiumTheme.manualEntryPrice}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        if ((Premium.instance.apple!.value >=
                            PremiumTheme.scanPrice)) {
                          dialogueforscan(context);
                        } else {
                          Get.toNamed(Routes.STREAK);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Not enough Apples."),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text('Scan', style: TextStyle(color: Colors.black)),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                AppImages.apple2,
                                height: 35,
                                color: Colors.red,
                              ),
                              Text(
                                '${PremiumTheme.scanPrice}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

dialogueforscan(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: AppThemeColors.buttonColor,
            borderRadius: BorderRadius.circular(15), // Keep gradient rounded
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select an Option',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Make title stand out on gradient
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Would you like to select an item from your gallery or take a new picture?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // Navigator.of(context).pop();
                        Get.back();
                        NavbarController navbarController = Get.find();

                        navbarController.pickImageFromGallery();
                        // navbarController.index.value = 2;
                        // NavbarController().resetFunction();
                        // print('reseted');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: Icon(Icons.photo, color: AppThemeColors.onPrimary1),
                      label: Text('Gallery',
                          style: TextStyle(color: Colors.black)),
                    ),
                    SizedBox(),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Get.toNamed(Routes.CAMERA_SCREEN);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: Icon(Icons.camera_alt,
                          color: AppThemeColors.onPrimary1),
                      label:
                          Text('Camera', style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

dialogueformanualdata(BuildContext context) {
  RxBool showNutrients = false.obs;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: AppThemeColors.buttonColor,
            borderRadius: BorderRadius.circular(15), // Keep gradient rounded
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: StatefulBuilder(
              builder: (context, setState) {
                String foodName = '';
                RxInt calories = 0.obs;
                // RxInt carbs = 0.obs;
                // RxInt protein = 0.obs;
                // RxInt fat = 0.obs;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Enter Manual Data',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      onChanged: (value) {
                        foodName = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Food Item Name',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      onChanged: (value) {
                        calories.value = int.parse(value);
                        // protein.value = calories.value;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Calories',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    // // Obx(() {
                    // //   return
                    // GestureDetector(
                    //     onTap: () {
                    //       showNutrients.toggle();
                    //     },
                    //     child: Obx(
                    //       () => Row(
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Text('Nutrients (Optional)'),
                    //           if (!showNutrients.value)
                    //             Icon(Icons.arrow_drop_down)
                    //           else
                    //             Icon(Icons.arrow_drop_up)
                    //         ],
                    //       ),
                    //     )),
                    // Divider(color: Colors.white),
                    // Obx(() {
                    //   if (showNutrients.value) {
                    //     return Column(
                    //       children: [
                    //         SizedBox(height: 10),
                    //         TextField(
                    //           onChanged: (value) {
                    //             carbs.value =
                    //                 int.parse(value); // Capture carbs input
                    //           },
                    //           keyboardType: TextInputType.number,
                    //           decoration: InputDecoration(
                    //             hintText: 'Carbs (g)',
                    //             filled: true,
                    //             fillColor: Colors.white,
                    //             border: OutlineInputBorder(
                    //               borderRadius: BorderRadius.circular(10),
                    //             ),
                    //           ),
                    //         ),
                    //         SizedBox(height: 10),
                    //         TextField(
                    //           onChanged: (value) {
                    //             protein.value =
                    //                 int.parse(value); // Capture protein input
                    //           },
                    //           keyboardType: TextInputType.number,
                    //           decoration: InputDecoration(
                    //             hintText: 'Protein (g)',
                    //             filled: true,
                    //             fillColor: Colors.white,
                    //             border: OutlineInputBorder(
                    //               borderRadius: BorderRadius.circular(10),
                    //             ),
                    //           ),
                    //         ),
                    //         SizedBox(height: 10),
                    //         TextField(
                    //           onChanged: (value) {
                    //             fat.value =
                    //                 int.parse(value); // Capture fat input
                    //           },
                    //           keyboardType: TextInputType.number,
                    //           decoration: InputDecoration(
                    //             hintText: 'Fat (g)',
                    //             filled: true,
                    //             fillColor: Colors.white,
                    //             border: OutlineInputBorder(
                    //               borderRadius: BorderRadius.circular(10),
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     );
                    //   }
                    //   return SizedBox
                    //       .shrink(); // Return an empty widget if not shown
                    // }),
                    // SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (foodName == '') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Food Name Can't be empty"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else if (calories.value == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Calories Can't be empty"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else if (calories.value > 2000) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Please enter a realistic calorie value.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          FoodData manualFoodDataObject = FoodData(
                              item: FoodItem(
                                  name: foodName,
                                  quantity: '1',
                                  fat: double.parse(((calories.value * 0.2) / 9)
                                      .toStringAsFixed(1)),
                                  carbs: double.parse(((calories.value * 0.5) / 4)
                                      .toStringAsFixed(1)),
                                  protein: double.parse(
                                      ((calories.value * 0.3) / 4)
                                          .toStringAsFixed(1)),
                                  waterQuantity: 1,
                                  exercise: 1,
                                  vitamins: {},
                                  minerals: {},
                                  additionalNutrients: {},
                                  allergens: [],
                                  dietCompatibility: [],
                                  warnings: [],
                                  healthScore: 5),
                              alternate1: FoodItem(
                                  name: 'Manual',
                                  quantity: '1',
                                  fat: double.parse(
                                      ((calories.value * 0.2) / 9).toStringAsFixed(1)),
                                  carbs: double.parse(((calories.value * 0.5) / 4).toStringAsFixed(1)),
                                  protein: double.parse(((calories.value * 0.3) / 4).toStringAsFixed(1)),
                                  waterQuantity: 1,
                                  exercise: 1,
                                  vitamins: {},
                                  minerals: {},
                                  additionalNutrients: {},
                                  allergens: [],
                                  dietCompatibility: [],
                                  warnings: [],
                                  healthScore: 5),
                              description: '');
                          HomeController homeController;

                          if (Get.isRegistered<HomeController>()) {
                            homeController = Get.find<HomeController>();
                          } else {
                            homeController = Get.put(HomeController());
                          }
                          homeController.logFeed(manualFoodDataObject);
                          Premium.instance
                              .reduce1(PremiumTheme.manualEntryPrice);
                          Navigator.of(context).pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child:
                          Text('Save', style: TextStyle(color: Colors.black)),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );
    },
  );
}

void dialogueforwater(BuildContext context) {
  RxInt selectedGlasses = 0.obs; // Tracks the number of selected glasses

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: AppThemeColors.buttonColor,

            // color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Water Intake',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),

              // Glasses of water grid
              Obx(
                () => Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: List.generate(
                    5, // Number of glasses to display
                    (index) => GestureDetector(
                      onTap: () {
                        selectedGlasses.value = index + 1; // Update selection
                      },
                      child: Image.asset(
                        index < selectedGlasses.value
                            ? AppImages.filledGlass
                            : AppImages.emptyGlass,
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Submit button
              ElevatedButton.icon(
                onPressed: () {
                  // // Store the selected number of glasses
                  // double waterInLiters =
                  //     selectedGlasses.value * 0.25; // Example: 1 glass = 250ml
                  // Navigator.of(context).pop();
                  // toDay!.AddWater(waterInLiters);
                  toDay!.AddWater(selectedGlasses.value.toDouble());
                  HomeController().updatehomedata();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: Icon(Icons.check, color: AppThemeColors.onPrimary1),
                label: Text(
                  'Submit',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

// dialogueforwater(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       // Initial values for the number picker and unit dropdown
//       RxInt selectedQuantity = 2.obs; // Initially set to 1
//       RxString selectedUnit = 'liters'.obs;
//       return Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15), // Rounded corners
//         ),
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: AppThemeColors.buttonColor,
//             borderRadius: BorderRadius.circular(15), // Keep gradient rounded
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   'Enter Water Intake',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white, // Make title stand out on gradient
//                   ),
//                 ),
//                 SizedBox(height: 15),
//                 // Row for number picker and dropdown unit picker
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     // Number picker for water quantity
//                     Column(
//                       children: [
//                         Text(
//                           "Quantity",
//                           style: TextStyle(color: Colors.white, fontSize: 16),
//                         ),
//                         Container(
//                           height: 50,
//                           width: 110,
//                           padding: EdgeInsets.symmetric(horizontal: 10),
//                           decoration: BoxDecoration(
//                             color: Colors.white, // Add white background
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           child: Center(
//                             child: Obx(
//                               () => NumberPicker(
//                                 minValue: 1,
//                                 maxValue: 21,
//                                 value: selectedQuantity
//                                     .value, // Set initial value to 1
//                                 onChanged: (newValue) {
//                                   selectedQuantity.value = newValue;
//                                 },
//                                 itemHeight: 40,
//                                 textStyle: TextStyle(color: Colors.black),
//                                 selectedTextStyle: TextStyle(
//                                     color: Colors.black, fontSize: 18),
//                                 decoration: BoxDecoration(
//                                   border: Border(
//                                     top: BorderSide(
//                                         color: Colors.grey, width: 1.5),
//                                     bottom: BorderSide(
//                                         color: Colors.grey, width: 1.5),
//                                   ),
//                                 ), // Add borders to center the picker value
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(width: 20),
//                     // Dropdown for selecting the unit
//                     Column(
//                       children: [
//                         Text(
//                           "Unit",
//                           style: TextStyle(color: Colors.white, fontSize: 16),
//                         ),
//                         Container(
//                           height: 50,
//                           width: 110,
//                           padding: EdgeInsets.symmetric(horizontal: 10),
//                           decoration: BoxDecoration(
//                             color: Colors.white, // Add white background
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           child: Obx(
//                             () => DropdownButton<String>(
//                               value: selectedUnit.value,
//                               onChanged: (String? newValue) {
//                                 if (newValue != null) {
//                                   selectedUnit.value = newValue;
//                                 }
//                               },
//                               items: <String>[
//                                 'liters',
//                                 'cups',
//                                 'glasses'
//                               ].map<DropdownMenuItem<String>>((String value) {
//                                 return DropdownMenuItem<String>(
//                                   value: value,
//                                   child: Text(value),
//                                 );
//                               }).toList(),
//                               underline: SizedBox(),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 25),
//                 // Submit button to confirm the input
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     // Convert water quantity based on selected unit
//                     double waterInLiters = convertToGlasses(
//                         selectedQuantity.value - 1, selectedUnit.value);
//                     Navigator.of(context).pop(waterInLiters);
//                     toDay!.AddWater(waterInLiters);
//                     HomeController().updatehomedata();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   icon: Icon(Icons.check, color: AppThemeColors.onPrimary1),
//                   label: Text('Submit', style: TextStyle(color: Colors.black)),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }

dialogueforexercise(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // Initial value for the exercise time in minutes
      RxInt selectedMinutes = 2.obs; // Initially set to 1 minute

      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: AppThemeColors.buttonColor,
            borderRadius: BorderRadius.circular(15), // Keep gradient rounded
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Enter Exercise Time',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Make title stand out on gradient
                  ),
                ),
                SizedBox(height: 15),

                // Row for number picker for exercise time in minutes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Number picker for exercise time in minutes
                    Column(
                      children: [
                        Text(
                          "Minutes",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Container(
                          height: 50,
                          width: 110,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white, // Add white background
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Obx(
                              () => NumberPicker(
                                minValue: 1,
                                maxValue:
                                    121, // Setting a range from 1 to 120 minutes
                                value: selectedMinutes
                                    .value, // Set initial value to 1
                                onChanged: (newValue) {
                                  selectedMinutes.value = newValue;
                                },
                                itemHeight: 40,
                                textStyle: TextStyle(color: Colors.black),
                                selectedTextStyle: TextStyle(
                                    color: Colors.black, fontSize: 18),
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                        color: Colors.grey, width: 1.5),
                                    bottom: BorderSide(
                                        color: Colors.grey, width: 1.5),
                                  ),
                                ), // Add borders to center the picker value
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25),

                // Submit button to confirm the input
                ElevatedButton.icon(
                  onPressed: () {
                    int exerciseTimeInMinutes = selectedMinutes.value;

                    Navigator.of(context).pop(exerciseTimeInMinutes);
                    toDay!.AddExercise((exerciseTimeInMinutes - 1) / 60);
                    HomeController().updatehomedata();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: Icon(Icons.check, color: AppThemeColors.onPrimary1),
                  label: Text('Submit', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
