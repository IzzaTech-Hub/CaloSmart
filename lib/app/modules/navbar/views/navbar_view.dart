import 'package:calories_detector/app/modules/utills/app_images.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/navbar_controller.dart';

class NavbarView extends GetView<NavbarController> {
  const NavbarView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 70, // Height of the bottom navigation bar
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.book, color: Colors.grey),
                Text('Diary', style: TextStyle(color: Colors.grey)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.dashboard, color: Colors.green),
                Text('Dashboard', style: TextStyle(color: Colors.green)),
              ],
            ),
            SizedBox(width: 60), // Space for center button
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.restaurant_menu, color: Colors.grey),
                Text('Recipes', style: TextStyle(color: Colors.grey)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.settings, color: Colors.grey),
                Text('Mine', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Obx(
        () => Stack(
          clipBehavior: Clip.none,
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              top: controller.showButtons.value ? -60 : 5,
              left: controller.showButtons.value ? -40 : 5,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
                onPressed: () {
                  // Handle button 1 press
                },
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.image,
                  color: Colors.white,
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              top: controller.showButtons.value ? -60 : 5,
              right: controller.showButtons.value ? -40 : 5,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
                onPressed: () {
                  // Handle button 2 press
                },
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              height: 70,
              width: 70,
              child: FloatingActionButton(
                  onPressed: () {
                    controller.showButtons.toggle();
                  },
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: GestureDetector(
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.asset('assets/images/bg_img.png'),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
