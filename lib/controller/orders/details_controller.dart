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



  @override
  void onInit() {
    ordersModel = Get.arguments['ordersmodel'];
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