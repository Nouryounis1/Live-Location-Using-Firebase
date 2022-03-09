import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsScreenController extends GetxController {
  //TODO: Implement GoogleMapsScreenController

  final count = 0.obs;
  RxBool serviceEnable = false.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  Future<Position> currentPos() async {
    LocationPermission permission;

    serviceEnable.value = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable.value) {
      return Future.error('Location Service are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('Location Service are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location Service are disabled');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
}
