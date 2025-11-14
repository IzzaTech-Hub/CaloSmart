import 'package:calories_detector/app/modules/home/controllers/history_show_controller.dart';
import 'package:calories_detector/app/modules/utills/Themes/current_theme.dart';
import 'package:calories_detector/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:calories_detector/sizeConfig.dart';
// import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

Size size = Size(
    SizeConfig.blockSizeHorizontal * 90, SizeConfig.blockSizeHorizontal * 50);

// class HistoryShow extends GetView<HistoryShowController> {
//   const HistoryShow({super.key});
//   @override
//   Widget build(BuildContext context) {
//     // final controller = Get.put(HistoryViewController());
//     return Obx(
//       () => Container(
//         decoration: BoxDecoration(gradient: AppThemeColors.bgGradient),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 10,
//             ),
//             Expanded(
//                 child: ListView.builder(
//               // reverse: true,
//               itemCount: historyData.length,
//               itemBuilder: (context, index) {
//                 var item = historyData[index];
//                 var date = historyDate[index];
//                 return InkWell(
//                   onTap: () {
//                     controller.showResponse(index);
//                   },
//                   child: Container(
//                     margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//                     padding: EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.3),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: Stack(children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 10),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               // item['item'],
//                               historyData[index].item.name,
//                               style: TextStyle(
//                                   height: 1,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               historyData[index].item.totalCalories.toString(),
//                               style: TextStyle(
//                                   fontSize: 16,
//                                   height: 1,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.grey),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Positioned(
//                         right: 5,
//                         bottom: 1,
//                         child: Text(
//                           date,
//                           style: TextStyle(height: 1, fontSize: 10),
//                         ),
//                       )
//                     ]),
//                   ),
//                 );
//               },
//             )),
//           ],
//         ),
//       ),
//     );
//   }
// }

class HistoryShow extends GetView<HistoryShowController> {
  const HistoryShow({super.key});

  @override
  Widget build(BuildContext context) {
    // Group the historyData by date
    final Map<String, List<dynamic>> groupedHistory = {};
    for (int i = 0; i < historyData.length; i++) {
      String date = historyDate[i];
      if (!groupedHistory.containsKey(date)) {
        groupedHistory[date] = [];
      }
      groupedHistory[date]!.add(historyData[i]);
    }

    return Obx(() => checkempty.value
        ? Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade50,

              // gradient: LinearGradient(
              //   colors: [Colors.greenAccent.shade100, Colors.green.shade300],
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              // ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.history,
                      size: 80,
                      color: Colors.grey.shade400,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'No History Available',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'There is nothing to show now. Log your food to see it in history.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 30),
                    // Steps to save food
                    Column(
                      children: [
                        _buildStepCard(
                          stepNumber: 1,
                          stepTitle: 'Take an Image of Your Food',
                          stepDescription:
                              'Capture a picture of your meal to log its details.',
                        ),
                        SizedBox(height: 10),
                        _buildStepCard(
                          stepNumber: 2,
                          stepTitle: 'Log the Food',
                          stepDescription:
                              'Save your meal by click log food button to track your history.',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(gradient: AppThemeColors.bgGradient),
            child: ListView(
              children: groupedHistory.entries.map((entry) {
                String date = entry.key;
                List<dynamic> items = entry.value;

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3.0, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Text(
                          date ==
                                  DateFormat('dd/MM/yyyy')
                                      .format(DateTime.now())
                              ? 'Today'
                              : (date ==
                                      DateFormat('dd/MM/yyyy').format(
                                          DateTime.now()
                                              .subtract(Duration(days: 1)))
                                  ? 'Yesterday'
                                  : date),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      // List of Items
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: items.asMap().entries.map((entry) {
                            int index = entry.key;
                            var item = entry.value;

                            return Column(
                              children: [
                                if (index > 0)
                                  Divider(
                                    color: Colors.green,
                                    height: 1,
                                    thickness: 1,
                                    indent: 10,
                                    endIndent: 10,
                                  ),
                                ListTile(
                                  title: Text(
                                    item.item.name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${item.item.totalCalories} Kcal',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                  onTap: () {
                                    // Navigate to HistoryResponseView with the FoodData object
                                    Get.toNamed(
                                      Routes.HISTORY_RESPONSE,
                                      arguments: [
                                        item
                                      ], // Passing the FoodData object as an argument
                                    );
                                  },
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ));
  }
}

class HistoryShowAppBar extends StatelessWidget {
  const HistoryShowAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return appThemeAppBar(context, 'History');
  }
}

Widget _buildStepCard({
  required int stepNumber,
  required String stepTitle,
  required String stepDescription,
}) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    elevation: 3,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Step $stepNumber',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 8),
          Text(
            stepTitle,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 6),
          Text(
            stepDescription,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    ),
  );
}
