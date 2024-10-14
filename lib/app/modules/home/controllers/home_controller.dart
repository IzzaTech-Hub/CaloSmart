import 'package:calories_detector/app/data/day_base.dart';
import 'package:calories_detector/app/data/oneday.dart';
import 'package:calories_detector/app/notificationservice/local_notification_service.dart';
import 'package:calories_detector/main.dart';
import 'package:calories_detector/sizeConfig.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'dart:math';

// import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'dart:convert';

double padbetween = 0;
// double carbsPercentage = 0.3;
// double protienPercentage = 0.7;
// double fatPercentage = 0.5;
// double progress1 = 0.9;
// double progress2 = 0.5;
// double progress3 = 0.6;
double padsize = 50;
double thickness = 20;
double size = SizeConfig.screenWidth - 175;
Color bgcolor = Colors.white.withOpacity(0.9);
double customopacity = 0.2;
Color color3 = Colors.red;
Color color2 = Colors.blue;
Color color1 = Colors.green;
double size1 = size;
double size2 = size - (thickness + padbetween) * 1;
double size3 = size - (thickness + padbetween) * 2;
OneDay? toDay = OneDay(
  date: '06/10/2024',
  caloriestarget: 3000,
  watertarget: 4,
  exercisetarget: 150,
  fattarget: 44,
  protientarget: 56,
  carbstarget: 225,
);
RxInt? caloriesProgress = 300.obs;
RxInt? caloriestarget = 300.obs;
RxInt? watertarget = 300.obs;
RxDouble? exercisetarget = 300.0.obs;
RxInt? fattarget = 300.obs;
RxInt? protientarget = 300.obs;
RxInt? carbstarget = 300.obs;
RxDouble? waterProgress = 300.0.obs;
RxDouble? exerciseProgress = 300.0.obs;
RxInt? fatProgress = 300.obs;
RxInt? protienProgress = 300.obs;
RxInt? carbsProgress = 300.obs;

RxDouble carbsPercentage = 0.0.obs;
RxDouble protienPercentage = 0.0.obs;
RxDouble fatPercentage = 0.0.obs;
RxDouble progress1 = 0.0.obs;
RxDouble progress2 = 0.0.obs;
RxDouble progress3 = 0.0.obs;
RxInt test = 1.obs;

class HomeController extends GetxController {
  final bool checkForDialog;
  HomeController(this.checkForDialog);

