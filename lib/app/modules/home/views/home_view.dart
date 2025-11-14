import 'package:calories_detector/app/data/food_item.dart';
import 'package:calories_detector/app/modules/navbar/controllers/navbar_controller.dart';
import 'package:calories_detector/app/modules/utills/app_images.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:calories_detector/SizeConfig.dart';
import 'package:calories_detector/app/modules/utills/Themes/current_theme.dart';
import 'package:calories_detector/app/premium/premium.dart';
import 'package:calories_detector/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:path/path.dart';
import '../controllers/home_controller.dart';

double convertToGlasses(int quantity, String unit) {
  switch (unit) {
    case 'cups':
      return quantity *
          0.96; // 1 cup = 0.24 liters, 1 glass = 0.25 liters, so 1 cup = 0.96 glasses
    case 'liters':
      print('${quantity * 4}');
      return quantity * 4.0; // 1 liter = 4 glasses (1 glass = 0.25 liters)
    case 'glasses':
    default:
      return quantity
          .toDouble(); // If the unit is already 'glasses', return as is
  }
}

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  // GetxController controlller = HomeController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Obx(() => SingleChildScrollView(
          child: Container(
            height: SizeConfig.screenHeight,
            // color: Colors.white.withOpacity(0.9),
            color: Colors.grey.shade100,
            // color: Colors.grey[],
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        // color: Colors.black12,
                      ),
                      child: Column(
                        children: [
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Graph(
                                    size: size1,
                                    color: color1,
                                    progress: progress1.value,
                                  ),
                                  Graph(
                                    size: size2,
                                    color: color2,
                                    progress: progress2.value,
                                  ),
                                  Graph(
                                    size: size3,
                                    color: color3,
                                    progress: progress3.value,
                                  ),
                                  Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          caloriestarget!.value -
                                                      caloriesProgress!.value <
                                                  0
                                              ? 'Completed'
                                              : '${caloriestarget!.value - caloriesProgress!.value}',
                                          style: TextStyle(
                                              color: caloriestarget!.value -
                                                          caloriesProgress!
                                                              .value <
                                                      0
                                                  ? Colors.green
                                                  : Colors.black87,
                                              fontSize: caloriestarget!.value -
                                                          caloriesProgress!
                                                              .value <
                                                      0
                                                  ? 14
                                                  : 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        if (caloriestarget!.value -
                                                caloriesProgress!.value >
                                            0)
                                          Text(
                                            'Remainig',
                                            style: TextStyle(
                                                color: Colors.black38),
                                          )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(),
                              SizedBox(
                                height: size - padsize,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(),
                                    // SizedBox(),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        AutoSizeText(
                                          "Today's Goal ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                          minFontSize: 8,
                                          maxLines: 1,
                                          maxFontSize: 28,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox()
                                      ],
                                    ),
                                    SizedBox(),
                                    // SizedBox(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            // color: Colors.black,
                                            height: 35,
                                            width: 35,
                                            child: Image.asset(
                                              AppImages.iconCalories,
                                              color: Colors.green,
                                            )),
                                        Column(
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Food',
                                              style: TextStyle(
                                                height: 1,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  '$caloriesProgress',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    height: 1,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                                Text(
                                                  '/$caloriestarget',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.black45,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      height: 1),
                                                ),
                                                Text(
                                                  ' Kcal',
                                                  style: TextStyle(
                                                      fontSize: 9,
                                                      color: Colors.black38,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      height: 1),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox()
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            // color: Colors.black,
                                            height: 35,
                                            width: 35,
                                            child: Image.asset(
                                              AppImages.iconWater,
                                              color: const Color.fromARGB(
                                                  255, 93, 199, 248),
                                            )),
                                        Column(
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Water',
                                              style: TextStyle(
                                                height: 1,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  '${(waterProgress!.value % 1 == 0 ? waterProgress!.value.toInt() : waterProgress!.value.toStringAsFixed(1))}',
                                                  style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontSize: 14,
                                                      height: 1),
                                                ),
                                                Text(
                                                  '/$watertarget',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.black38,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      height: 1),
                                                ),
                                                Text(
                                                  ' Glass',
                                                  style: TextStyle(
                                                      fontSize: 9,
                                                      color: Colors.black38,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      height: 1),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox()
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            // color: Colors.black,
                                            height: 35,
                                            width: 35,
                                            child: Image.asset(
                                              AppImages.iconExercise,
                                              color: Colors.red,
                                            )),
                                        Column(
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Exercise',
                                              style: TextStyle(
                                                height: 1,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  '${(exerciseProgress!.value % 1 == 0 ? exerciseProgress!.value.toInt() : exerciseProgress!.value.toStringAsFixed(1))}',
                                                  style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontSize: 14,
                                                      height: 1),
                                                ),
                                                Text(
                                                  '/${(exercisetarget!.value % 1 == 0 ? exercisetarget!.value.toInt() : exercisetarget!.value.toStringAsFixed(1))}',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: Colors.black38,
                                                      height: 1),
                                                ),
                                                Text(
                                                  ' hrs',
                                                  style: TextStyle(
                                                      fontSize: 9,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: Colors.black38,
                                                      height: 1),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox()
                                      ],
                                    ),
                                    SizedBox(),
                                    // SizedBox(),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconNeutrants(
                                  AppImages.iconProtien,
                                  'Protien',
                                  protienProgress!,
                                  protientarget!,
                                  protienPercentage,
                                  const Color(0xff0164FD)),
                              IconNeutrants(
                                  AppImages.iconFat,
                                  'Fat',
                                  fatProgress!,
                                  fattarget!,
                                  fatPercentage,
                                  const Color(0xffFF8000)),
                              IconNeutrants(
                                  AppImages.iconCarbs,
                                  'Carbs',
                                  carbsProgress!,
                                  carbstarget!,
                                  carbsPercentage,
                                  const Color(0xff039D09)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      CustomCard(
                        title: 'Food',
                        imagePath: AppImages.foodBanner,
                        onPressed: () {
                          dialogueforfood(context);
                        },
                        clr: Colors.green,
                      ),
                      CustomCard(
                        title: 'Water',
                        imagePath: AppImages.waterBanner,
                        onPressed: () {
                          dialogueforwater(context);
                        },
                        clr: Colors.blue,
                      ),
                      CustomCard(
                        title: 'Exercise',
                        imagePath: AppImages.exersicebanner,
                        onPressed: () {
                          dialogueforexercise(context);
                        },
                        clr: Colors.red,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Column IconNeutrants(String img, String name, RxInt value, RxInt target,
      RxDouble progress, Color clr) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          name,
          style:
              TextStyle(fontWeight: FontWeight.bold, color: clr, fontSize: 16),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            // 🔹 Soft shadow added around the image
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color:
                        clr.withOpacity(0.15), // same color tone, subtle glow
                    blurRadius: 25, // softness of the shadow
                    spreadRadius: 2, // how far it spreads
                    offset: const Offset(0, 10), // slight downward shift
                  ),
                ],
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  img,
                  width: (SizeConfig.screenWidth * 0.85) / 3,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(
              width: (SizeConfig.screenWidth * 0.5) / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' $value/$target',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox(
                            height: 10,
                            child: LinearProgressIndicator(
                              value: progress.value,
                              backgroundColor: Colors.black12,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                progress.value < 0.3
                                    ? Colors.red
                                    : (progress.value < 0.5
                                        ? Colors.orange
                                        : (progress.value < 0.8
                                            ? Colors.amber
                                            : Colors.green)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: SizeConfig.screenWidth * 0.02),
                    ],
                  ),
                  const Text(''),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onPressed;
  final Color clr;

  const CustomCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onPressed,
    required this.clr,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          // color: clr,
        ),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Image.asset(
                imagePath,
                fit: BoxFit.fitHeight,
                alignment: Alignment.centerLeft,
                // width: double.infinity,
                height: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0),
              // padding: const EdgeInsets.only(left: 24.0),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: clr
                    // color: Colors.white
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.add_circle,
                  color: clr,
                  // color: Colors.white,
                  // color: Colors.black26,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeViewAppBar extends GetView<HomeController> {
  const HomeViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return appThemeAppBar(context, 'Home');
  }
}

