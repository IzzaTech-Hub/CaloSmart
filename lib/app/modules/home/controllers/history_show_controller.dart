import 'package:calories_detector/app/data/Data_Base.dart';
import 'package:calories_detector/app/data/Runtime_List_Handeler.dart';
import 'package:calories_detector/app/data/food_item.dart';
import 'package:get/get.dart';

class HistoryShowController extends GetxController {
  RxList<FoodData> historyData = <FoodData>[].obs;

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
      historyData.value = data; // Assign the fetched data to historyData
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
