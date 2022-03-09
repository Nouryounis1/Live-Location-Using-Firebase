import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mutli_service_app/global_presntation/global_widgets/primary_button.dart';

import '../controllers/google_maps_screen_controller.dart';

class GoogleMapsScreenView extends GetView<GoogleMapsScreenController> {
  final GoogleMapsScreenController controller =
      Get.put(GoogleMapsScreenController());

  Position? currentPostion;
  late GoogleMapController googleMapController;

  StreamSubscription<Position>? locateSub;
  void locatePosition() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      currentPostion = position;

      LatLng latLng = LatLng(position.latitude, position.longitude);

      await FirebaseFirestore.instance.collection('location').doc('user1').set({
        'latitude': position.latitude,
        'longtuide': position.longitude,
        'name': 'nour'
      });

      CameraPosition cameraPosition = CameraPosition(
        target: latLng,
        zoom: 14,
      );
      googleMapController
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    } catch (e) {
      print('$e dsadsada');
    }
  }

  Future<void> myMap(AsyncSnapshot<QuerySnapshot> snapshot) async {
    await googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
                snapshot.data!.docs.singleWhere(
                    (element) => element.id == 'user1')['latitude'],
                snapshot.data!.docs.singleWhere(
                    (element) => element.id == 'user1')['longtuide']))));
  }

  Future<void> listToLocation() async {
    locateSub =
        Geolocator.getPositionStream().listen((Position? position) async {
      await FirebaseFirestore.instance.collection('location').doc('user1').set({
        'latitude': position!.latitude,
        'longtuide': position.longitude,
        'name': 'nour'
      }, SetOptions(merge: true));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GoogleMapsScreenView'),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('location').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomGesturesEnabled: true,
              markers: {
                Marker(
                    position: LatLng(
                        snapshot.data!.docs.singleWhere(
                            (element) => element.id == 'user1')['latitude'],
                        snapshot.data!.docs.singleWhere(
                            (element) => element.id == 'user1')['longtuide']),
                    markerId: MarkerId('id'),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueMagenta))
              },
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                      snapshot.data!.docs.singleWhere(
                          (element) => element.id == 'user1')['latitude'],
                      snapshot.data!.docs.singleWhere(
                          (element) => element.id == 'user1')['longtuide'])),
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController? controller) {
                googleMapController = controller!;

                locatePosition();
                listToLocation();
              },
            );
          }),
    );
  }
}
