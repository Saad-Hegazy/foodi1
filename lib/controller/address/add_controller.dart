import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodi1/core/constant/color.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/class/statusrequest.dart';
import '../../core/constant/routes.dart';
class AddAddressController extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;

  Completer<GoogleMapController>? completercontroller;

  List<Marker> markers = [];

  double? lat;
  double? long;

  addMarkers(LatLng latLng) {
    markers.clear();
    markers.add(Marker(markerId: const MarkerId("1"), position: latLng));
    lat = latLng.latitude;
    long = latLng.longitude;
    update();
  }

  goToPageAddDetailsAddress() {
    Get.toNamed(AppRoute.addressadddetails,
        arguments: {"lat": lat.toString(), "long": long.toString()});
  }

  Position? postion;

  CameraPosition? kGooglePlex;

  getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showLocationServiceDialog();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        showLocationPermissionDialog();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showPermanentDenialDialog();
      return;
    }

    // If we get here, permissions are granted
    try {
      postion = await Geolocator.getCurrentPosition();
      kGooglePlex = CameraPosition(
        target: LatLng(postion!.latitude, postion!.longitude),
        zoom: 14.4746,
      );
      addMarkers(LatLng(postion!.latitude, postion!.longitude));
      statusRequest = StatusRequest.none;
    } catch (e) {
      statusRequest = StatusRequest.serverfailure;
    }
    update();
  }

  void showLocationServiceDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColor.secondColor,
        title: Text('215'.tr),
        content: Text('216'.tr),
        actions: [
          TextButton(
            onPressed: () => Geolocator.openLocationSettings(),
            child: Text('Open Settings'),
          ),
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void showLocationPermissionDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColor.secondColor,
        title: Text('217'.tr),
        content: Text('218'.tr),
        actions: [
          TextButton(
            onPressed: () => Geolocator.openAppSettings(),
            child: Text('Open Settings'),
          ),
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void showPermanentDenialDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColor.secondColor,
        title: Text('219'.tr),
        content: Text('220'.tr),
        actions: [
          TextButton(
            onPressed: () => Geolocator.openAppSettings(),
            child: Text('App Settings'),
          ),
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  void onInit() {
    getCurrentLocation();
    completercontroller = Completer<GoogleMapController>();
    super.onInit();
  }
}