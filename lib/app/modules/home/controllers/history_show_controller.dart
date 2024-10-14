import 'package:calories_detector/app/data/Data_Base.dart';
import 'package:calories_detector/app/data/food_item.dart';
import 'package:calories_detector/app/routes/app_pages.dart';
import 'package:get/get.dart';

RxList<FoodData> historyData = <FoodData>[].obs;
RxList<String> historyDate = <String>[].obs;
// void UpdateHistoryData() {
//   historyData = <FoodData>[].obs;
//   historyDate = <String>[].obs;
//   print('historydataupdated');
//   print(historyData.length);
// }

class HistoryShowController extends GetxController {
  void showResponse(int index) {
    Get.toNamed(Routes.HISTORY_RESPONSE, arguments: [historyData[index]]);
    print(historyData[index]);
  }

  // This will be called when the controller is initialized
  @override
  void onInit() {
    super.onInit();
    getdata(); // Fetch the data when the controller is initialized
  }

  // Method to fetch data asynchronously and update historyData
  void getdata() async {
    print('trying getting data, function works');
    try {
      List<FoodData> data = await DatabaseHelper().fetchFoodData();
      List<String> date = await DatabaseHelper().fetchDate();
      // date.reversed;
      // data.reversed;
      historyData.value = data.reversed.toList();
      historyDate.value = date.reversed.toList();
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}
  // final RxList<Map<String, dynamic>> historyData = <Map<String, dynamic>>[
  //   {'item': 'A Piece of Piece', 'calories': '360 Kcal'},
  //   {'item': 'A pizza slice', 'calories': '1,250 Kcal'},
  //   {'item': 'A Piece of Cake', 'calories': '360 Kcal'},
  //   {'item': 'Strawberry cake', 'calories': '360 Kcal'},
  // ].obs;

  // Directly expose history data as it doesn't need to be grouped by date anymore
  // List<Map<String, dynamic>> get ungroupedHistoryData => historyData;
