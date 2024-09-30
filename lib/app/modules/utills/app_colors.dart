import 'package:flutter/material.dart';

class AppColors {
  static const white = Color(0xffFFffff);
  static const darkPink = Color(0xffFF4D6D);
  static const lightPink = Color(0xffFFD1DC);
  static const darkBlue = Color(0xff1E3A5F);
  static const lightBlue = Color(0xffE3D7FF);
  static const newc = Color(0xFF6200Ee);

  static const onSecondaryColor = Color(0xffFFffff);
  static const secondaryColor = Color(0xffFF4D6D);
  static const primaryColor = Color(0xffFFD1DC);
  static const onPrimaryColor = Color(0xff1E3A5F);
  static const tertoryColor = Color(0xffE3D7FF);

  static const dark1 = Color(0xff2ECC71);
  static const dark2 = Color(0xffB2FF59);
  static const light1 = Color(0xffE0F5E2);
  static const light2 = Color(0xffD2F8D7);
  static const nowhite = Color(0xffEEFFF0);
}



// class AppTheme2 {
//   final Function() onPressed; // Function without arguments and return type.
//   final String text;

//   AppTheme2({
//     required this.onPressed,
//     required this.text,
//   });
//   static const bgColor = AppGradient.bgGradient;

//   // Method to create a small button
//   Widget smallButton() {
//     return InkWell(
//       onTap: onPressed,
//       child: Container(
//         clipBehavior: Clip.hardEdge,
//         width: SizeConfig.screenWidth * 0.425,
//         height: SizeConfig.screenHeight * 0.05,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(100),
//             // color: AppColors.secondaryColor,
//             gradient: AppGradient.buttonGradient),
//         child: Stack(
//           children: [
//             Positioned(
//               right: -SizeConfig.screenWidth * 0.16,
//               bottom: -SizeConfig.screenWidth * 0.31,
//               child: Container(
//                 width: SizeConfig.screenWidth * 0.425,
//                 height: SizeConfig.screenWidth * 0.425,
//                 // height: 10,
//                 // width: 10,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(100),
//                     // color: Colors.black,
//                     border: Border.all(
//                         color: const Color.fromARGB(150, 255, 255, 255),
//                         width: 1),
//                     gradient: RadialGradient(colors: [
//                       Color.fromARGB(30, 255, 255, 255),
//                       Color.fromARGB(60, 255, 255, 255),
//                     ])),
//               ),
//             ),
//             Center(
//               child: Text(
//                 text,
//                 style: AppText().buttonText,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget largeButton() {
//     return InkWell(
//       onTap: onPressed,
//       child: Container(
//         clipBehavior: Clip.hardEdge,
//         height: SizeConfig.screenHeight * 0.05,
//         width: SizeConfig.screenWidth * 0.9,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(100),
//           // color: AppColors.secondaryColor,
//           gradient: AppGradient.buttonGradient,
//         ),
//         child: Stack(
//           children: [
//             Positioned(
//               right: -SizeConfig.screenWidth * 0.16,
//               bottom: -SizeConfig.screenWidth * 0.31,
//               child: Container(
//                 width: SizeConfig.screenWidth * 0.425,
//                 height: SizeConfig.screenWidth * 0.425,
//                 // height: 10,
//                 // width: 10,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(100),
//                     // color: Colors.black,
//                     border: Border.all(
//                         color: const Color.fromARGB(150, 255, 255, 255),
//                         width: 1),
//                     gradient: RadialGradient(colors: [
//                       Color.fromARGB(30, 255, 255, 255),
//                       Color.fromARGB(60, 255, 255, 255),
//                     ])),
//               ),
//             ),
//             Center(
//               child: Text(
//                 text,
//                 style: AppText().buttonText,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
