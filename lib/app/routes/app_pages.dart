import 'package:get/get.dart';

import '../modules/GoogleMapsScreen/bindings/google_maps_screen_binding.dart';
import '../modules/GoogleMapsScreen/views/google_maps_screen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.GOOGLE_MAPS_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.GOOGLE_MAPS_SCREEN,
      page: () => GoogleMapsScreenView(),
      binding: GoogleMapsScreenBinding(),
    ),
  ];
}
