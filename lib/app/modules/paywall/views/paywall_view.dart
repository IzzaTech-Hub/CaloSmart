import 'package:calories_detector/app/modules/utills/Themes/current_theme.dart';
import 'package:calories_detector/app/modules/utills/app_images.dart';
import 'package:calories_detector/app/premium/premium.dart';
import 'package:calories_detector/app/services/revenuecat_service.dart';
import 'package:calories_detector/sizeConfig.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../controllers/paywall_controller.dart';

class PaywallView extends GetView<PaywallController> {
  const PaywallView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      // backgroundColor: Color(0xff2e392e),
      // backgroundColor: Colors.grey.shade200,
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          AppThemeColors.onPrimary1,
          AppThemeColors.onPrimary2,
          AppThemeColors.onPrimary2light
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Column(
          children: [
            SafeArea(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 2),
                      height: SizeConfig.blockSizeVertical * 8,
                      width: SizeConfig.blockSizeHorizontal * 8,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.grey.shade900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 65,
              decoration: BoxDecoration(
                // color: Colors.green,
                // border: Border.all(color: Colors.white),
                borderRadius:
                    BorderRadius.circular(SizeConfig.blockSizeHorizontal * 4),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.shade700,
                //     offset: Offset(1, 5),
                //     spreadRadius: 0,
                //     blurRadius: 5
                //   )
                // ]
              ),
              child: Text(
                "Unlock Unlimited Access",
                style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 7,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade50,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            verticalSpace(SizeConfig.blockSizeVertical * 1),
            feature_description(
                Colors.deepPurple,
                AppImages.compareAndAlternate,
                "Compare products or find alternatives."),
            feature_description(
                Colors.deepOrange, AppImages.noAds, "Ad-free experience."),
            feature_description(Colors.pink, AppImages.upgradeApple,
                "Earn additional rewards."),
            Padding(
              padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i <= 4; i++)
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 20,
                    ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 1),
              width: SizeConfig.blockSizeHorizontal * 80,
              child: Text(
                "Track your daily calorie intake easily with our Calories Finder app! Get personalized insights and stay on top of your health goals. ðŸ’ªðŸ",
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 3,
                    color: Colors.grey.shade900),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              // color: Colors.amber,
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.34,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (PremiumTheme.offering!.availablePackages.length == 1)
                    Column(children: [
                      paytile(1, PremiumTheme.offering!.availablePackages[0])
                    ]),
                  if (PremiumTheme.offering!.availablePackages.length == 2)
                    Column(children: [
                      paytile(1, PremiumTheme.offering!.availablePackages[1]),
                      SizedBox(height: SizeConfig.screenHeight * 0.02),
                      paytile(2, PremiumTheme.offering!.availablePackages[0])
                    ]),
                  if (PremiumTheme.offering!.availablePackages.length == 3)
                    Column(children: [
                      paytile(1, PremiumTheme.offering!.availablePackages[1]),
                      SizedBox(height: SizeConfig.screenHeight * 0.02),
                      paytile(2, PremiumTheme.offering!.availablePackages[0]),
                      SizedBox(height: SizeConfig.screenHeight * 0.02),
                      paytile(3, PremiumTheme.offering!.availablePackages[2])
                    ]),

                  // for (int i = 0;
                  //     i <
                  //         PremiumTheme.offering!
                  //             .availablePackages.length;
                  //     i++)
                  //   Column(children: [
                  //     paytile(
                  //         i,
                  //         PremiumTheme
                  //             .offering!.availablePackages[i]),
                  //     if (i + 1 !=
                  //         PremiumTheme.offering!
                  //             .availablePackages.length)
                  //       SizedBox(
                  //           height:
                  //               SizeConfig.screenHeight * 0.02),
                  //   ]),

                  // paytile(
                  //   1,
                  //   Column(
                  //     mainAxisAlignment:
                  //         MainAxisAlignment.center,
                  //     children: [
                  //       SizedBox(),
                  //       Text(
                  //         '${PremiumTheme.offering!.availablePackages.length}',
                  //         // 'Weekly',
                  //         style: TextStyle(
                  //             fontSize: 18,
                  //             color: Colors.black,
                  //             fontWeight: FontWeight.bold),
                  //       ),
                  //       Row(
                  //         mainAxisAlignment:
                  //             MainAxisAlignment.center,
                  //         children: [
                  //           Text(
                  //             PremiumTheme
                  //                 .weeklyMembershipString,
                  //             style: controller.currentSelected!
                  //                         .value ==
                  //                     1
                  //                 ? TextStyle(
                  //                     fontSize: 18,
                  //                     fontWeight:
                  //                         FontWeight.bold,
                  //                     color: AppThemeColors
                  //                         .onPrimary1)
                  //                 : TextStyle(
                  //                     fontSize: 16,
                  //                     fontWeight:
                  //                         FontWeight.bold),
                  //           ),
                  //           Text(
                  //             '  /week',
                  //             style: TextStyle(
                  //                 fontSize: 12,
                  //                 color: Colors.black45,
                  //                 fontWeight: FontWeight.w400),
                  //           )
                  //         ],
                  //       ),
                  //       Text(
                  //         '${(PremiumTheme.weeklyMembership / 7 * 30).toStringAsFixed(2)} per month',
                  //         style: TextStyle(
                  //           fontSize: 12,
                  //           color: Colors.red,
                  //           // fontWeight: FontWeight.w500
                  //         ),
                  //       ),
                  //       SizedBox(),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //     height: SizeConfig.screenHeight * 0.02),
                  // paytile(
                  //   2,
                  //   Column(
                  //     mainAxisAlignment:
                  //         MainAxisAlignment.center,
                  //     children: [
                  //       SizedBox(),
                  //       Text(
                  //         'Monthly',
                  //         style: TextStyle(
                  //             fontSize: 18,
                  //             color: Colors.black,
                  //             fontWeight: FontWeight.bold),
                  //       ),
                  //       Row(
                  //         mainAxisAlignment:
                  //             MainAxisAlignment.center,
                  //         children: [
                  //           Text(
                  //             '${(PremiumTheme.weeklyMembership / 7 * 30).toStringAsFixed(2)}  ',
                  //             style: TextStyle(
                  //                 fontSize: 14,
                  //                 fontWeight: FontWeight.w400,
                  //                 color: Colors.black54,
                  //                 decoration: TextDecoration
                  //                     .lineThrough),
                  //           ),
                  //           Text(
                  //             PremiumTheme
                  //                 .monthlyMembershipString,
                  //             style: controller.currentSelected!
                  //                         .value ==
                  //                     2
                  //                 ? TextStyle(
                  //                     fontSize: 18,
                  //                     fontWeight:
                  //                         FontWeight.bold,
                  //                     color: AppThemeColors
                  //                         .onPrimary1)
                  //                 : TextStyle(
                  //                     fontSize: 16,
                  //                     fontWeight:
                  //                         FontWeight.bold),
                  //           ),
                  //           Text(
                  //             '  /month',
                  //             style: TextStyle(
                  //                 fontSize: 12,
                  //                 color: Colors.black45,
                  //                 fontWeight: FontWeight.w400),
                  //           )
                  //         ],
                  //       ),
                  //       Text(
                  //         'Save ${(PremiumTheme.weeklyMembership / 7 * 30 - PremiumTheme.monthlyMembership).toStringAsFixed(2)} per month',
                  //         style: TextStyle(
                  //           fontSize: 12,
                  //           color: Colors.red,
                  //           // fontWeight: FontWeight.w500
                  //         ),
                  //       ),
                  //       SizedBox(),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //     height: SizeConfig.screenHeight * 0.02),
                  // paytile(
                  //   3,
                  //   Column(
                  //     mainAxisAlignment:
                  //         MainAxisAlignment.center,
                  //     children: [
                  //       SizedBox(),
                  //       Text(
                  //         'Anually',
                  //         style: TextStyle(
                  //             fontSize: 18,
                  //             color: Colors.black,
                  //             fontWeight: FontWeight.bold),
                  //       ),
                  //       Row(
                  //         mainAxisAlignment:
                  //             MainAxisAlignment.center,
                  //         children: [
                  //           Text(
                  //             '${(PremiumTheme.weeklyMembership / 7 * 365).toStringAsFixed(2)}  ',
                  //             style: TextStyle(
                  //                 fontSize: 14,
                  //                 fontWeight: FontWeight.w400,
                  //                 color: Colors.black54,
                  //                 decoration: TextDecoration
                  //                     .lineThrough),
                  //           ),
                  //           Text(
                  //             PremiumTheme
                  //                 .anuallyMembershipString,
                  //             style: controller.currentSelected!
                  //                         .value ==
                  //                     3
                  //                 ? TextStyle(
                  //                     fontSize: 18,
                  //                     fontWeight:
                  //                         FontWeight.bold,
                  //                     color: AppThemeColors
                  //                         .onPrimary1)
                  //                 : TextStyle(
                  //                     fontSize: 16,
                  //                     fontWeight:
                  //                         FontWeight.bold),
                  //           ),
                  //           Text(
                  //             '  /year',
                  //             style: TextStyle(
                  //                 fontSize: 12,
                  //                 color: Colors.black45,
                  //                 fontWeight: FontWeight.w400),
                  //           )
                  //         ],
                  //       ),
                  //       Text(
                  //         'Save ${((PremiumTheme.weeklyMembership / 7 * 365) - PremiumTheme.anuallyMembership).toStringAsFixed(2)} per year',
                  //         style: TextStyle(
                  //           fontSize: 12,
                  //           color: Colors.red,
                  //           // fontWeight: FontWeight.w500
                  //         ),
                  //       ),
                  //       SizedBox(),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            GestureDetector(
                onTap: () {
                  RevenueCatService().purchaseSubscriptionWithProduct(
                      controller.currentProduct.value!);
                },
                child: Container(
                  height: SizeConfig.screenHeight * 0.06,
                  width: SizeConfig.screenWidth * 0.5,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(SizeConfig.screenHeight * 0.1),
                      color: Colors.green,
                      // color: AppThemeColors.onPrimary2,
                      // color: Colors.red.shade700,
                      // border:
                      //     Border.all(color: Colors.white, width: 1),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade700,
                            offset: Offset(1, 5),
                            spreadRadius: 0,
                            blurRadius: 5)
                      ]),
                  child: Center(
                      child: Text(
                    'Subscribe',
                    style: TextStyle(
                        color: Colors.white,
                        // color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.blockSizeHorizontal * 5),
                  )),
                ))
          ],
        ),
      ),
    );

    // body: Column(
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [
    //     Stack(
    //       children: [
    //         Background(),
    //         SafeArea(
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             children: [
    //               SizedBox(height: 15),
    //               Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     // SizedBox(height: 15),
    //                     Container(
    //                       // width: 30,
    //                       width: 45,
    //                       height: 30,
    //                     ),
    //                     Text(
    //                       'Upgrade your Plan',
    //                       style: TextStyle(
    //                           color: Colors.white,
    //                           fontSize: 24,
    //                           fontWeight: FontWeight.bold),
    //                     ),
    //                     // Container(
    //                     //   margin: EdgeInsets.only(right: 15),
    //                     //   width: 30,
    //                     //   height: 30,
    //                     //   decoration: BoxDecoration(
    //                     //       color: Colors.black.withOpacity(0.3),
    //                     //       shape: BoxShape.circle),
    //                     //   child: Icon(
    //                     //     Icons.close,
    //                     //     color: Colors.white.withOpacity(0.2),
    //                     //   ),
    //                     // )
    //                     IconButton(
    //                       icon: Icon(Icons.cancel,
    //                           size: 30,
    //                           color: Colors.black.withOpacity(0.2)),
    //                       onPressed: () {
    //                         Get.back();
    //                       },
    //                     )
    //                   ]),
    //               SizedBox(height: SizeConfig.screenHeight * 0.01),
    //               Container(
    //                 height: SizeConfig.screenHeight * 0.27,
    //                 // color: Colors.amber,
    //                 child: Row(
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                   // crossAxisAlignment: CrossAxisAlignment.start,
    //                   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                   children: [
    //                     // FeatureTile(
    //                     //   img: AppImages.aiGlitter,
    //                     //   txt: 'Ai\nAssistant',
    //                     //   coloColor.fromARGB(255, 157, 153, 141)GB(255, 161, 157, 142)ber,
    //                     // ),
    //                     FeatureTile(
    //                       img: AppImages.compareAndAlternate,
    //                       txt: 'Compare/\nAlternate',
    //                       color: Colors.blue,
    //                     ),
    //                     FeatureTile(
    //                       img: AppImages.noAds,
    //                       txt: 'No\nAds',
    //                       color: Colors.red,
    //                     ),
    //                     FeatureTile(
    //                       img: AppImages.upgradeApple,
    //                       txt: 'More\nRewards',
    //                       color: Colors.green,
    //                     ),

    //                     // Container(
    //                     //   height: SizeConfig.screenHeight * 0.15,
    //                     //   width: SizeConfig.screenWidth * 0.3,
    //                     //   decoration: BoxDecoration(
    //                     //     border: Border.all(color: Colors.red),
    //                     //     borderRadius: BorderRadius.circular(20),
    //                     //     color: Colors.white,
    //                     //   ),
    //                     //   child: Column(
    //                     //     mainAxisAlignment: MainAxisAlignment.center,
    //                     //     children: [
    //                     //       HeartbeatEffect(Image.asset(
    //                     //         AppImages.noAds,
    //                     //         width: 60,
    //                     //       )),
    //                     //       SizedBox(width: 15),
    //                     //       Text(
    //                     //         'No\nAds',
    //                     //         textAlign: TextAlign.center,
    //                     //         style: TextStyle(
    //                     //             color: Colors.black,
    //                     //             fontSize:
    //                     //                 SizeConfig.blockSizeHorizontal *
    //                     //                     3.5,
    //                     //             fontWeight: FontWeight.bold),
    //                     //       )
    //                     //     ],
    //                     //   ),
    //                     // ),

    //                     // Container(
    //                     //   height: SizeConfig.screenHeight * 0.15,
    //                     //   width: SizeConfig.screenWidth * 0.3,
    //                     //   decoration: BoxDecoration(
    //                     //     border: Border.all(color: Colors.red),
    //                     //     borderRadius: BorderRadius.circular(20),
    //                     //     color: Colors.white,
    //                     //   ),
    //                     //   child: Column(
    //                     //     mainAxisAlignment: MainAxisAlignment.center,
    //                     //     children: [
    //                     //       HeartbeatEffect(Image.asset(
    //                     //         AppImages.upgradeApple,
    //                     //         width: 60,
    //                     //       )),
    //                     //       SizedBox(width: 15),
    //                     //       Text(
    //                     //         'More\nRewards',
    //                     //         textAlign: TextAlign.center,
    //                     //         style: TextStyle(
    //                     //             color: Colors.black,
    //                     //             fontSize:
    //                     //                 SizeConfig.blockSizeHorizontal *
    //                     //                     3.5,
    //                     //             fontWeight: FontWeight.bold),
    //                     //       )
    //                     //     ],
    //                     //   ),
    //                     // ),

    //                     // Container(
    //                     //   color: Colors.blue,
    //                     //   child: Row(
    //                     //     mainAxisSize: MainAxisSize.min,
    //                     //     children: [
    //                     //       HeartbeatEffect(Image.asset(
    //                     //         AppImages.noAds,
    //                     //         width: 60,
    //                     //       )),
    //                     //       SizedBox(width: 15),
    //                     //       Text(
    //                     //         'No Ads',
    //                     //         style: TextStyle(
    //                     //             color: Colors.white,
    //                     //             fontSize: 18,
    //                     //             fontWeight: FontWeight.w400),
    //                     //       )
    //                     //     ],
    //                     //   ),
    //                     // ),
    //                     // Container(
    //                     //   color: Colors.red,
    //                     //   child: Row(
    //                     //     mainAxisSize: MainAxisSize.min,
    //                     //     children: [
    //                     //       HeartbeatEffect(Image.asset(
    //                     //         AppImages.rewardapplesbox,
    //                     //         width: 60,
    //                     //       )),
    //                     //       SizedBox(width: 15),
    //                     //       Text(
    //                     //         'Instant Apples X30',
    //                     //         style: TextStyle(
    //                     //             color: Colors.white,
    //                     //             fontSize: 24,
    //                     //             fontWeight: FontWeight.w400),
    //                     //       ),
    //                     //       Image.asset(
    //                     //         AppImages.applecenter,
    //                     //         color: Colors.red,
    //                     //         width: 25,
    //                     //       ),
    //                     //     ],
    //                     //   ),
    //                     // ),
    //                     // Container(
    //                     //   color: Colors.indigo,
    //                     //   child: Row(
    //                     //     mainAxisSize: MainAxisSize.min,
    //                     //     children: [
    //                     //       HeartbeatEffect(
    //                     //         Image.asset(
    //                     //           AppImages.upgradeApple,
    //                     //           width: 60,
    //                     //         ),
    //                     //       ),
    //                     //       SizedBox(width: 15),
    //                     //       Text(
    //                     //         'Increase Daily Reward',
    //                     //         style: TextStyle(
    //                     //             color: Colors.white,
    //                     //             fontSize: 24,
    //                     //             fontWeight: FontWeight.w400),
    //                     //       )
    //                     //     ],
    //                     //   ),
    //                     // ),
    //                   ],
    //                 ),
    //               )
    //             ],
    //           ),
    //         )
    //       ],
    //     ),
    //     Row(
    //       children: [
    //         SizedBox(width: SizeConfig.screenWidth * 0.06),
    //         Stack(
    //           alignment: Alignment.center,
    //           children: [
    //             Center(
    //               child: CustomPaint(
    //                 size: Size(SizeConfig.screenWidth * 0.55,
    //                     SizeConfig.screenHeight * 0.085),
    //                 painter: EllipsePainter(),
    //               ),
    //             ),
    //             HeartbeatEffect(Text(
    //               'Limited Offer',
    //               // '${PremiumTheme.offering!.availablePackages[2]!.identifier}',
    //               style: TextStyle(
    //                 fontSize: SizeConfig.blockSizeHorizontal * 5,
    //                 fontWeight: FontWeight.bold,

    //                 color: Colors.white, // Customize color as desired
    //               ),
    //             ))
    //           ],
    //         ),
    //       ],
    //     ),
    //     SizedBox(height: SizeConfig.screenWidth * 0.04),
    //     Expanded(
    //       child: Container(
    //         // color: Colors.amber,
    //         child: Stack(
    //           children: [
    //             Positioned(
    //               bottom: 0,
    //               child: SizedBox(
    //                 width: SizeConfig.screenWidth,
    //                 height: SizeConfig.screenHeight * 0.06,
    //                 // color: Colors.grey[300],
    //                 child: CustomPaint(
    //                   painter: BgCurvePainterdown(),
    //                 ),
    //               ),
    //             ),
    //             SizedBox(
    //               width: SizeConfig.screenWidth,
    //               child: Column(
    //                 children: [
    //                   Container(
    //                     // color: Colors.amber,
    //                     width: SizeConfig.screenWidth,
    //                     height: SizeConfig.screenHeight * 0.34,
    //                     child: Column(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       children: [
    //                         if (PremiumTheme
    //                                 .offering!.availablePackages.length ==
    //                             1)
    //                           Column(children: [
    //                             paytile(
    //                                 1,
    //                                 PremiumTheme
    //                                     .offering!.availablePackages[0])
    //                           ]),
    //                         if (PremiumTheme
    //                                 .offering!.availablePackages.length ==
    //                             2)
    //                           Column(children: [
    //                             paytile(
    //                                 1,
    //                                 PremiumTheme
    //                                     .offering!.availablePackages[1]),
    //                             SizedBox(
    //                                 height: SizeConfig.screenHeight * 0.02),
    //                             paytile(
    //                                 2,
    //                                 PremiumTheme
    //                                     .offering!.availablePackages[0])
    //                           ]),
    //                         if (PremiumTheme
    //                                 .offering!.availablePackages.length ==
    //                             3)
    //                           Column(children: [
    //                             paytile(
    //                                 1,
    //                                 PremiumTheme
    //                                     .offering!.availablePackages[1]),
    //                             SizedBox(
    //                                 height: SizeConfig.screenHeight * 0.02),
    //                             paytile(
    //                                 2,
    //                                 PremiumTheme
    //                                     .offering!.availablePackages[0]),
    //                             SizedBox(
    //                                 height: SizeConfig.screenHeight * 0.02),
    //                             paytile(
    //                                 3,
    //                                 PremiumTheme
    //                                     .offering!.availablePackages[2])
    //                           ]),

    //                         // for (int i = 0;
    //                         //     i <
    //                         //         PremiumTheme.offering!
    //                         //             .availablePackages.length;
    //                         //     i++)
    //                         //   Column(children: [
    //                         //     paytile(
    //                         //         i,
    //                         //         PremiumTheme
    //                         //             .offering!.availablePackages[i]),
    //                         //     if (i + 1 !=
    //                         //         PremiumTheme.offering!
    //                         //             .availablePackages.length)
    //                         //       SizedBox(
    //                         //           height:
    //                         //               SizeConfig.screenHeight * 0.02),
    //                         //   ]),

    //                         // paytile(
    //                         //   1,
    //                         //   Column(
    //                         //     mainAxisAlignment:
    //                         //         MainAxisAlignment.center,
    //                         //     children: [
    //                         //       SizedBox(),
    //                         //       Text(
    //                         //         '${PremiumTheme.offering!.availablePackages.length}',
    //                         //         // 'Weekly',
    //                         //         style: TextStyle(
    //                         //             fontSize: 18,
    //                         //             color: Colors.black,
    //                         //             fontWeight: FontWeight.bold),
    //                         //       ),
    //                         //       Row(
    //                         //         mainAxisAlignment:
    //                         //             MainAxisAlignment.center,
    //                         //         children: [
    //                         //           Text(
    //                         //             PremiumTheme
    //                         //                 .weeklyMembershipString,
    //                         //             style: controller.currentSelected!
    //                         //                         .value ==
    //                         //                     1
    //                         //                 ? TextStyle(
    //                         //                     fontSize: 18,
    //                         //                     fontWeight:
    //                         //                         FontWeight.bold,
    //                         //                     color: AppThemeColors
    //                         //                         .onPrimary1)
    //                         //                 : TextStyle(
    //                         //                     fontSize: 16,
    //                         //                     fontWeight:
    //                         //                         FontWeight.bold),
    //                         //           ),
    //                         //           Text(
    //                         //             '  /week',
    //                         //             style: TextStyle(
    //                         //                 fontSize: 12,
    //                         //                 color: Colors.black45,
    //                         //                 fontWeight: FontWeight.w400),
    //                         //           )
    //                         //         ],
    //                         //       ),
    //                         //       Text(
    //                         //         '${(PremiumTheme.weeklyMembership / 7 * 30).toStringAsFixed(2)} per month',
    //                         //         style: TextStyle(
    //                         //           fontSize: 12,
    //                         //           color: Colors.red,
    //                         //           // fontWeight: FontWeight.w500
    //                         //         ),
    //                         //       ),
    //                         //       SizedBox(),
    //                         //     ],
    //                         //   ),
    //                         // ),
    //                         // SizedBox(
    //                         //     height: SizeConfig.screenHeight * 0.02),
    //                         // paytile(
    //                         //   2,
    //                         //   Column(
    //                         //     mainAxisAlignment:
    //                         //         MainAxisAlignment.center,
    //                         //     children: [
    //                         //       SizedBox(),
    //                         //       Text(
    //                         //         'Monthly',
    //                         //         style: TextStyle(
    //                         //             fontSize: 18,
    //                         //             color: Colors.black,
    //                         //             fontWeight: FontWeight.bold),
    //                         //       ),
    //                         //       Row(
    //                         //         mainAxisAlignment:
    //                         //             MainAxisAlignment.center,
    //                         //         children: [
    //                         //           Text(
    //                         //             '${(PremiumTheme.weeklyMembership / 7 * 30).toStringAsFixed(2)}  ',
    //                         //             style: TextStyle(
    //                         //                 fontSize: 14,
    //                         //                 fontWeight: FontWeight.w400,
    //                         //                 color: Colors.black54,
    //                         //                 decoration: TextDecoration
    //                         //                     .lineThrough),
    //                         //           ),
    //                         //           Text(
    //                         //             PremiumTheme
    //                         //                 .monthlyMembershipString,
    //                         //             style: controller.currentSelected!
    //                         //                         .value ==
    //                         //                     2
    //                         //                 ? TextStyle(
    //                         //                     fontSize: 18,
    //                         //                     fontWeight:
    //                         //                         FontWeight.bold,
    //                         //                     color: AppThemeColors
    //                         //                         .onPrimary1)
    //                         //                 : TextStyle(
    //                         //                     fontSize: 16,
    //                         //                     fontWeight:
    //                         //                         FontWeight.bold),
    //                         //           ),
    //                         //           Text(
    //                         //             '  /month',
    //                         //             style: TextStyle(
    //                         //                 fontSize: 12,
    //                         //                 color: Colors.black45,
    //                         //                 fontWeight: FontWeight.w400),
    //                         //           )
    //                         //         ],
    //                         //       ),
    //                         //       Text(
    //                         //         'Save ${(PremiumTheme.weeklyMembership / 7 * 30 - PremiumTheme.monthlyMembership).toStringAsFixed(2)} per month',
    //                         //         style: TextStyle(
    //                         //           fontSize: 12,
    //                         //           color: Colors.red,
    //                         //           // fontWeight: FontWeight.w500
    //                         //         ),
    //                         //       ),
    //                         //       SizedBox(),
    //                         //     ],
    //                         //   ),
    //                         // ),
    //                         // SizedBox(
    //                         //     height: SizeConfig.screenHeight * 0.02),
    //                         // paytile(
    //                         //   3,
    //                         //   Column(
    //                         //     mainAxisAlignment:
    //                         //         MainAxisAlignment.center,
    //                         //     children: [
    //                         //       SizedBox(),
    //                         //       Text(
    //                         //         'Anually',
    //                         //         style: TextStyle(
    //                         //             fontSize: 18,
    //                         //             color: Colors.black,
    //                         //             fontWeight: FontWeight.bold),
    //                         //       ),
    //                         //       Row(
    //                         //         mainAxisAlignment:
    //                         //             MainAxisAlignment.center,
    //                         //         children: [
    //                         //           Text(
    //                         //             '${(PremiumTheme.weeklyMembership / 7 * 365).toStringAsFixed(2)}  ',
    //                         //             style: TextStyle(
    //                         //                 fontSize: 14,
    //                         //                 fontWeight: FontWeight.w400,
    //                         //                 color: Colors.black54,
    //                         //                 decoration: TextDecoration
    //                         //                     .lineThrough),
    //                         //           ),
    //                         //           Text(
    //                         //             PremiumTheme
    //                         //                 .anuallyMembershipString,
    //                         //             style: controller.currentSelected!
    //                         //                         .value ==
    //                         //                     3
    //                         //                 ? TextStyle(
    //                         //                     fontSize: 18,
    //                         //                     fontWeight:
    //                         //                         FontWeight.bold,
    //                         //                     color: AppThemeColors
    //                         //                         .onPrimary1)
    //                         //                 : TextStyle(
    //                         //                     fontSize: 16,
    //                         //                     fontWeight:
    //                         //                         FontWeight.bold),
    //                         //           ),
    //                         //           Text(
    //                         //             '  /year',
    //                         //             style: TextStyle(
    //                         //                 fontSize: 12,
    //                         //                 color: Colors.black45,
    //                         //                 fontWeight: FontWeight.w400),
    //                         //           )
    //                         //         ],
    //                         //       ),
    //                         //       Text(
    //                         //         'Save ${((PremiumTheme.weeklyMembership / 7 * 365) - PremiumTheme.anuallyMembership).toStringAsFixed(2)} per year',
    //                         //         style: TextStyle(
    //                         //           fontSize: 12,
    //                         //           color: Colors.red,
    //                         //           // fontWeight: FontWeight.w500
    //                         //         ),
    //                         //       ),
    //                         //       SizedBox(),
    //                         //     ],
    //                         //   ),
    //                         // ),
    //                       ],
    //                     ),
    //                   ),
    //                   SizedBox(height: SizeConfig.screenHeight * 0.03),
    //                   // AppThemeButton(
    //                   //         onPressed: () {}, text: 'Upgrade Now')
    //                   //     .smallButton(),

    //                   GestureDetector(
    //                     onTap: () {
    //                       RevenueCatService()
    //                           .purchaseSubscriptionWithProduct(
    //                               controller.currentProduct.value!);
    //                     },
    //                     child: Container(
    //                       height: SizeConfig.screenHeight * 0.05,
    //                       width: SizeConfig.screenWidth * 0.7,
    //                       decoration: BoxDecoration(
    //                           borderRadius: BorderRadius.circular(
    //                               SizeConfig.screenHeight * 0.1),
    //                           color: Colors.red,
    //                           // color: AppThemeColors.onPrimary2,
    //                           // color: Colors.red.shade700,
    //                           // border:
    //                           //     Border.all(color: Colors.white, width: 1),
    //                           boxShadow: [
    //                             // BoxShadow(
    //                             //     color: Colors.grey.withOpacity(0.5),
    //                             //     offset: Offset(1, 2),
    //                             //     blurRadius: 4),
    //                             BoxShadow(
    //                                 color: Colors.grey.withOpacity(0.5),
    //                                 offset: Offset(1, 4),
    //                                 blurRadius: 3,
    //                                 spreadRadius: 2)
    //                           ]),
    //                       child: Center(
    //                           child: Text(
    //                         'Subscribe',
    //                         style: TextStyle(
    //                             color: Colors.white,
    //                             // color: Colors.black,
    //                             fontWeight: FontWeight.bold,
    //                             fontSize: 16),
    //                       )),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ],
    // ));
  }

  Padding feature_description(
    Color bgClr,
    String image,
    String desc,
  ) {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 5,
          top: SizeConfig.blockSizeVertical * 1),
      child: Row(
        children: [
          Container(
            height: SizeConfig.blockSizeVertical * 6,
            width: SizeConfig.blockSizeHorizontal * 12,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(SizeConfig.blockSizeHorizontal * 4),
              color: bgClr,
            ),
            child: Center(
              child: Image.asset(
                image,
                width: SizeConfig.blockSizeHorizontal * 6,
                fit: BoxFit.cover,
                color: Colors.white,
              ),
            ),
          ),
          horizontalSpace(SizeConfig.blockSizeHorizontal * 4),
          Text(
            desc,
            style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 4,
                color: Colors.grey.shade900,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

class FeatureTile extends StatelessWidget {
  String img;
  String txt;
  Color color;
  FeatureTile({
    required this.img,
    required this.txt,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * 0.15,
      width: SizeConfig.screenWidth * 0.3,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            img,
            width: 32,
            color: color,
          ),
          SizedBox(width: 15),
          Text(
            txt,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight * 0.4,
      // color: Colors.grey[300],
      child: CustomPaint(
        painter: BgCurvePainter(),
      ),
    );
  }
}

class BgCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [
          AppThemeColors.onPrimary1,
          AppThemeColors.onPrimary2,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    Path path = Path();
    path.lineTo(
        0,
        size.height +
            SizeConfig.screenHeight * 0.015); // Start point at bottom-left
    path.quadraticBezierTo(
      size.width / 2,
      size.height -
          SizeConfig.screenHeight * 0.1 +
          SizeConfig.screenHeight * 0.015, // Control point
      size.width,
      size.height +
          SizeConfig.screenHeight * 0.1 +
          SizeConfig.screenHeight * 0.015, // End point
    );
    path.lineTo(size.width, 0); // Top-right corner
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class EllipsePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      // ..color = Colors.red;
      ..shader = LinearGradient(
        colors: [
          AppThemeColors.onPrimary1,
          AppThemeColors.onPrimary2,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Define an ellipse path
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width,
        height: size.height,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

GestureDetector paytile(int index, Package package) {
  PaywallController controller = Get.find();
  return GestureDetector(
    onTap: () {
      // controller.currentSelected!.value = index;
      controller.currentProduct.value = package.storeProduct;
      print(
          'set to : ${controller.currentProduct}, coming product is ${package.storeProduct}.');
    },
    child: Obx(
      () => Container(
        height: SizeConfig.screenHeight * 0.08,
        width: SizeConfig.screenWidth * 0.85,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade600,
                offset: Offset(1, 5),
                blurRadius: 1,
                spreadRadius: 0)
          ],
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
              color: controller.currentProduct.value == package.storeProduct
                  // color: controller.currentSelected!.value == index
                  ? AppThemeColors.onPrimary1
                  // ? Colors.green
                  : Colors.transparent,
              width: 2),
          // color: Colors.grey.shade100,
          // color: controller.currentSelected!.value == index
          //     ? AppThemeColors.onPrimary2light
          //     : Colors.grey.shade100,
          color: controller.currentProduct.value == package.storeProduct
              // ? Colors.white
              // ? Colors.amber.shade50
              ? const Color.fromARGB(255, 243, 255, 229)
              // ? Colors.grey.shade100
              : Colors.white,
          // : Colors.grey.shade200,
          // gradient: LinearGradient(colors: [
          //   const Color.fromARGB(255, 150, 216, 178),
          //   const Color.fromARGB(255, 191, 240, 140)
          // ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Stack(
          children: [
            if (package.identifier == '\$rc_weekly')
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(),
                  // Text(
                  //   // '${PremiumTheme.offering!.availablePackages.length}',
                  //   'Weekly',
                  //   style: TextStyle(
                  //       fontSize: 18,
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.bold),
                  // ),

                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 15,
                        top: SizeConfig.blockSizeVertical * 1.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          PremiumTheme.weeklyMembershipString,
                          style: controller.currentProduct.value ==
                                  package.storeProduct
                              // style: controller.currentSelected!.value == 1
                              ? TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: AppThemeColors.onPrimary1
                                  // color: Colors.black
                                  )
                              : TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' /week',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black45,
                              fontWeight: FontWeight.w400),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(
                              right: SizeConfig.blockSizeHorizontal * 3),
                          child: Text(
                            // '${PremiumTheme.offering!.availablePackages.length}',
                            'Weekly',
                            style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 3,
                              color: Colors.grey,
                              // fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 15),
                    child: Text(
                      '${(PremiumTheme.weeklyMembership / 7 * 30).toStringAsFixed(2)} per month',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.red,
                        // fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  SizedBox(),
                ],
              ),
            if (package.identifier == '\$rc_monthly')
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(),
                  // Text(
                  //   'Monthly',
                  //   style: TextStyle(
                  //       fontSize: 18,
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.bold),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 15,
                        top: SizeConfig.blockSizeVertical * 1.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Text(
                        //   '${(PremiumTheme.weeklyMembership / 7 * 30).toStringAsFixed(2)}  ',
                        //   style: TextStyle(
                        //       fontSize: 14,
                        //       fontWeight: FontWeight.w400,
                        //       color: Colors.black54,
                        //       decoration: TextDecoration.lineThrough),
                        // ),
                        Text(
                          PremiumTheme.monthlyMembershipString,
                          style: controller.currentProduct.value ==
                                  package.storeProduct
                              // style: controller.currentSelected!.value == 2
                              ? TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: AppThemeColors.onPrimary1)
                              : TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '  /month',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black45,
                              fontWeight: FontWeight.w400),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(
                              right: SizeConfig.blockSizeHorizontal * 3),
                          child: Text(
                            'Monthly',
                            style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 3,
                              color: Colors.grey,
                              // fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 15),
                    child: Text(
                      'Save ${(PremiumTheme.weeklyMembership / 7 * 30 - PremiumTheme.monthlyMembership).toStringAsFixed(2)} per month',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.red,
                        // fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  SizedBox(),
                ],
              ),
            if (package.identifier == '\$rc_annual')
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(),
                  // Text(
                  //   'Anually',
                  //   style: TextStyle(
                  //       fontSize: 18,
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.bold),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 15,
                        top: SizeConfig.blockSizeVertical * 1.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Text(
                        //   '${(PremiumTheme.weeklyMembership / 7 * 365).toStringAsFixed(2)}  ',
                        //   style: TextStyle(
                        //       fontSize: 14,
                        //       fontWeight: FontWeight.w400,
                        //       color: Colors.black54,
                        //       decoration: TextDecoration.lineThrough),
                        // ),
                        Text(
                          PremiumTheme.anuallyMembershipString,
                          style: controller.currentProduct.value ==
                                  package.storeProduct
                              // style: controller.currentSelected!.value == 3
                              ? TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: AppThemeColors.onPrimary1)
                              : TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '  /year',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black45,
                              fontWeight: FontWeight.w400),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(
                              right: SizeConfig.blockSizeHorizontal * 3),
                          child: Text(
                            'Annually',
                            style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 3,
                              color: Colors.grey,
                              // fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 15),
                    child: Text(
                      'Save ${((PremiumTheme.weeklyMembership / 7 * 365) - PremiumTheme.anuallyMembership).toStringAsFixed(2)} per year',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.red,
                        // fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  SizedBox(),
                ],
              ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: controller.currentProduct.value == package.storeProduct
                    ? Icon(
                        Icons.radio_button_checked,
                        // color: Colors.amber,
                        color: AppThemeColors.onPrimary1,
                      )
                    : Icon(
                        Icons.radio_button_off,
                        color: Colors.black45,
                      ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

class BgCurvePainterdown extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [
          AppThemeColors.onPrimary1,
          AppThemeColors.onPrimary2,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    Path path = Path();
    path.moveTo(0, 0); // Start at the top-left corner (point A)
    path.lineTo(
        0, size.height); // Draw line to the bottom-left corner (point B)
    path.lineTo(size.width,
        size.height); // Draw line to the bottom-right corner (point C)
    path.lineTo(size.width, 0 - SizeConfig.screenHeight * 0.015);
// Curved line from bottom-right (point C) to top-left (point A) with an inward curve
    path.quadraticBezierTo(
        size.width * 0.5, // Control point halfway between A and C horizontally
        0 +
            SizeConfig.screenHeight * 0.1 -
            SizeConfig.screenHeight *
                0.015, // Control point inward for the curve
        0, // End point back at top-left corner
        0 - SizeConfig.screenHeight * 0.1);

    path.close(); // Close the path

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// class PaywallViewbefore extends GetView<PaywallController> {
//   const PaywallView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(80),
//           child: appThemeAppBar2(context, 'Membership'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Center(
//             child: Container(
//               width: SizeConfig.screenWidth - 32,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 color: Colors.grey.withOpacity(0.2),
//               ),
//               child: Column(
//                 children: [
//                   SizedBox(height: 20),
//                   Text(
//                     'Upgrade\nyour plan Now',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
//                   ),
//                   SizedBox(height: 15),
//                   Obx(() => Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               controller.currentSelected!.value = 'Banana';
//                             },
//                             child: Container(
//                               height: 30,
//                               width: 80,
//                               decoration: BoxDecoration(
//                                 color: controller.currentSelected!.value ==
//                                         'Banana'
//                                     ? AppThemeColors.onPrimary2
//                                     : Colors.white,
//                                 borderRadius: BorderRadius.circular(6),
//                               ),
//                               child: Center(child: Text('Banana')),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               controller.currentSelected!.value = 'Apple';
//                             },
//                             child: Container(
//                               height: 30,
//                               width: 80,
//                               decoration: BoxDecoration(
//                                 color:
//                                     controller.currentSelected!.value == 'Apple'
//                                         ? AppThemeColors.onPrimary2
//                                         : Colors.white,
//                                 borderRadius: BorderRadius.circular(6),
//                               ),
//                               child: Center(child: Text('Apple')),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               controller.currentSelected!.value = 'Cherry';
//                             },
//                             child: Container(
//                               height: 30,
//                               width: 80,
//                               decoration: BoxDecoration(
//                                 color: controller.currentSelected!.value ==
//                                         'Cherry'
//                                     ? AppThemeColors.onPrimary2
//                                     : Colors.white,
//                                 borderRadius: BorderRadius.circular(6),
//                               ),
//                               child: Center(child: Text('Cherry')),
//                             ),
//                           )
//                         ],
//                       )),
//                   SizedBox(height: 10),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Container(
//                       width: SizeConfig.screenWidth,
//                       height: 300,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Obx(
//                         () => Column(
//                           children: [
//                             SizedBox(height: 5),
//                             if (controller.currentSelected!.value == 'Banana')
//                               Text('Weekly',
//                                   style: TextStyle(
//                                       color: AppThemeColors.onPrimary1,
//                                       fontWeight: FontWeight.bold)),
//                             if (controller.currentSelected!.value == 'Apple')
//                               Text('Monthly',
//                                   style: TextStyle(
//                                       color: AppThemeColors.onPrimary1,
//                                       fontWeight: FontWeight.bold)),
//                             if (controller.currentSelected!.value == 'Cherry')
//                               Text('Annually',
//                                   style: TextStyle(
//                                       color: AppThemeColors.onPrimary1,
//                                       fontWeight: FontWeight.bold)),
//                             Text('Membership',
//                                 style: TextStyle(
//                                     color: AppThemeColors.onPrimary1,
//                                     fontWeight: FontWeight.bold)),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }
// }