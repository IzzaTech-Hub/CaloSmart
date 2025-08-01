import 'package:calories_detector/app/modules/utills/Themes/current_theme.dart';
import 'package:calories_detector/app/routes/app_pages.dart';
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
                onTap: () {},
                child: Container(
                  height: 60, // Fixed height for uniformity
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Set Your Goal:',
                        style: TextStyle(fontSize: 16),
                      ),
                      DropdownButton<String>(
                        value: controller.selectedGoal.value.isEmpty
                            ? null
                            : controller.selectedGoal.value,
                        icon: Icon(Icons.arrow_drop_down),
                        underline: SizedBox(), // Hide underline
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            controller.saveSelectedGoal(newValue);
                          }
                          print('Changed');
                          Get.snackbar('Notice',
                              'Changes will apply to your diet from Tomorrow',
                              snackPosition: SnackPosition.BOTTOM);
                        },
                        items: <String>[
                          'Gain Weight',
                          'Lose Weight',
                          'Maintain Weight'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              )),
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
