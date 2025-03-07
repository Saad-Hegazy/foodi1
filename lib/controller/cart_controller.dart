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
  Map isInCart = {};

//  key => id items
//  Value => 1 OR 0

  setInCart(id, val) {
    isInCart[id] = val;
    update();
  }
    add(int itemsid,String isbox, String itemprice ,int countitembyunit ) async {
    statusRequest = StatusRequest.loading;
    update();
    var response;
       response = await cartData.addCart(
          myServices.sharedPreferences.getString("id")!,
          itemsid.toString(),
          isbox,
          itemprice,
          countitembyunit
       );
    print("=============================== addCartController $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }
  addfromcartpage(int itemsid,String isbox, String itemprice ,int countitembyunit ) async {
    statusRequest = StatusRequest.none;
    update();
    var response;
    response = await cartData.addCart(
        myServices.sharedPreferences.getString("id")!,
        itemsid.toString(),
        isbox,
        itemprice,
        countitembyunit
    );
    print("=============================== addCartController $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
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

  delete(int itemsid ) async {
    statusRequest = StatusRequest.loading;
    update();
    var response;
    response = await cartData.deleteCart(
        myServices.sharedPreferences.getString("id")!, itemsid.toString());
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success" ) {
        Get.snackbar("155".tr, "157".tr);
        // data.addAll(response['data']);
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }
  deletefromcartoage(int itemsid ) async {
    statusRequest = StatusRequest.none;
    update();
    var response;
    response = await cartData.deleteCart(
        myServices.sharedPreferences.getString("id")!, itemsid.toString());
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success" ) {
        Get.snackbar("155".tr, "157".tr);
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
  refreshcartPage() {
    resetVarCart();
    viewformcartpage();
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
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }
  viewformcartpage() async {
    statusRequest = StatusRequest.none;
    update();
    var response =
    await cartData.viewCart(myServices.sharedPreferences.getString("id")!,
        myServices.sharedPreferences.getString("userType")!);
    print("=============================== viewformcartpageController $response ");
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
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }
  goToPageProductDetails(cartModel) {
    Get.toNamed("productdetails", arguments: {"cartModel": cartModel });
  }
  getPrice(CartModel){
    switch(myServices.sharedPreferences.getString("userType")){
      case  "Normal User":
        if(CartModel.itemsDescount >0){
          if(CartModel.cartitemisbox==1){
            return  (CartModel.itemspricrofbox - CartModel.itemspricrofbox *CartModel.itemsDescount /100) ;
          }else{
            return  CartModel.itemsPrice - CartModel.itemsPrice *CartModel.itemsDescount /100;
          }
        }else {
          if(CartModel.cartitemisbox==1){
            return  CartModel.itemspricrofbox ;
          }else{
            return  CartModel.itemsPrice;
          }

        }
      case  "mosque":
        if(CartModel.itemsDescountMosque >0){
          if(CartModel.cartitemisbox==1){
            return  (CartModel.itemspricrofboxmosque - CartModel.itemspricrofboxmosque *CartModel.itemsDescountMosque /100);
          }else{
            return  CartModel.itemsPriceMosque - CartModel.itemsPriceMosque *CartModel.itemsDescountMosque /100;
          }
        }else {
          if(CartModel.cartitemisbox==1){
            return  CartModel.itemspricrofboxmosque ;
          }else{
            return  CartModel.itemsPriceMosque;
          }
        }
      case  "Merchant":
        if(CartModel.itemsPriceMerchant >0){
          if(CartModel.cartitemisbox==1){
            return  (CartModel.itemspricrofboxmerchant - CartModel.itemspricrofboxmerchant *CartModel.itemsDescountMerchant /100) ;

          }else{
            return  CartModel.itemsPriceMerchant - CartModel.itemsPriceMerchant *CartModel.itemsDescountMerchant /100;
          }
        }else {
          if(CartModel.cartitemisbox==1){
            return  CartModel.itemspricrofboxmerchant;

          }else{
            return  CartModel.itemsPriceMerchant;

          }

        }

    }
  }


  @override
  void onInit() {
    controllercoupon = TextEditingController();
    view();
    super.onInit();
  }
}