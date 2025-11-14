import 'package:calories_detector/app/premium/premium.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PaywallController extends GetxController {
  // RxInt? currentSelected;
  Rxn<StoreProduct> currentProduct = Rxn<StoreProduct>();
  // Rx<StoreProduct>? currentProduct= Rxn<StoreProduct>().obs;
  final count = 0.obs;
  @override
  void onInit() {
    print('in init');
    print(
        '${PremiumTheme.offering!.availablePackages.length <= 2},${PremiumTheme.offering!.availablePackages.length}');

    if (PremiumTheme.offering!.availablePackages.length >= 0.0) {
      print('thiscondition');
      print('thiscondition');

      currentProduct.value = PremiumTheme.offering!.availablePackages[0].storeProduct;
    } else if (PremiumTheme.offering!.availablePackages.length == 1) {
      currentProduct.value = PremiumTheme.offering!.availablePackages[0].storeProduct;
    }

    // currentSelected = 2.obs;
    super.onInit();
  }



  void increment() => count.value++;
}

class HeartbeatEffect extends StatefulWidget {
  final Widget child;

  const HeartbeatEffect(this.child, {super.key});

  @override
  _HeartbeatEffectState createState() => _HeartbeatEffectState();
}

class _HeartbeatEffectState extends State<HeartbeatEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true); // Repeating for heartbeat effect

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: widget.child,
    );
  }
}
