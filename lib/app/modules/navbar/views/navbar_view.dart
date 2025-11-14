import 'package:calories_detector/app/modules/utills/app_ads.dart';
import 'package:calories_detector/app/modules/utills/app_images.dart';
import 'package:calories_detector/app/premium/premium.dart';
import 'package:calories_detector/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/navbar_controller.dart';

class NavbarView extends GetView<NavbarController> {
  const NavbarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Obx(() => controller.appBarList[controller.index.value]),
      ),
      body: Obx(
        () => Stack(
          children: [
            controller.bodyList[controller.index.value],
            if (controller.showButtons.value)
              GestureDetector(
                onTap: () => controller.showButtons.toggle(),
                child: Container(
                  color: Colors.white.withOpacity(0.85),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFloatingButtons(),
    );
  }

  /// Professional Card-like Bottom Navigation
  Widget _buildBottomNav() {
    return Obx(
      () => Container(
        margin: const EdgeInsets.all(12),
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(icon: Icons.show_chart, label: 'Progress', index: 0),
            _navItem(icon: Icons.history, label: 'History', index: 1),
            SizedBox(width: 60), // Space for center button
            _navItem(icon: Icons.chat, label: 'AI Chat', index: 2, isCenter: true),
            _navItem(icon: Icons.settings, label: 'Settings', index: 3),
          ],
        ),
      ),
    );
  }

  /// Bottom Nav Item
  Widget _navItem({required IconData icon, required String label, required int index, bool isCenter = false}) {
    return InkWell(
      onTap: () {
        AdsHandler().pageShufflead();
        if (index == 2) {
          Get.toNamed(Routes.AICHAT);
        } else {
          controller.index.value = index;
          controller.resetFunction();
        }
      },
      child: SizedBox(
        width: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: controller.index.value == index ? 28 : 24,
                color: controller.index.value == index ? Colors.green : Colors.grey),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: controller.index.value == index ? FontWeight.bold : FontWeight.normal,
                color: controller.index.value == index ? Colors.green : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Floating Buttons (Gallery, Camera, Scan)
  Widget _buildFloatingButtons() {
    return Obx(
      () => SizedBox(
        height: 180,
        width: 172,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Left Button - Gallery
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              top: controller.showButtons.value ? 0 : 75,
              left: controller.showButtons.value ? 0 : 55,
              child: _floatingButton(
                icon: Icons.image,
                onPressed: () {
                  controller.showButtons.toggle();
                  controller.pickImageFromGallery();
                },
              ),
            ),
            // Right Button - Camera
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              top: controller.showButtons.value ? 0 : 75,
              right: controller.showButtons.value ? 0 : 55,
              child: _floatingButton(
                icon: Icons.camera_alt,
                onPressed: () {
                  controller.showButtons.toggle();
                  Get.toNamed(Routes.CAMERA_SCREEN);
                },
              ),
            ),
            // Center Scan Button
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 45),
                child: FloatingActionButton(
                  heroTag: 'tag3',
                  onPressed: () {
                    if (Premium.instance.apple!.value >= PremiumTheme.scanPrice) {
                      controller.showButtons.toggle();
                    } else {
                      Get.toNamed(Routes.STREAK);
                    }
                  },
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.asset(AppImages.iconscan),
                  ),
                ),
              ),
            ),
            // Price Badge
            Positioned(
              top: 60,
              right: 30,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(AppImages.apple2, height: 40, color: PremiumTheme.appleColor),
                  Text('${PremiumTheme.scanPrice}',
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Individual Floating Button
  Widget _floatingButton({required IconData icon, required VoidCallback onPressed}) {
    return FloatingActionButton(
      heroTag: UniqueKey(),
      onPressed: onPressed,
      backgroundColor: Colors.green,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
      child: Icon(icon, color: Colors.white),
    );
  }
}
