import 'dart:async';
import 'dart:ui';

import 'package:calories_detector/sizeConfig.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

double screenHeight = SizeConfig.screenHeight;
double screenWidtht = SizeConfig.screenWidth;
double smallblureffect = 3;
double largeblureffect = 3;
double smallsize = 30;
double middlesize = 40;
double largesize = 70;
int secs = 2;

class LiquidloadingController extends GetxController {
  int currentIndex = 0;
  int dotCount = 0;
  Timer? timer;

  RxString? loadingnow;
  List<String> loadingPhrases = [
    "Scanning your food image",
    "Analyzing nutrients",
    "Calculating calorie content",
    "Processing nutritional data",
    "Finalizing nutrient analysis",
    "Almost there"
  ];

  //TODO: Implement LiquidloadingController
  void startLoadingAnimation() {
    // Initialize the timer to update every second
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (dotCount <= 3) {
        // Add dots gradually
        loadingnow!.value = loadingPhrases[currentIndex] + '.' * dotCount;
        dotCount++;
      } else {
        // Move to the next phrase after 3 seconds
        currentIndex = (currentIndex + 1) % loadingPhrases.length;
        dotCount = 0;
      }
    });
  }

  final count = 0.obs;
  @override
  void onInit() {
    loadingnow = loadingPhrases[0].obs;
    startLoadingAnimation();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // timer?.cancel();
    super.onClose();
  }

  void increment() => count.value++;
}

class ColorDodgePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();

    // Draw a solid gray rectangle
    paint.color = Colors.grey;
    paint.blendMode = BlendMode.srcOver;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Simulate Color Dodge effect by using BlendMode.screen
    paint.color = Colors.white.withOpacity(0.7); // Light source color
    paint.blendMode = BlendMode.screen;

    // Draw another rectangle or shape with blend mode applied
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class MovingContainer extends StatefulWidget {
  final int rev;
  const MovingContainer({super.key, required this.rev});
  @override
  _MovingContainerState createState() => _MovingContainerState();
}

class _MovingContainerState extends State<MovingContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Define the AnimationController and set the duration
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Adjust duration as needed
    );

    // Start the animation loop
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen height
    // double screenHeight = MediaQuery.of(context).size.height;

    // Create a Tween for vertical movement (from just above the top to just below the bottom of the screen)
    _animation = Tween<double>(
      begin: (-screenWidtht / 2 + smallsize * 2 + (screenWidtht * 0.05)) *
          widget.rev, // Start position off the left side of the screen
      end: (screenWidtht / 2 - smallsize * 2 - (screenWidtht * 0.05)) *
          widget.rev, // End position off the right side of the screen
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_animation.value, 0), // Moving vertically
          child: BlurryCircle(
            color: Color(0xff002907),
            blurSigma: smallblureffect,
            size: smallsize,
          ),
        );
      },
    );
  }
}

class MovingContainer2 extends StatefulWidget {
  final int rev;
  const MovingContainer2({super.key, required this.rev});
  @override
  _MovingContainerState2 createState() => _MovingContainerState2();
}

class _MovingContainerState2 extends State<MovingContainer2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Define the AnimationController and set the duration
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Adjust duration as needed
    );

    // Start the animation loop
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen height
    // double screenHeight = MediaQuery.of(context).size.height;

    // Create a Tween for vertical movement (from just above the top to just below the bottom of the screen)
    _animation = Tween<double>(
      begin: (-screenWidtht / 2 +
              smallsize +
              middlesize * 2 +
              (screenWidtht * 0.05)) *
          widget.rev, // Start position off the left side of the screen
      end: (screenWidtht / 2 -
              smallsize -
              middlesize * 2 -
              (screenWidtht * 0.05)) *
          widget.rev, // End position off the right side of the screen
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_animation.value, 0), // Moving vertically
          child: BlurryCircle(
            color: Color(0xff002907),
            blurSigma: smallblureffect,
            size: middlesize,
          ),
        );
      },
    );
  }
}

class BlurryCircle extends StatelessWidget {
  final Color color;
  final double blurSigma;
  final double size;

  const BlurryCircle({
    Key? key,
    required this.color,
    required this.blurSigma,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      // child: ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          color: Colors.black.withOpacity(0), // Invisible filler for blur
        ),
      ),
      // ),
    );
  }
}
