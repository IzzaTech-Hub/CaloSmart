// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:calories_detector/app/modules/home/controllers/splash_Controller.dart';
import 'package:calories_detector/app/modules/utills/Themes/current_theme.dart';
import 'package:calories_detector/sizeConfig.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'dart:ui';

double screenHeight = SizeConfig.screenHeight;
double screenWidtht = SizeConfig.screenWidth;
double smallblureffect = 15;
double largeblureffect = 15;
double smallsize = 150;
double largesize = 300;
// void main() => runApp(LiquidEffectApp());

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return
        // debugShowCheckedModeBanner: false,
        Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: LiquidEffect(),
      ),
    );
  }
}

class LiquidEffect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            MovingContainer(),

            // Blurred Black Circles
            Center(
              child: BlurryCircle(
                color: Color(0xff000000),
                blurSigma: largeblureffect,
                size: largesize,
              ),
            ),
          ],
        ),
        Positioned(
          child: Container(
            width: 3000,
            height: 3000,
            // color: Colors.white.withOpacity(1), // Light source
            foregroundDecoration: BoxDecoration(
              color: Color(0xffD9D9D9).withOpacity(1),
              backgroundBlendMode:
                  BlendMode.colorDodge, // Approximation of Color Dodge
            ),
          ),
        ),
        Positioned(
          child: Container(
            width: 3000,
            height: 3000,
            // color: Colors.white.withOpacity(1), // Light source
            foregroundDecoration: BoxDecoration(
              color: Colors.black.withOpacity(1),
              backgroundBlendMode:
                  BlendMode.colorBurn, // Approximation of Color Dodge
            ),
          ),
        ),
        Positioned(
          child: Container(
            width: 3000,
            height: 3000,
            // color: Colors.white.withOpacity(1), // Light source
            foregroundDecoration: BoxDecoration(
              color: AppThemeColors.splashColor,
              // color: Color(0xffff0000),
              backgroundBlendMode:
                  BlendMode.lighten, // Approximation of Color Dodge
            ),
          ),
        ),
        // Logo_Text()
        Center(
          child: Text('CaloSmart',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
      ],
    );
  }
}

class BlurryCircle extends StatelessWidget {
  final Color color;
  final double blurSigma;
  final double size;

  const BlurryCircle({
    super.key,
    required this.color,
    required this.blurSigma,
    required this.size,
  });

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
      duration: const Duration(seconds: 3), // Adjust duration as needed
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
    double screenHeight = MediaQuery.of(context).size.height;

    // Create a Tween for vertical movement (from just above the top to just below the bottom of the screen)
    _animation = Tween<double>(
            begin: (-screenHeight + smallsize) / 2 + 30,
            end: (screenHeight - smallsize) / 2 - 30)
        .animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value), // Moving vertically
          child: BlurryCircle(
            color: Color(0xff000000),
            blurSigma: smallblureffect,
            size: smallsize,
          ),
        );
      },
    );
  }
}

Row Logo_Text() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        'Cal',
        style: TextStyle(
          fontSize: 80,
          color: Colors.white,
          fontWeight: FontWeight.w900,
          // height: size.height * 0.016
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ories',
            style: TextStyle(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.w900,
                // letterSpacing: 1,
                height: 1),
          ),
          Text(
            'culator',
            style: TextStyle(
                // letterSpacing: 1,
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.w900,
                height: 1),
          )
        ],
      )
    ],
  );
}
