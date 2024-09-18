
import 'package:calories_detector/app/modules/home/controllers/history_show_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryShow extends GetView<HistoryShowController> {
  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(HistoryViewController());
    return Scaffold(
        body:
        
        ListView.builder(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item['item'],
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
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
                );
              },
            ));
  }
}
