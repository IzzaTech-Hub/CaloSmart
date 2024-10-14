import 'package:calories_detector/app/modules/home/controllers/history_show_controller.dart';
import 'package:calories_detector/app/modules/utills/Themes/current_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:calories_detector/sizeConfig.dart';

Size size = Size(
    SizeConfig.blockSizeHorizontal * 90, SizeConfig.blockSizeHorizontal * 50);

class HistoryShow extends GetView<HistoryShowController> {
  const HistoryShow({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(HistoryViewController());
    return Obx(
      () => Container(
        decoration: BoxDecoration(gradient: AppThemeColors.bgGradient),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: ListView.builder(
              // reverse: true,
              itemCount: historyData.length,
              itemBuilder: (context, index) {
                var item = historyData[index];
                var date = historyDate[index];
                return InkWell(
                  onTap: () {
                    controller.showResponse(index);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
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
                              historyData[index].item.name,
                              style: TextStyle(
                                  height: 1,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              historyData[index].item.totalCalories.toString(),
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
                  ),
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}

class HistoryShowAppBar extends StatelessWidget {
  const HistoryShowAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return appThemeAppBar(context, 'History');
  }
}
