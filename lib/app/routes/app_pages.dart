import 'package:get/get.dart';

import '../modules/ResponseScreen/bindings/response_screen_binding.dart';
import '../modules/ResponseScreen/views/response_screen_view.dart';
import '../modules/history_response/bindings/history_response_binding.dart';
import '../modules/history_response/views/history_response_view.dart';
import '../modules/home/bindings/age_binding.dart';
import '../modules/home/bindings/camera_binding.dart';
import '../modules/home/bindings/comparison_binding.dart';
import '../modules/home/bindings/gender_binding.dart';
import '../modules/home/bindings/goal_binding.dart';
import '../modules/home/bindings/history_binding.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/bindings/splash_binding.dart';
import '../modules/home/views/age_view.dart';
import '../modules/home/views/cameraView.dart';
import '../modules/home/views/comparison_view.dart';
import '../modules/home/views/gender_view.dart';
import '../modules/home/views/goal_view.dart';
import '../modules/home/views/history_show.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/views/splash_view.dart';
import '../modules/intro_screens/bindings/intro_screens_binding.dart';
import '../modules/intro_screens/views/intro_screens_view.dart';
import '../modules/navbar/bindings/navbar_binding.dart';
import '../modules/navbar/views/navbar_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;
  // static const HOME = Routes.HOME;
  // static const NAVBAR = Routes.NAVBAR;
  // static const CHECK = Routes.CAMERA_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CAMERA_SCREEN,
      page: () => Cameraview(),
      binding: CameraBinding(),
    ),
    GetPage(
      name: _Paths.AGE_SCREEN,
      page: () => AgeView(),
      binding: AgeBinding(),
    ),
    GetPage(
      name: _Paths.GENDER_SCREEN,
      page: () => gender_view(),
      binding: GenderBinding(),
    ),
    GetPage(
      name: _Paths.GOAL_SCREEN,
      page: () => goalView(),
      binding: GoalBinding(),
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
      page: () => HistoryShow(),
      binding: HistoryshowBinding(),
    ),
    GetPage(
      name: _Paths.COMPARISON_VIEW_SCREEN,
      page: () => ComparisonView(),
      binding: ComparisonBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY_RESPONSE,
      page: () => const HistoryResponseView(),
      binding: HistoryResponseBinding(),
    ),
    GetPage(
      name: _Paths.NAVBAR,
      page: () => const NavbarView(),
      binding: NavbarBinding(),
    ),
  ];
}
