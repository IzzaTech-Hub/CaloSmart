import 'package:calories_detector/app/modules/utills/Themes/current_theme.dart';
import 'package:flutter/material.dart';
// import 'package:launch_review/launch_review.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../controllers/settings_controller.dart';
// import 'package:flutter_web_browser/flutter_web_browser.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Set Your Goal List Item
          Obx(() => GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: Get.context!,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: ['Gain Weight', 'Lose Weight', 'Maintain Weight']
                    .map((option) {
                  bool isSelected = controller.selectedGoal.value == option;
                  return InkWell(
                    onTap: () {
                      controller.saveSelectedGoal(option);
                      Navigator.pop(context);
                      Get.snackbar(
                        'Notice',
                        'Changes will apply to your diet from Tomorrow',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 24),
                      margin: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.blue.withOpacity(0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: isSelected
                            ? Border.all(color: Colors.blue, width: 1.5)
                            : null,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            option,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isSelected ? Colors.blue : Colors.black87,
                            ),
                          ),
                          if (isSelected)
                            Icon(Icons.check, color: Colors.blue, size: 20),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        );
      },
      child: Container(
        height: 65,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Set Your Goal:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Row(
              children: [
                Text(
                  controller.selectedGoal.value.isEmpty
                      ? 'Select'
                      : controller.selectedGoal.value,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.arrow_drop_down, color: Colors.black54),
              ],
            ),
          ],
        ),
      ),
    ))
,
          // SizedBox(height: 20),
          Divider(
            height: 20,
          ),
          // Rate Us List Item with Icon Behind Text and Right Arrow
          InkWell(
            onTap: () async {
              // Logic to rate the app
              // Get.snackbar('Info', 'Navigate to Rate Us');
              // LaunchReview.launch(
              //   androidAppId: "com.ai.caloriescanner.calorietracker",
              // );
              controller.openPlayStoreReview();
            },
            child: Container(
              height: 60, // Fixed height for uniformity
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow), // Rate Us Icon
                      SizedBox(width: 10),
                      Text(
                        'Rate Us',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios,
                      color: Colors.grey), // Right Arrow
                ],
              ),
            ),
          ),
          // SizedBox(height: 20),
          Divider(
            height: 20,
          ),

          // Share List Item with Icon Behind Text and Right Arrow
          InkWell(
            onTap: () {
              // Logic to share the app
              // Get.snackbar('Info', 'Share this app with others');
              Share.share(
                  "Consider downloading this exceptional app, available on the Google Play Store at the following link: https://play.google.com/store/apps/details?id=com.ai.caloriecounter.scanner");
            },
            child: Container(
              height: 60, // Fixed height for uniformity
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.share, color: Colors.green), // Share Icon
                      SizedBox(width: 10),
                      Text(
                        'Share',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios,
                      color: Colors.grey), // Right Arrow
                ],
              ),
            ),
          ),
          Divider(
            height: 20,
          ),
          InkWell(
            // splashColor: Colors.transparent,
            // highlightColor: Colors.transparent,
            onTap: () async {
              controller.openPrivacyPolicy();
              // Get.toNamed(Routes.WEBVIEW);
            },
            child: Container(
              height: 60, // Fixed height for uniformity
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.privacy_tip,
                          color: Colors.blue), // Rate Us Icon
                      SizedBox(width: 10),
                      Text(
                        'Privacy Policy',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios,
                      color: Colors.grey), // Right Arrow
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsViewAppBar extends GetView<SettingsController> {
  const SettingsViewAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return appThemeAppBar(context, 'Settings');
  }
}