  String nowDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  @override
  void onInit() async {
    test.value = 10;
    try {
      print('Initializing database');

      // Ensure the database is initialized
      await DatabaseHelper2().database;

      print('Database initialized, now fetching today\'s data');

      // Fetch today's data from the database
      try {
        print('Fetching OneDay instance for date: $nowDate');
        toDay = await DatabaseHelper2().fetchOneDay(nowDate);
        // toDay = OneDay(
        //   date: nowDate,
        //   caloriestarget: 5000,
        //   watertarget: 500,
        //   exercisetarget: 500,
        //   fattarget: 500,
        //   protientarget: 500,
        //   carbstarget: 500,
        // );
        // toDay!.update(OneDay(
        //   date: nowDate,
        //   caloriestarget: 5000,
        //   watertarget: 500,
        //   exercisetarget: 500,
        //   fattarget: 500,
        //   protientarget: 500,
        //   carbstarget: 500,
        // ));
        print('${toDay!.caloriestarget}');

        if (toDay == null) {
          print('toDay is still null after fetch, something went wrong.');
        } else {
          print('Successfully fetched or created toDay: $toDay');
        }
      } catch (e) {
        print('Error while fetching OneDay: $e');
      }
    } catch (e) {
      print('Error while initializing database or fetching today: $e');
    }

    caloriestarget?.value = toDay!.caloriestarget.value;
    watertarget?.value = toDay!.watertarget.value.toInt();
    exercisetarget?.value = toDay!.exercisetarget.value;
    fattarget?.value = toDay!.fattarget.value;
    protientarget?.value = toDay!.protientarget.value;
    carbstarget?.value = toDay!.carbstarget.value;

    caloriesProgress?.value = toDay!.caloriesProgress.value;
    waterProgress?.value = toDay!.waterProgress.value;
    exerciseProgress?.value = toDay!.exerciseProgress.value;
    fatProgress?.value = toDay!.fatProgress.value;
    protienProgress?.value = toDay!.proteinProgress.value;
    carbsProgress?.value = toDay!.carbsProgress.value;
    double tempcarbs = toDay!.carbsProgress / toDay!.carbstarget.value;
    double tempprotien = toDay!.proteinProgress / toDay!.protientarget.value;
    double tempfat = toDay!.fatProgress / toDay!.fattarget.value;
    double tempp1 = toDay!.caloriesProgress / toDay!.caloriestarget.value;
    double tempp2 = toDay!.waterProgress / toDay!.watertarget.value;
    double tempp3 = toDay!.exerciseProgress / toDay!.exercisetarget.value;

// Carbs percentage (progress over target)
    if (tempcarbs <= 1) {
      carbsPercentage.value = tempcarbs; // Carbs progress is within target
    } else {
      carbsPercentage.value = 1; // Max out at 100%
    }

// Protein percentage (progress over target)
    if (tempprotien <= 1) {
      protienPercentage.value = tempprotien;
    } else {
      protienPercentage.value = 1;
    }

// Fat percentage (progress over target)
    if (tempfat <= 1) {
      fatPercentage.value = tempfat;
    } else {
      fatPercentage.value = 1;
    }

// Calories percentage (progress over target)
    if (tempp1 <= 1) {
      progress1.value = tempp1;
    } else {
      progress1.value = 1;
    }

// Water percentage (progress over target)
    if (tempp2 <= 1) {
      progress2.value = tempp2;
    } else {
      progress2.value = 1;
    }

// Exercise percentage (progress over target)
    if (tempp3 <= 1) {
      progress3.value = tempp3;
    } else {
      progress3.value = 1;
    }

    if (checkForDialog) {
      Get.dialog(
        AlertDialog(
          title: Text('Disclaimer'),
          content: Text(
              textAlign: TextAlign.justify,
              'The nutritional information provided by this app is intended for informational purposes only and should not be considered a substitute for professional dietary advice. While we strive to offer accurate estimates of calories and nutrients based on the food images provided, the data may not always be 100% accurate due to variations in food preparation, portion sizes, and other factors. Users should use this information as a general guide and consult a healthcare professional for precise dietary recommendations.'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }

    handlePushNotification();

    super.onInit();
  }

  void updatehomedata() {
    // test!.value = 100;
    print('update function call');
    print('${toDay!.caloriesProgress.value}');
    caloriestarget!.value = toDay!.caloriestarget.value;
    watertarget!.value = toDay!.watertarget.value.toInt();
    exercisetarget!.value = toDay!.exercisetarget.value;
    fattarget!.value = toDay!.fattarget.value;
    protientarget!.value = toDay!.protientarget.value;
    carbstarget!.value = toDay!.carbstarget.value;

    caloriesProgress!.value = toDay!.caloriesProgress.value;
    waterProgress!.value = toDay!.waterProgress.value;
    exerciseProgress!.value = toDay!.exerciseProgress.value;
    fatProgress!.value = toDay!.fatProgress.value;
    protienProgress!.value = toDay!.proteinProgress.value;
    carbsProgress!.value = toDay!.carbsProgress.value;
    double tempcarbs = toDay!.carbsProgress / toDay!.carbstarget.value;
    double tempprotien = toDay!.proteinProgress / toDay!.protientarget.value;
    double tempfat = toDay!.fatProgress / toDay!.fattarget.value;
    double tempp1 = toDay!.caloriesProgress / toDay!.caloriestarget.value;
    double tempp2 = toDay!.waterProgress / toDay!.watertarget.value;
    double tempp3 = toDay!.exerciseProgress / toDay!.exercisetarget.value;

// Carbs percentage (progress over target)
    if (tempcarbs <= 1) {
      carbsPercentage.value = tempcarbs; // Carbs progress is within target
    } else {
      carbsPercentage.value = 1; // Max out at 100%
    }

// Protein percentage (progress over target)
    if (tempprotien <= 1) {
      protienPercentage.value = tempprotien;
    } else {
      protienPercentage.value = 1;
    }

// Fat percentage (progress over target)
    if (tempfat <= 1) {
      fatPercentage.value = tempfat;
    } else {
      fatPercentage.value = 1;
    }

// Calories percentage (progress over target)
    if (tempp1 <= 1) {
      progress1.value = tempp1;
    } else {
      progress1.value = 1;
    }

// Water percentage (progress over target)
    if (tempp2 <= 1) {
      progress2.value = tempp2;
    } else {
      progress2.value = 1;
    }

// Exercise percentage (progress over target)
    if (tempp3 <= 1) {
      progress3.value = tempp3;
    } else {
      progress3.value = 1;
    }

    print('$progress1');
    print('${caloriesProgress!.value}');
  }

  // Future<void> pickImageFromCamera() async {
  //   try {
  // final XFile? image = await _picker.pickImage(source: ImageSource.camera);
  //     if (image != null) {
  //       File imageFile = File(image.path);
  //       print('Image Path: ${image.path}');
  //       sendImageToGoogleAI(imageFile); // Send image to Gemini
  //     }
  //   } catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  //   // try {
  //   //   final XFile? image = await _picker.pickImage(source: ImageSource.camera);
  //   //   if (image != null) {
  //   //     File imageFile = File(image.path);
  //   //     print('Image Path: ${image.path}');
  //   //     sendImageToGoogleAI(imageFile); // Send image to Gemini
  //   //   }
  //   // } catch (e) {
  //   //   print('Failed to pick image: $e');
  //   // }
  // }

  final count = 0.obs;

  void increment() => count.value++;

  handlePushNotification() async {
    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }
}

class Graph extends StatelessWidget {
  Graph({
    super.key,
    required this.size,
    required this.color,
    required this.progress,
  });

  double size;
  Color color;
  double progress;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              width: size - padsize,
              height: size - padsize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              )),
          CustomPaint(
            size: Size(size - padsize, size - padsize),
            painter:
                CircularProgressPainter(progress: progress, thiscolor: color),
          ),
          Container(
            width: size - padsize,
            height: size - padsize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  // const Color.fromARGB(255, 255, 81, 69),
                  // // const Color.fromARGB(255, 98, 7, 0),
                  // const Color.fromARGB(255, 255, 197, 193),
                  // const Color.fromARGB(255, 255, 81, 69),
                  // const Color.fromARGB(255, 98, 7, 0),
                  Colors.black.withOpacity(0.2),
                  // Colors.transparent,
                  Colors.white.withOpacity(0.3),
                  Colors.black.withOpacity(0.2),
                  // color.bgdark.withOpacity(customopacity),
                  // color.bglight.withOpacity(customopacity),
                  // color.bgdark.withOpacity(customopacity),
                ],
                stops: [0.9, 0.95, 1],
              ),
            ),
          ),
          Center(
            child: Container(
              width: size -
                  padsize -
                  thickness, // Size of the inner circle (smaller to create a border effect)
              height: size - padsize - thickness,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: bgcolor, // Inner circle background color
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  double progress; // Progress value from 0.0 to 1.0
  Color thiscolor;
  CircularProgressPainter({required this.progress, required this.thiscolor});

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = thickness / 2; // Thickness of the progress bar

    // Define center and radius for the circle
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = (size.width / 2) - strokeWidth / 2;

    // Background circle (empty progress bar)
    Paint backgroundPaint = Paint()
      ..color = Colors.transparent
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round; // Rounded edges for the progress bar

    // Draw the background circle
    canvas.drawCircle(center, radius, backgroundPaint);

    // Paint for the progress arc
    Paint progressPaint = Paint()
      ..color = thiscolor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round; // Rounded edges for the progress bar

    // Define start angle and sweep angle for the progress arc
    double startAngle = -pi / 2; // Start from the top of the circle
    double sweepAngle =
        2 * pi * progress; // The amount of the circle to be filled

    // Draw the progress arc
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        sweepAngle, false, progressPaint);

    // Create a path for the inner container
    Paint innerContainerPaint = Paint()
      ..color = Colors.white // Color of the inner container
      ..style = PaintingStyle.fill; // Fill the inner container

    // Define the inner container size
    double innerRadius = radius * 0.8; // Inner radius (80% of the outer radius)

    // Draw the inner container as a filled circle
    canvas.drawCircle(center, innerRadius, innerContainerPaint);
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress; // Repaint if progress changes
  }
}
