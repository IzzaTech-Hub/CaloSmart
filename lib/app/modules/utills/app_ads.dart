import 'package:calories_detector/app/providers/applovin_ads_provider.dart';

class AdsHandler {
  static var countForAd = 0;

  void pageShufflead() {
    if (countForAd >= 3) {
      AppLovinProvider.instance.showInterstitial(() {});
      countForAd = 0;
    } else {
      countForAd++;
    }
    print('$countForAd');
  }
}
