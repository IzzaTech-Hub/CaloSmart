import 'package:get/get.dart';

class AgeController extends GetxController {
  final count = 0.obs;
  RxInt selectedNumber = 6.obs; // Assuming a starting age, adjust as needed.

  void increment() => count.value++;
}
