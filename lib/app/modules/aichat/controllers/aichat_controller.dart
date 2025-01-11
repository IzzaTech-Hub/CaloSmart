import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class AichatController extends GetxController {
  // final List<String> defaultPrompts = [
  //   "What are the best foods for weight loss?",
  //   "How many calories should I consume daily?",
  //   "What are good sources of protein?",
  //   "Can you suggest a quick healthy breakfast?",
  //   "What are the benefits of eating vegetables?"
  // ];

  final List<String> defaultPrompts = [
    "What are the best foods for weight loss?",
    "How many calories should I consume daily?",
    "What are good sources of protein?",
    "Can you suggest a quick healthy breakfast?",
    "What are the benefits of eating vegetables?",
    "How can I reduce sugar in my diet?",
    "What is a balanced diet?",
    "Can you give me a meal plan for weight loss?",
    "What are healthy snacks for kids?",
    "How can I control my portion sizes?",
    "What foods boost energy levels?",
    "What are the benefits of drinking more water?",
    "How do I start intermittent fasting?",
    "Can you suggest low-carb dinner ideas?",
    "What are the best fruits for weight loss?",
    "How do I maintain muscle while dieting?",
    "What are some plant-based protein options?",
    "Can I lose weight without exercise?",
    "What are the benefits of eating nuts and seeds?",
    "Can you recommend a high-fiber diet?",
    "How can I make my meals more filling?",
    "What are the best foods for a keto diet?",
    "What are the best pre-workout meals?",
    "What should I eat to recover after a workout?",
    "How can I reduce belly fat?",
    "What are good sources of healthy fats?",
    "Can you suggest a meal plan for diabetics?",
    "What are the best foods for better skin?",
    "What foods should I avoid for better sleep?",
    "How can I increase my metabolism?",
    "What are some quick lunch ideas for work?",
    "What are the benefits of eating fish?",
    "How much protein do I need per day?",
    "What are the best dairy-free calcium sources?",
    "How do I avoid overeating?",
    "Can you suggest a gluten-free diet plan?",
    "What are some iron-rich foods?",
    "How can I stay full longer?",
    "What are the benefits of eating eggs?",
    "What is the best time to eat carbs?",
    "How can I reduce salt in my diet?",
    "Can you give me a list of superfoods?",
    "What are some healthy alternatives to junk food?",
    "What should I eat before bedtime?",
    "What foods help with digestion?",
    "Can I drink coffee while dieting?",
    "How do I plan meals for a family?",
    "What are some high-protein breakfast ideas?",
    "What are the best foods to boost immunity?",
    "How can I stick to my diet while traveling?",
    "Can you suggest some dairy-free snacks?",
    "What are the benefits of eating oats?",
    "How can I curb my cravings for sweets?",
    "What are the best foods for heart health?",
    "What foods are high in Vitamin C?",
    "What are some quick and healthy dinner recipes?",
    "How can I add more vegetables to my meals?",
    "What foods help reduce stress?",
    "Can I eat chocolate on a diet?",
    "How do I plan meals on a budget?",
    "What foods should I eat during pregnancy?",
    "What are some healthy options for kids’ lunchboxes?",
    "What are the best foods for brain health?",
    "How can I eat healthy at restaurants?",
    "What are the best smoothies for weight loss?",
    "How can I meal prep for the week?",
    "Can you recommend a high-protein vegetarian diet?",
    "What are the benefits of eating avocados?",
    "How do I avoid hidden sugars in foods?",
    "What are some quick and healthy snacks for work?",
    "What foods help with bloating?",
    "What are the best foods for strong bones?",
    "How do I manage my diet on a busy schedule?",
    "Can you recommend a high-fiber breakfast?",
    "What are the best foods to eat during menopause?",
    "How can I stay hydrated besides drinking water?",
    "What are the best foods for a vegan diet?",
    "What is the best way to lose weight after 40?",
    "How can I improve my gut health?",
    "What are the benefits of eating fermented foods?",
    "How can I include more whole grains in my diet?",
    "Can you suggest a low-sodium meal plan?",
    "What foods help reduce cholesterol?",
    "What are the best foods for building muscle?",
    "How can I eat more mindfully?",
    "Can you suggest a sugar-free diet plan?",
    "What foods are rich in antioxidants?",
    "How can I reduce my appetite naturally?",
    "What are the benefits of eating legumes?",
    "What is the best way to gain weight healthily?",
    "How can I eat clean on a budget?",
    "What foods help reduce inflammation?",
    "Can you recommend a dairy-free diet plan?",
    "What are the best snacks for weight gain?",
    "What are the best foods for eye health?",
    "How can I manage my diet while breastfeeding?",
    "What are the benefits of eating whole foods?",
    "How can I reduce cravings for fried food?",
    "What is the best way to detox naturally?",
    "Can you recommend a low-fat meal plan?"
  ];

  List<String> getRandomPrompts() {
    final List<String> tempPrompts = List.from(defaultPrompts);
    tempPrompts.shuffle();
    return tempPrompts.take(3).toList();
  }

  List<String> randomPrompts = [];

  final List<
      ({
        Image? image,
        String? text,
        bool fromUser,
        RxBool isFeedBack,
        RxBool isGood
      })> generatedContent = <({
    Image? image,
    String? text,
    bool fromUser,
    RxBool isFeedBack,
    RxBool isGood
  })>[];

  final count = 0.obs;
  @override
  void onInit() {
    randomPrompts = getRandomPrompts();

    // EasyLoading.init();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
  void newDefaultPrompts() {
    randomPrompts = getRandomPrompts();
  }

// void reportMessage(BuildContext context, String message) {
  void reportMessage(BuildContext context, String message, int index) async {
    String uniqueid = await Purchases.appUserID;
    final TextEditingController customReasonController =
        TextEditingController();
    List<String> reasons = [
      "harmful/Unsafe",
      "Sexual Explicit Content",
      'Repetitive',
      'Hate and harrasment',
      'Misinformation',
      'Frauds and scam',
      "Spam",
      "Other"
    ];
    RxString selectedReason = "".obs;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Report Inappropriate Message"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Select a reason:"),
                ...reasons.map((reason) {
                  return Obx(() => RadioListTile(
                        title: Text(reason),
                        value: reason,
                        groupValue: selectedReason.value,
                        onChanged: (value) {
                          selectedReason.value = value!;
                          if (selectedReason != "Other") {
                            customReasonController.clear();
                          }
                        },
                      ));
                }).toList(),
                Obx(() => selectedReason.value == "Other"
                    ? TextField(
                        controller: customReasonController,
                        decoration: InputDecoration(
                          labelText: "Enter custom reason",
                        ),
                      )
                    : Container()),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("Report"),
              onPressed: () async {
                String reportReason = selectedReason.value == "Other"
                    ? customReasonController.text
                    : selectedReason.value;
                print('$reportReason');
                if (reportReason.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please select or enter a reason.")),
                  );
                  return;
                }

                EasyLoading.show(status: "Please Wait...");
                print('now easyloading');
                try {
                  // HomeViewCTL homeViewCTL = Get.find();
                  // Save report in Firestore
                  await FirebaseFirestore.instance
                      .collection('reported_messages')
                      .doc('${uniqueid}')
                      // .doc('${gender_title.value}_${homeViewCTL.uniqueId}')
                      .set({
                    'message': message,
                    // 'senderId': homeViewCTL.uniqueId ?? "1234",
                    'senderId': uniqueid,
                    // 'messageId': gender_title.value,
                    // 'messageId': index,
                    'reason': reportReason,
                    'reportedAt': DateTime.now(),
                  });
                  // await FirebaseFirestore.instance
                  //     .collection('reported_messages')
                  //     .add({
                  //   'message': message,
                  //   'senderId': homeViewCTL.uniqueId ?? "1234",
                  //   'messageId': gender_title.value,
                  //   'reason': reportReason,
                  //   'reportedAt': DateTime.now(),
                  // });
                  print('now ending easyloading');

                  Navigator.of(context).pop();
                  EasyLoading.dismiss();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Message reported successfully.")),
                  );
                  generatedContent[index].isFeedBack.value = true;
                  generatedContent[index].isGood.value = false;
                } catch (e) {
                  print(e);
                  EasyLoading.dismiss();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to report message: $e")),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  // void GoodResponse(String message) {
  void GoodResponse(String message, int index) {
    print("GoodResponse reported..");
    // feedbackMessages.add(message);
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(content: Text("Feedback saved successfully")),
    );
    print("GoodResponse reported....");

    generatedContent[index].isFeedBack.value = true;
    generatedContent[index].isGood.value = true;
    // chatList[index].isFeedBack.value = true;
    // chatList[index].isGood.value = true;
  }
}
