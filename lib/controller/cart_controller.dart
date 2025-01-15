import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/class/statusrequest.dart';
import '../core/constant/routes.dart';
import '../core/functions/handlingData.dart';
import '../core/services/services.dart';
import '../data/datasource/remote/cart_data.dart';
import '../data/model/cartmodel.dart';
import '../data/model/couponmodel.dart';

class CartController extends GetxController {
  TextEditingController? controllercoupon;

  CartData cartData = CartData(Get.find());

  int? discountcoupon = 0;

  String? couponname;

  int? couponid;

  late StatusRequest statusRequest;

  CouponModel? couponModel;

  MyServices myServices = Get.find();

  List<CartModel>? data = [];

  num priceorders = 0.0;

  num totalcountitems = 0;

  add(int itemsid,String isbox , String itemprice ,int countitembyunit ) async {
    statusRequest = StatusRequest.loading;
    update();
    var response;
       response = await cartData.addCart(
          myServices.sharedPreferences.getString("id")!, itemsid.toString(),isbox ,itemprice,countitembyunit);

    print("=============================== addCartController $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        Get.rawSnackbar(
            backgroundColor:Colors.grey,
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

  goToPageCheckout() {
    if (data!.isEmpty) return Get.snackbar("146".tr, "156".tr);
    Get.toNamed(AppRoute.checkout, arguments: {
      "couponid": couponid ?? 0,
      "priceorder": priceorders.toString() ,
      "discountcoupon" : discountcoupon.toString()
    });
  }

  getTotalPrice() {
    return (priceorders - priceorders * discountcoupon! / 100);
  }

  delete(int itemsid ,int countitembyunit) async {
    statusRequest = StatusRequest.loading;
    update();
    var response;
      response = await cartData.deleteCart(
          myServices.sharedPreferences.getString("id")!, itemsid.toString(),countitembyunit);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success" ) {
        Get.rawSnackbar(
            title: "155".tr,
            messageText:  Text("157".tr));
        // data.addAll(response['data']);
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }


  checkcoupon() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await cartData.checkCoupon(controllercoupon!.text);
    print("=============================== CartController $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        Map<String, dynamic> datacoupon = response['data'];
        couponModel = CouponModel.fromJson(datacoupon);
        discountcoupon = couponModel!.couponDiscount!;
        couponname = couponModel!.couponName;
        couponid = couponModel!.couponId;
      } else {
        // statusRequest = StatusRequest.failure;
        discountcoupon = 0;
        couponname = null;
        couponid = null;
        Get.snackbar("158".tr, "159".tr) ;
      }
      // End
    }
    update();
  }

  resetVarCart() {
    totalcountitems = 0;
    priceorders = 0.0;
    data?.clear();
  }

  refreshPage() {
    resetVarCart();
    view();
  }

  view() async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
    await cartData.viewCart(myServices.sharedPreferences.getString("id")!,
        myServices.sharedPreferences.getString("userType")!);
    print("=============================== CartController $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        if (response['datacart']['status'] == 'success') {
          List dataresponse = response['datacart']['data'];
          Map dataresponsecountprice = response['countprice'];
          data?.clear();
          data?.addAll(dataresponse.map((e) => CartModel.fromJson(e)));
          totalcountitems = dataresponsecountprice['totalcount'];
          priceorders = dataresponsecountprice['totalprice'];
          print("priceorders $priceorders" );
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }

  getPrice(CartModel? CartModel ){
    switch(myServices.sharedPreferences.getString("userType")){
      case "Normal User":
        return CartModel!.itemsPrice! - CartModel.itemsPrice! * CartModel.itemsDescount! /100;
      case "mosque":
        return CartModel!.itemsPriceMosque! - CartModel.itemsPriceMosque! * CartModel.itemsDescountMosque! /100;
      case "Merchant":
        return CartModel!.itemsPriceMerchant! - CartModel.itemsPriceMerchant! * CartModel.itemsDescountMerchant! /100;

    }

  }

  @override
  void onInit() {
    controllercoupon = TextEditingController();
    view();
    super.onInit();
  }
}