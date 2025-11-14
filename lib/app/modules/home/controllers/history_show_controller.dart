import 'package:calories_detector/app/data/Data_Base.dart';
import 'package:calories_detector/app/data/food_item.dart';
import 'package:calories_detector/app/data/oneday.dart';
import 'package:calories_detector/app/routes/app_pages.dart';
import 'package:get/get.dart';

RxList<OneDay> allDays = <OneDay>[].obs;
RxList<FoodData> historyData = <FoodData>[].obs;
RxList<String> historyDate = <String>[].obs;
RxBool checkempty = false.obs;

class HistoryShowController extends GetxController {
  void showResponse(int index) {
    Get.toNamed(Routes.HISTORY_RESPONSE, arguments: [historyData[index]]);
    print(historyData[index]);
  }

  @override
  void onInit() {
    super.onInit();
    getdata();
  }

  void getdata() async {
    print('trying getting data, function works');
    try {
      List<FoodData> data = await DatabaseHelper().fetchFoodData();
      List<String> date = await DatabaseHelper().fetchDate();
      // List<OneDay> alldays = await DatabaseHelper2().fetchAllOneDays();
      // date.reversed;
      // data.reversed;
      historyData.value = data.reversed.toList();
      historyDate.value = date.reversed.toList();
    } catch (e) {
      print('Error fetching data: $e');
    }
    if (historyData.isEmpty) {
      checkempty.value = true;
    } else {
      checkempty.value = false;
    }
  }
}
