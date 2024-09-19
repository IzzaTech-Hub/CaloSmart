import 'package:calories_detector/app/modules/home/controllers/history_show_controller.dart';
import 'package:calories_detector/app/modules/home/views/comparison_view.dart';
import 'package:calories_detector/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:calories_detector/sizeConfig.dart';

Color onSecondaryColor = const Color(0xffFFffff);
Color secondaryColor = Color(0xffFF4D6D);
Color primaryColor = Color(0xffFFD1DC);
Color onPrimaryColor = Color(0xff1E3A5F);
Color tertoryColor = Color(0xffE3D7FF);
Size size = Size(
    SizeConfig.blockSizeHorizontal * 90, SizeConfig.blockSizeHorizontal * 50);

class HistoryShow extends GetView<HistoryShowController> {
  const HistoryShow({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(HistoryViewController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: secondaryColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "History",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: size.height * 0.15,
                ),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.calendar_today,
                color: primaryColor,
                size: size.height * 0.15,
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(() => ListView.builder(
                    // reverse: true,
                    itemCount: controller.historyData.length,
                    itemBuilder: (context, index) {
                      var item = controller.historyData[index];
                      var date = controller.historyDate[index];
                      return Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Stack(children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  // item['item'],
                                  controller.historyData[index].item.name,
                                  style: TextStyle(
                                      height: 1,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  controller
                                      .historyData[index].item.totalCalories
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      height: 1,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 5,
                            bottom: 1,
                            child: Text(
                              date,
                              style: TextStyle(height: 1, fontSize: 10),
                            ),
                          )
                        ]),
                      );
                    },
                  )),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}
