import 'package:get/get.dart';

class HistoryShowController extends GetxController {
  final RxList<Map<String, dynamic>> historyData = <Map<String, dynamic>>[
    {'item': 'A Piece of Piece', 'calories': '360 Kcal'},
    {'item': 'A pizza slice', 'calories': '1,250 Kcal'},
    {'item': 'A Piece of Cake', 'calories': '360 Kcal'},
    {'item': 'Strawberry cake', 'calories': '360 Kcal'},
  ].obs;

  // Directly expose history data as it doesn't need to be grouped by date anymore
  List<Map<String, dynamic>> get ungroupedHistoryData => historyData;
}