dialogueforfood(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        elevation: 10,
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            gradient: AppThemeColors.knowledgeGradient,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select an Option',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.5,
                    shadows: [
                      Shadow(
                        color: Colors.black38,
                        offset: Offset(0, 1),
                        blurRadius: 2,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Would you like to enter data manually or scan an item?',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        if ((Premium.instance.apple!.value >=
                            PremiumTheme.manualEntryPrice)) {
                          dialogueformanualdata(context);
                        } else {
                          Get.toNamed(Routes.STREAK);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Not enough Apples."),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child:
                                // const Text(
                                //   'Manual Data',
                                //   style: TextStyle(
                                //     color: Colors.black,
                                //     fontWeight: FontWeight.w600,
                                //     fontSize: 0,
                                //   ),
                                // ),
                                // const SizedBox(width: 60),
                                Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  AppImages.manual,
                                  height: 30,
                                  width: 30,
                                  color: Colors.red,
                                ),
                                // Text(
                                //   '${PremiumTheme.manualEntryPrice}',
                                //   style: const TextStyle(
                                //       color: Colors.white,
                                //       fontSize: 11,
                                //       fontWeight: FontWeight.bold),
                                // )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        if ((Premium.instance.apple!.value >=
                            PremiumTheme.scanPrice)) {
                          dialogueforscan(context);
                        } else {
                          Get.toNamed(Routes.STREAK);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Not enough Apples."),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Scan',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                AppImages.apple2,
                                height: 30,
                                color: Colors.red,
                              ),
                              Text(
                                '${PremiumTheme.scanPrice}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

dialogueforscan(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: AppThemeColors.buttonColor,
            borderRadius: BorderRadius.circular(15), // Keep gradient rounded
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select an Option',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Make title stand out on gradient
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Would you like to select an item from your gallery or take a new picture?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // Navigator.of(context).pop();
                        Get.back();
                        NavbarController navbarController = Get.find();

                        navbarController.pickImageFromGallery();
                        // navbarController.index.value = 2;
                        // NavbarController().resetFunction();
                        // print('reseted');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: Icon(Icons.photo, color: AppThemeColors.onPrimary1),
                      label: Text('Gallery',
                          style: TextStyle(color: Colors.black)),
                    ),
                    SizedBox(),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Get.toNamed(Routes.CAMERA_SCREEN);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: Icon(Icons.camera_alt,
                          color: AppThemeColors.onPrimary1),
                      label:
                          Text('Camera', style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

dialogueformanualdata(BuildContext context, {String? fn, int? cal}) {
  RxBool showNutrients = false.obs;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: AppThemeColors.buttonColor,
            borderRadius: BorderRadius.circular(15), // Keep gradient rounded
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: StatefulBuilder(
              builder: (context, setState) {
                String foodName = fn ?? '';
                RxInt calories = (cal ?? 0).obs;
                // RxInt carbs = 0.obs;
                // RxInt protein = 0.obs;
                // RxInt fat = 0.obs;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Enter Manual Data',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: TextEditingController(text: foodName),
                      onChanged: (value) {
                        foodName = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Food Item Name',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller:
                          TextEditingController(text: calories.toString()),
                      onChanged: (value) {
                        calories.value = int.parse(value);
                        // protein.value = calories.value;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Calories',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (foodName == '') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Food Name Can't be empty"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else if (calories.value == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Calories Can't be empty"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else if (calories.value > 2000) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Please enter a realistic calorie value.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          FoodData manualFoodDataObject = FoodData(
                              item: FoodItem(
                                  name: foodName,
                                  quantity: '1',
                                  fat: double.parse(((calories.value * 0.2) / 9)
                                      .toStringAsFixed(1)),
                                  carbs: double.parse(((calories.value * 0.5) / 4)
                                      .toStringAsFixed(1)),
                                  protein: double.parse(
                                      ((calories.value * 0.3) / 4)
                                          .toStringAsFixed(1)),
                                  waterQuantity: 1,
                                  exercise: 1,
                                  vitamins: {},
                                  minerals: {},
                                  additionalNutrients: {},
                                  allergens: [],
                                  dietCompatibility: [],
                                  warnings: [],
                                  healthScore: 5),
                              alternate1: FoodItem(
                                  name: 'Manual',
                                  quantity: '1',
                                  fat: double.parse(
                                      ((calories.value * 0.2) / 9).toStringAsFixed(1)),
                                  carbs: double.parse(((calories.value * 0.5) / 4).toStringAsFixed(1)),
                                  protein: double.parse(((calories.value * 0.3) / 4).toStringAsFixed(1)),
                                  waterQuantity: 1,
                                  exercise: 1,
                                  vitamins: {},
                                  minerals: {},
                                  additionalNutrients: {},
                                  allergens: [],
                                  dietCompatibility: [],
                                  warnings: [],
                                  healthScore: 5),
                              description: '');
                          HomeController homeController;

                          if (Get.isRegistered<HomeController>()) {
                            homeController = Get.find<HomeController>();
                          } else {
                            homeController = Get.put(HomeController());
                          }
                          homeController.logFeed(manualFoodDataObject);
                          Premium.instance
                              .reduce1(PremiumTheme.manualEntryPrice);
                          Navigator.of(context).pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child:
                          Text('Save', style: TextStyle(color: Colors.black)),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );
    },
  );
}

void dialogueforwater(BuildContext context, {int? sg}) {
  RxInt selectedGlasses =
      (sg ?? 0).obs; // Tracks the number of selected glasses
  // selectedGlasses.value = sg!;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: AppThemeColors.knowledgeGradient,

            // color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Water Intake',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),

              // Glasses of water grid
              Obx(
                () => Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: List.generate(
                    6, // Number of glasses to display
                    (index) => GestureDetector(
                      onTap: () {
                        selectedGlasses.value = index + 1; // Update selection
                      },
                      child: index < selectedGlasses.value
    ? Image.asset(
        AppImages.filledGlass,
        width: 50,
        height: 50,
      )
    : ColorFiltered(
        colorFilter: ColorFilter.mode(
          Colors.white.withOpacity(0.35), // reduce opacity effect
          BlendMode.modulate,
        ),
        child: Image.asset(
          AppImages.emptyGlass,
          width: 50,
          height: 50,
        ),
      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Submit button
              ElevatedButton.icon(
                onPressed: () {
                  // // Store the selected number of glasses
                  // double waterInLiters =
                  //     selectedGlasses.value * 0.25; // Example: 1 glass = 250ml
                  // Navigator.of(context).pop();
                  // toDay!.AddWater(waterInLiters);
                  toDay!.AddWater(selectedGlasses.value.toDouble());
                  HomeController().updatehomedata();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: Icon(Icons.check, color: AppThemeColors.onPrimary1),
                label: Text(
                  'Submit',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

dialogueforexercise(BuildContext context, {int? mins}) {
  showDialog(
  context: context,
  builder: (BuildContext context) {
    RxInt selectedMinutes = ((mins ?? 1) + 1).obs;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppThemeColors.onPrimary1.withOpacity(0.95),
              const Color.fromARGB(255, 86, 248, 53).withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with subtle divider
              Text(
                'Set Exercise Duration',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                height: 2,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 25),

              // Time selector
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      "Select Minutes",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(
                      () => NumberPicker(
                        minValue: 1,
                        maxValue: 120,
                        value: selectedMinutes.value,
                        onChanged: (newValue) =>
                            selectedMinutes.value = newValue,
                        itemHeight: 40,
                        textStyle: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                        selectedTextStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            top:
                                BorderSide(color: Colors.grey.shade300, width: 1),
                            bottom:
                                BorderSide(color: Colors.grey.shade300, width: 1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Cancel
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 22),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                          children: const [
                            Icon(Icons.close_rounded,
                                color: Colors.white, size: 20),
                            SizedBox(width: 6),
                            Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),),]
                    ),
                  ),

                  // Submit
                  ElevatedButton.icon(
                    onPressed: () {
                      int exerciseTimeInMinutes = selectedMinutes.value;
                      Navigator.of(context).pop(exerciseTimeInMinutes);
                      toDay!.AddExercise((exerciseTimeInMinutes - 1) / 60);
                      HomeController().updatehomedata();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 4,
                    ),
                    icon: Icon(
                      Icons.check_circle_rounded,
                      color: AppThemeColors.onPrimary1,
                    ),
                    label: Text(
                      'Confirm',
                      style: TextStyle(
                        color: AppThemeColors.onPrimary1,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  },
);
}
