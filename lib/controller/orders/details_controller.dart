import 'dart:async';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/class/statusrequest.dart';
import '../../core/functions/handlingData.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/orders/details_data.dart';
import '../../data/model/cartmodel.dart';
import '../../data/model/ordersmodel.dart';

class OrdersDetailsController extends GetxController {
  MyServices myServices = Get.find();
  OrdersDetailsData ordersDetailsData = OrdersDetailsData(Get.find());
  late StatusRequest statusRequest;
  late OrdersModel ordersModel;
  List data = [];
  Completer<GoogleMapController>? completercontroller;
  CameraPosition? cameraPosition;
  List<Marker> markers = [];
  double? lat;
  double? long;

  intialData() {
    if (ordersModel.ordersType == 0) {
      cameraPosition = CameraPosition(
        target: LatLng(ordersModel.ordersAddressLat!.toDouble(), ordersModel.ordersAddressLong!.toDouble()),
        zoom: 12.4746,
      );
      markers.add(
          Marker(
          markerId: const MarkerId("1"),
          position: LatLng(ordersModel.ordersAddressLat!.toDouble(), ordersModel.ordersAddressLong!.toDouble())
          )
      );
    }
  }

  @override
  void onInit() {
    ordersModel = Get.arguments['ordersmodel'];
    intialData();
    getData();
    super.onInit();
  }

  getData() async {
    statusRequest = StatusRequest.loading;
    var response = await ordersDetailsData.getData(ordersModel.ordersId!.toString());
    print("===============================OrdersDetailsController  $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success"){
         data = response['data'];

      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

}