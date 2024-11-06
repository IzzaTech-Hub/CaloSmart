import 'package:calories_detector/app/modules/utills/Themes/current_theme.dart';
import 'package:calories_detector/app/modules/utills/Themes/theme1.dart';
import 'package:calories_detector/app/modules/utills/app_images.dart';
import 'package:calories_detector/app/premium/premium.dart';
import 'package:calories_detector/sizeConfig.dart';
import '../controllers/streak_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StreakView extends GetView<StreakController> {
  StreakView({super.key});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      double offset = ((controller.currentDay!.value + 1) * 70.0) -
          (SizeConfig.screenWidth / 2) -
          10;

      _scrollController.animateTo(
        offset,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: Colors.grey.shade100,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: appThemeAppBar2(context, 'Daily Reward'),
      ),
      body: Column(
        children: [
          Obx(() => StreakCount(_scrollController)),
          // Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Text('Daily Rewards')
                  RewardCollector(),
                  StreakRewardView(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Container StreakCount(
  ScrollController _scrollController,
) {
  StreakController controller = StreakController();
  return Container(
    height: 44,
    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
    child: ListView.builder(
      controller: _scrollController, // Assign scroll controller
      scrollDirection: Axis.horizontal,
      itemCount: controller.totalDays + 2, // Add extra items for spacing
      itemBuilder: (context, index) {
        if (index == 0 || index == controller.totalDays + 1) {
          return SizedBox(width: 40);
        }

        RxBool isCompleted = (index - 2 < controller.currentDay!.value).obs;
        return Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // color: Colors.white,
                border: Border.all(
                  color: isCompleted.value
                      ? Colors.amber
                      : Colors.grey.withOpacity(0.15),
                  width: 5,
                ),
              ),
              child: Center(
                child: Text(
                  '${index - 1}',
                  style: TextStyle(
                    color: isCompleted.value ? Colors.black : Colors.grey[400],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (index < controller.totalDays)
              Container(
                width: 30,
                height: 5,
                color: isCompleted.value
                    ? Colors.amber
                    : Colors.grey.withOpacity(0.1),
              ),
          ],
        );
      },
    ),
  );
}

class RewardCollector extends StatelessWidget {
  // RewardCollector({super.key});

  final RxInt currentDay = 2.obs;

  // Use this constructor in case you need to pass any external parameters
  RewardCollector({super.key}) {
    if (Premium.instance.isrewardCollected!.value) {
      currentDay.value = Premium.instance.currentStreak!.value;
    } else {
      currentDay.value = Premium.instance.currentStreak!.value + 1;
    }
  }

  // Function to create the container for each day
  Widget dayContainer(int day) {
    return Obx(() => Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: SizeConfig.screenWidth * 0.28,
              height: SizeConfig.screenWidth * 0.28,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(SizeConfig.screenWidth * 0.04),
                // border: Border.all(
                //   color: day < currentDay.value
                //       ? Colors.grey.shade300
                //       : (day == currentDay.value
                //           ? ThemeColors.onPrimary1
                //           : Colors.green.shade100),
                // width: 2,
                // ),
                color: day < currentDay.value
                    ? Colors.black.withOpacity(0.04)
                    : (day == currentDay.value
                        ? ThemeColors.onPrimary2.withOpacity(0.3)
                        : Colors.white),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Day $day',
                    style: TextStyle(
                      color: day < currentDay.value
                          ? Colors.grey.shade600
                          : (day == currentDay.value
                              ? ThemeColors.onPrimary1
                              : Colors.black),
                      fontSize: SizeConfig.screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppImages.applecenter,
                          height: SizeConfig.screenWidth * 0.035),
                      Text(
                        Premium.instance.isPremium!.value
                            ? 'X${PremiumTheme.paidTokens[day - 1]}'
                            : 'X${PremiumTheme.freeTokens[day - 1]}',
                        style: TextStyle(
                          fontSize: SizeConfig.screenWidth * 0.035,
                          fontWeight: FontWeight.bold,
                          color: day < currentDay.value
                              ? Colors.grey.shade600
                              : (day == currentDay.value
                                  ? Colors.black
                                  : Colors.black87),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      if (!Premium.instance.toDay!.isRewardCollected.value) {
                        Premium.instance.rewardCollected();
                      }
                    },
                    child: rewardbutton(day, currentDay.value),
                  ),
                ],
              ),
            ),
            if (Premium.instance.isrewardCollected!.value &&
                day == currentDay.value)
              Container(
                width: SizeConfig.screenWidth * 0.28,
                height: SizeConfig.screenWidth * 0.28,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(SizeConfig.screenWidth * 0.04),
                  color: Colors.grey.withOpacity(0.3),
                ),
              ),
            if (Premium.instance.isrewardCollected!.value &&
                day == currentDay.value)
              Icon(
                Icons.check_circle_outline_rounded,
                color: Colors.white,
                size: SizeConfig.screenWidth * 0.15,
              ),
          ],
        ));
  }

  Widget day7Container(int day) {
    return Container(
      width: SizeConfig.screenWidth * 0.88,
      height: SizeConfig.screenWidth * 0.28,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.screenWidth * 0.04),
        // border: Border.all(
        //   color: day < currentDay.value
        //       ? Colors.grey.shade300
        //       : (day == currentDay.value
        //           ? ThemeColors.onPrimary1
        //           : Colors.green.shade100),
        //   width: 2,
        // ),
        color: day < currentDay.value
            ? Colors.black12
            : (day == currentDay.value
                // ? ThemeColors.onPrimary1.withOpacity(0.1)
                ? ThemeColors.onPrimary2.withOpacity(0.3)
                : Colors.white),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 20,
            child: Image.asset(
              AppImages.rewardapplesbox,
              height: SizeConfig.screenWidth * 0.16,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Transform.flip(
              flipX: true,
              child: Image.asset(
                AppImages.rewardapplesbox,
                height: SizeConfig.screenWidth * 0.24,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Day $day or Above',
                style: TextStyle(
                  color: day < currentDay.value
                      ? Colors.grey.shade600
                      : (day == currentDay.value ? Colors.green : Colors.black),
                  fontSize: SizeConfig.screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.applecenter,
                      height: SizeConfig.screenWidth * 0.035),
                  Text(
                    Premium.instance.isPremium!.value
                        ? 'X${PremiumTheme.paidTokens[day - 1]}'
                        : 'X${PremiumTheme.freeTokens[day - 1]}',
                    style: TextStyle(
                      fontSize: SizeConfig.screenWidth * 0.035,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              rewardbutton(day, currentDay.value),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.screenWidth * 0.04),
      child: Container(
        // height: SizeConfig.screenWidth * 0.92,
        padding: EdgeInsets.fromLTRB(
            0, SizeConfig.screenWidth * 0.02, 0, SizeConfig.screenWidth * 0.02),
        decoration: BoxDecoration(
          // color: Colors.white.withGreen(255),
          color: Colors.black.withOpacity(0.04),
          // gradient: LinearGradient(colors: [
          //         AppThemeColors.onPrimary1.withOpacity(0.4),
          //         Colors.amber.withOpacity(0.4)
          //       ]),
          borderRadius: BorderRadius.circular(SizeConfig.screenWidth * 0.05),
        ),
        child: Column(
          children: [
            Text(
              'Daily Reward',
              style: TextStyle(
                  color: AppThemeColors.onPrimary1,
                  fontSize: 22,
                  fontWeight: FontWeight.w500),
            ),
            Transform.scale(
              scale: 0.95,
              child: Column(
                children: [
                  // SizedBox(height: SizeConfig.screenWidth * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      dayContainer(1),
                      dayContainer(2),
                      dayContainer(3),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenWidth * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      dayContainer(4),
                      dayContainer(5),
                      dayContainer(6),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenWidth * 0.02),
                  day7Container(7),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Padding StreakRewardView() {
  Widget Milestone(int points, Widget child1, Widget child2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: SizeConfig.screenWidth * 0.28,
          width: SizeConfig.screenWidth * 0.28,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              SizeConfig.screenWidth * 0.04,
            ),
            color: Colors.white,
          ),
          child: child1,
        ),
        Column(
          children: [
            Container(
              height: SizeConfig.screenWidth * 0.2,
              width: 5,
              color: AppThemeColors.onPrimary1,
            ),
            Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                      color: AppThemeColors.onPrimary1,
                      width: 4,
                      strokeAlign: BorderSide.strokeAlignOutside)),
              child: Center(
                child: Text(
                  '$points',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
            Container(
              height: SizeConfig.screenWidth * 0.2,
              width: 5,
              color: AppThemeColors.onPrimary1,
            ),
          ],
        ),
        Container(
          height: SizeConfig.screenWidth * 0.28,
          width: SizeConfig.screenWidth * 0.28,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              SizeConfig.screenWidth * 0.04,
            ),
            color: Colors.white,
          ),
          child: child2,
        ),
      ],
    );
  }

  return Padding(
    padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 0),
    child: Container(
      // height: SizeConfig.screenWidth * 0.92,
      decoration: BoxDecoration(
        // gradient: LinearGradient(colors: [
        //   AppThemeColors.onPrimary1.withOpacity(0.4),
        //   Colors.amber.withOpacity(0.4)
        // ]),
        color: Colors.black.withOpacity(0.04),
        // color: Colors.white.withGreen(255),
        borderRadius: BorderRadius.circular(SizeConfig.screenWidth * 0.05),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: SizeConfig.screenWidth * 0.02),
          Text(
            'Speciel Rewards',
            style: TextStyle(
                // color: Colors.amber,
                color: AppThemeColors.onPrimary1,
                fontSize: 22,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(height: SizeConfig.screenWidth * 0.04),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  // color: Colors.blue,
                  width: SizeConfig.screenWidth * 0.3,
                  child: Center(
                      child: Text(
                    'Free',
                    style: TextStyle(
                        color: Colors.indigo,
                        // color: AppThemeColors.onPrimary1,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ))),
              Column(
                children: [
                  Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                            color: AppThemeColors.onPrimary1,
                            width: 4,
                            strokeAlign: BorderSide.strokeAlignOutside)),
                    child: Center(child: Text('0')),
                  ),
                  Container(
                    height: SizeConfig.screenWidth * 0.08,
                    width: 5,
                    color: AppThemeColors.onPrimary1,
                  ),
                ],
              ),
              Container(
                  // color: Colors.blue,
                  width: SizeConfig.screenWidth * 0.3,
                  child: Center(
                      child: Text(
                    'Premium',
                    style: TextStyle(
                        color: Colors.amber,
                        // color: AppThemeColors.onPrimary1,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  )))
            ],
          ),
          Milestone(20, Container(), Container()),
          Milestone(20, Container(), Container()),
          Milestone(20, Container(), Container()),
        ],
      ),
    ),
  );
}
