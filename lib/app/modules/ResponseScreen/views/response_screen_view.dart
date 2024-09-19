import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:calories_detector/sizeConfig.dart';
import '../controllers/response_screen_controller.dart';

class ResponseScreenView extends GetView<ResponseScreenController> {
  const ResponseScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
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
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: controller.imageFile.value,
                ),
              ),
              Positioned(
                  child: SafeArea(
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: secondaryColor,
                    )),
              ))
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 10, bottom: 5),
            child: Text(
              controller.foodData.value!.item.name,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                  color: Colors.black),
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
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w700,
                        color: secondaryColor,
                        height: 1),
                  ),
                  Text('Calories',
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w700,
                          color: secondaryColor,
                          height: 1))
                ],
              ),
              SizedBox(
                width: SizeConfig.screenWidth * 0.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.foodData.value!.item.totalCalories.toString(),
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                        color: onPrimaryColor,
                        height: 1),
                  ),
                  Text(
                    'Kcal',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: secondaryColor,
                        height: 1),
                  ),
                  Text(
                    // quantity,
                    controller.foodData.value!.item.quantity,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: secondaryColor,
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
                  right: 0,
                  child: Container(
                    width: SizeConfig.screenWidth * 0.8,
                    height: SizeConfig.screenHeight * 0.1225,
                    // height: 100,
                    color: onSecondaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(),
                            Text(
                              'Carbs',
                              style: TextStyle(
                                  color: Color(0xffFF69B4),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20),
                            ),
                            Text(
                              'Protien',
                              style: TextStyle(
                                  // color: Color(0xffFFD700),
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20),
                            ),
                            Text(
                              'Fat',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20),
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
                              // '$carbsW g',
                              '${controller.foodData.value!.item.carbs} g',
                              style: TextStyle(
                                  color: Color(0xffFF69B4),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17),
                            ),
                            Text(
                              // '$protienW g',
                              '${controller.foodData.value!.item.protein} g',
                              style: TextStyle(
                                  color: Colors.blue,
                                  // color: Color(0xffFFD700),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17),
                            ),
                            Text(
                              '${controller.foodData.value!.item.fat} g',
                              // '$fatW g',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17),
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
                              style: TextStyle(
                                  color: Color(0xffFF69B4),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17),
                            ),
                            Text(
                              '${controller.foodData.value!.item.percentageCaloriesFromProtein} %',
                              // '$protienp %',
                              style: TextStyle(
                                  color: Colors.blue,
                                  // color: Color(0xffFFD700),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17),
                            ),
                            Text(
                              '${controller.foodData.value!.item.percentageCaloriesFromFat} %',
                              // '$fatp %',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17),
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
                    child: Container(
                      // Set the overall size of the container to constrain the pie chart
                      height: SizeConfig.screenHeight * 0.1225,

                      width: SizeConfig.screenWidth * 0.4, // Set the desired width
                      child: PieChart(
                        PieChartData(
                          sectionsSpace: 0, // No space between sections
                          centerSpaceRadius: 0, // No space in the center
                          sections: [
                            PieChartSectionData(
                              color: Color(0xffFF69B4),
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
                              color: Colors.blue,
                              value: controller.foodData.value!.item
                                  .percentageCaloriesFromProtein
                                  .toDouble(),
                              // value: protienp.toDouble(),
                              title: '',
                              radius: SizeConfig.screenHeight *
                                  0.06125, // Adjust radius to fit within the container
                            ),
                            PieChartSectionData(
                              color: Colors.green,
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
                  left: SizeConfig.screenWidth * 0.2 - SizeConfig.screenHeight * 0.06125,
                  child: Container(
                    height: SizeConfig.screenHeight * 0.1225,
                    width: SizeConfig.screenHeight * 0.1225,
                    child: Center(
                      child: Container(
                        // Set the overall size of the container to constrain the pie chart
                        height: SizeConfig.screenHeight * 0.1,
                        width: SizeConfig.screenHeight * 0.1,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(100)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.foodData.value!.item.totalCalories
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 23,
                                  color: onPrimaryColor,
                                  fontWeight: FontWeight.w800,
                                  height: 1.1),
                            ),
                            Text(
                              'Kcal',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: onPrimaryColor,
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
                    color: onSecondaryColor,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 8, 0, 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'After Consuming this:',
                            style: TextStyle(
                                height: 1,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(),
                          // List of bullet points
                          Row(children: [
                            SizedBox(width: 10),
                            Icon(Icons.circle, size: 8),
                            Text(
                              // '  $waterQ',
                              'Drink ${controller.foodData.value!.item.waterquantity} ltr(s) of water',
                              style: TextStyle(height: 0),
                            ),
                          ]),
                          Row(children: [
                            SizedBox(width: 10),
                            Icon(Icons.circle, size: 8),
                            Text(
                              // '  $exerciseQ',
                              'Exercise for ${controller.foodData.value!.item.exercise} hour(s)',
                              style: TextStyle(height: 0),
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
                  right: SizeConfig.screenWidth * 0.2 - SizeConfig.screenHeight * 0.06125,
                  child: Container(
                    height: SizeConfig.screenHeight * 0.1225,
                    width: SizeConfig.screenHeight * 0.1225,
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                      child: Container(
                        // Set the overall size of the container to constrain the pie chart
                        height: SizeConfig.screenHeight * 0.1,
                        width: SizeConfig.screenHeight * 0.1,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(100)),
                        child: Center(
                            child: Text(
                          'Tips',
                          style: TextStyle(
                              color: onPrimaryColor,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
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
              // SizedBox(width: screenWidth * 0.05),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: secondaryColor,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: SizedBox(
                    width: SizeConfig.screenWidth * 0.3,
                    child: Center(
                      child: Text(
                        'Compare',
                        style: TextStyle(
                            color: onSecondaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: secondaryColor,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: SizedBox(
                    width: SizeConfig.screenWidth * 0.3,
                    child: Center(
                      child: Text('Alternative',
                          style: TextStyle(
                              color: onSecondaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ),
                  ),
                ),
              ),
              // SizedBox(width: screenWidth * 0.05),
            ],
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.025),
          Center(
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: secondaryColor,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: InkWell(
                  // onTap: controller.logFeed(controller.foodData.value!),
                  onTap: () {
  if (controller.foodData.value != null) {
    controller.logFeed(controller.foodData.value!);
  } else {
    print('FoodData is null.');
  }
},

                  child: SizedBox(
                    width: SizeConfig.screenWidth * 0.5,
                    child: Center(
                      child: Text('Log food',
                          style: TextStyle(
                              color: onSecondaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.025)
        ],
      ),
    );
  }
}
