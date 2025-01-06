import 'package:flutter/material.dart';
import 'package:foodi1/core/constant/color.dart';
import 'package:get/get.dart';
import '../core/class/statusrequest.dart';
import '../core/functions/handlingData.dart';
import '../core/services/services.dart';
import '../data/datasource/remote/cart_data.dart';
import '../data/model/itemsmodel.dart';



abstract class ProductDetailsController extends GetxController {}

class ProductDetailsControllerImp extends ProductDetailsController {
  // CartController cartController = Get.put(CartController());

   ItemsModel? itemsModel;

  CartData cartData = CartData(Get.find());

  late StatusRequest statusRequest;

  MyServices myServices = Get.find();

  int countitems = 0;
  late final int itemsId;

  intialData() async {
    statusRequest = StatusRequest.loading;
    itemsModel = Get.arguments['itemsmodel'];
    countitems = await getCountItems(itemsModel!.itemsId!);
    statusRequest = StatusRequest.success;
    update();
  }

  getCountItems(int itemsid) async {
    statusRequest = StatusRequest.loading;
    var response = await cartData.getCountCart(
        myServices.sharedPreferences.getString("id")!, itemsid.toString());
    print("=============================== ProductDetailsController $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        int countitems = 0;
        countitems = response['data'];
        print("==================================");
        print("$countitems");
        return countitems;
        // data.addAll(response['data']);
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
  }

  addItems(int itemsid) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await cartData.addCart(
        myServices.sharedPreferences.getString("id")!, itemsid.toString());
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        Get.rawSnackbar(
            backgroundColor:AppColor.primaryColor,
            title: "155".tr,
            messageText:  Text("154".tr,style: TextStyle(color: Colors.white),));
        // data.addAll(response['data']);
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }

  deleteitems(int itemsid) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await cartData.deleteCart(
        myServices.sharedPreferences.getString("id")!, itemsid.toString());
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        Get.rawSnackbar(
            backgroundColor:AppColor.primaryColor,
            title: "155".tr,
            messageText:  Text("157".tr,style: TextStyle(color: Colors.white)));
        // data.addAll(response['data']);
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }

  List subitems = [
    {"name": "red", "id": 1, "active": '0'},
    {"name": "yallow", "id": 2, "active": '0'},
    {"name": "black", "id": 3, "active": '1'}
  ];

  add() {
    addItems(itemsModel!.itemsId!);
    countitems++;
    update();
  }

  remove() {
    if (countitems > 0) {
      deleteitems(itemsModel!.itemsId!);
      countitems--;
      update();
    }
  }
  getPrice(itemsModel){
    switch(myServices.sharedPreferences.getString("userType")){
      case  "Normal User":
        if(itemsModel.itemsDescount >0){
          return  itemsModel.itemsPrice - itemsModel.itemsPrice *itemsModel.itemsDescount /100;
        }else {
          return  itemsModel.itemsPrice;
        }
      case  "mosque":
        if(itemsModel.itemsDescountMosque >0){
          return  itemsModel.itemsPriceMosque - itemsModel.itemsPriceMosque *itemsModel.itemsDescountMosque /100;
        }else {
          return  itemsModel.itemsPriceMosque;
        }
      case  "Merchant":
        if(itemsModel.itemsPriceMerchant >0){
          return  itemsModel.itemsPriceMerchant - itemsModel.itemsPriceMerchant *itemsModel.itemsDescountMerchant /100;
        }else {
          return  itemsModel.itemsPriceMerchant;
        }

    }
  }
  @override
  void onInit() {
    intialData();
    super.onInit();
  }
}