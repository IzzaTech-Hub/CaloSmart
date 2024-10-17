import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsController extends GetxController {
  var selectedGoal = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadSelectedGoal();
  }

  Future<void> loadSelectedGoal() async {
    final prefs = await SharedPreferences.getInstance();
    selectedGoal.value = prefs.getString('selected_button') ?? 'Gain Weight';
  }

  Future<void> saveSelectedGoal(String goal) async {
    final prefs = await SharedPreferences.getInstance();
    selectedGoal.value = goal;
    await prefs.setString('selected_button', goal);
  }

  void openPlayStoreReview() async {
    // const Uri playStoreUrl = 'com.ai.caloriescanner.calorietracker';
    final Uri playStoreUrl = Uri.parse(
        'https://play.google.com/store/apps/details?id=com.ai.caloriescanner.calorietracker');

    // const Uri = 'com.ai.caloriescanner.calorietracker';
    if (await canLaunchUrl(playStoreUrl)) {
      await launchUrl(playStoreUrl);
    } else {
      throw 'Could not launch $playStoreUrl';
    }
  }

  // void openPrivacyPolicy() async {
  //   // const Uri playStoreUrl = 'com.ai.caloriescanner.calorietracker';
  //   // final Uri privacyPolicyUri = Uri.parse(
  //   //     'https://docs.google.com/document/d/1p3TlpUixPKvev9rMR-bo3tv-8yOvf6n3/edit?usp=drive_link&ouid=116035705295374336742&rtpof=true&sd=true');
  //   final Uri privacyPolicyUri = Uri.parse(
  //       'https://docs.google.com/document/d/1p3TlpUixPKvev9rMR-bo3tv-8yOvf6n3/edit?usp=drive_link&ouid=116035705295374336742&rtpof=true&sd=true');
  //   print('uri made');
  //   // const Uri = 'com.ai.caloriescanner.calorietracker';
  //   if (await canLaunchUrl(privacyPolicyUri)) {
  //     await launchUrl(privacyPolicyUri);
  //   } else {
  //     throw 'Could not launch $privacyPolicyUri';
  //   }
  // }

  void openPrivacyPolicy() async {
    // Define the URI for the privacy policy document
    // final Uri privacyPolicyUri = Uri.parse(
    //     'https://play.google.com/store/apps/details?id=com.ai.caloriescanner.calorietracker');
    final Uri privacyPolicyUri = Uri.parse('https://www.google.com');
    // final Uri privacyPolicyUri = Uri.parse(
    //     'https://docs.google.com/document/d/1p3TlpUixPKvev9rMR-bo3tv-8yOvf6n3/edit?usp=drive_link&ouid=116035705295374336742&rtpof=true&sd=true');

    print('URI created: $privacyPolicyUri');

    // Check if the URL can be launched
    if (await canLaunchUrl(privacyPolicyUri)) {
      // Launch the URL
      await launchUrl(privacyPolicyUri);
      print('Launching privacy policy URL...');
    } else {
      // Throw an error if the URL cannot be launched
      throw 'Could not launch $privacyPolicyUri';
    }
  }


}
