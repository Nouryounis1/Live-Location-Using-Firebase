import 'package:get/get.dart';

import '../controllers/google_maps_screen_controller.dart';

class GoogleMapsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GoogleMapsScreenController>(
      () => GoogleMapsScreenController(),
    );
  }
}
