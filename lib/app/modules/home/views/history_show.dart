import 'package:calories_detector/app/modules/home/controllers/history_show_controller.dart';
import 'package:calories_detector/app/modules/home/views/comparison_view.dart';
import 'package:calories_detector/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Color onSecondaryColor = const Color(0xffFFffff);
Color secondaryColor = Color(0xffFF4D6D);
Color primaryColor = Color(0xffFFD1DC);
Color onPrimaryColor = Color(0xff1E3A5F);

class HistoryShow extends GetView<HistoryShowController> {
  const HistoryShow({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(HistoryViewController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: secondaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
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
        body: ListView.builder(
          itemCount: controller.historyData.length,
          itemBuilder: (context, index) {
            var item = controller.historyData[index];
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              padding: EdgeInsets.all(15),
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
              child: Stack(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item['item'],
                        
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        item['calories'],
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Text("Date"))
                ],
              ),
            );
          },
        ));
  }
}
