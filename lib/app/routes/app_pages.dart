import 'package:calories_detector/app/modules/home/bindings/history_binding.dart';
import 'package:calories_detector/app/modules/home/bindings/splash_binding.dart';
import 'package:calories_detector/app/modules/home/views/history_show.dart';
import 'package:calories_detector/app/modules/home/views/splash_view.dart';
import 'package:get/get.dart';

import '../modules/ResponseScreen/bindings/response_screen_binding.dart';
import '../modules/ResponseScreen/views/response_screen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/bindings/splash_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/views/splash_view.dart';
import '../modules/intro_screens/bindings/intro_screens_binding.dart';
import '../modules/intro_screens/views/intro_screens_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;
  static const HISTORY_VIEW = Routes.HISTORY_VIEW_SCREEN;
  // static const Home = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.INTRO_SCREENS,
      page: () => const IntroScreensView(),
      binding: IntroScreensBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.RESPONSE_SCREEN,
      page: () => const ResponseScreenView(),
      binding: ResponseScreenBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY_VIEW_SCREEN,
      page: () =>  HistoryShow(),
      binding: HistoryshowBinding(),
    ),
  ];
}
