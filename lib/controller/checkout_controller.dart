import 'dart:convert';

import 'package:get/get.dart';
import '../core/class/statusrequest.dart';
import '../core/constant/routes.dart';
import '../core/functions/handlingData.dart';
import '../core/services/services.dart';
import '../data/datasource/remote/address_data.dart';
import '../data/datasource/remote/checkout_date.dart';
import '../data/model/addressmodel.dart';
import 'cartlocal_controller.dart';
class CheckoutController extends GetxController {
  MyServices myServices = Get.find();
  final cartControllerLocal = Get.find<CartControllerLocal>();
  CheckoutData checkoutData = Get.put(CheckoutData(Get.find()));
  AddressData addressData = Get.put(AddressData(Get.find()));
  StatusRequest statusRequest = StatusRequest.none;

  List<AddressModel> dataaddress = [];

  String? paymentMethod;
  String? deliveryType;
  String addressid = "0";
  final couponid = 0.obs;
  late String priceorders;
  late String ordersAddressLat="0.0";
  late String ordersAddressLong="0.0";


  choosePaymentMethod(String val) {
    paymentMethod = val;
    update();
  }

  chooseDeliveryType(String val) {
    deliveryType = val;
    if(deliveryType=="0"){
      getShippingAddress();
    }
    update();
  }

  chooseShippingAddress(String val,String lat,String long) {
    addressid = val;
    ordersAddressLat = lat;
    ordersAddressLong = long;
    update();
  }

  getShippingAddress() async {
    statusRequest = StatusRequest.loading;
    var response = await addressData
        .getData(myServices.sharedPreferences.getString("id")!);
    print("=============================== getShippingAddressController $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List listdata = response['data'];
        dataaddress.addAll(listdata.map((e) => AddressModel.fromJson(e)));
        addressid =dataaddress[0].addressId!.toString();
        ordersAddressLat=dataaddress[0].addressLat!.toString();
        ordersAddressLong=dataaddress[0].addressLong!.toString();
      } else {
        statusRequest = StatusRequest.success;
      }
    }
    update();
  }

  checkout() async {
    if (paymentMethod == null) {
      return Get.snackbar("147".tr, "148".tr);
    }
    if (deliveryType == null) {
      return Get.snackbar("147".tr, "149".tr);
    }
    if(deliveryType =="0"){
      if(dataaddress.isEmpty){
        return Get.snackbar("147".tr, "150".tr);
      }
    }
    statusRequest = StatusRequest.loading;
    update();
    Map data = {
      "userid": myServices.sharedPreferences.getString("id"),
      "usertype": myServices.sharedPreferences.getString("userType"),
      "addressid": addressid.toString(),
      "ordertype": deliveryType.toString(),
      "orderprice": cartControllerLocal.totalPrice.toStringAsFixed(2),
      "ordertotalprice": cartControllerLocal.getOrderPrice.toStringAsFixed(2),
      "couponid": couponid.value.toString(),
      "paymentmethod": paymentMethod.toString(),
      "ordersAddressLat": ordersAddressLat.toString(),
      "ordersAddressLong": ordersAddressLong.toString(),
      "items": jsonEncode(cartControllerLocal.cartItems.map((item) => item.toJson()).toList()),

    };
    var response = await checkoutData.checkout(data);
    print("=============================== checkoutController $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
        print(myServices.sharedPreferences.get('cart'));
        cartControllerLocal.clearCart();
        Get.offAllNamed(AppRoute.homepage);
        Get.snackbar("151".tr, "152".tr);
      } else {
        statusRequest = StatusRequest.none;
        Get.snackbar("147".tr, "153".tr);
      }
    }
    update();
  }

  @override
  void onInit() {
     couponid.value = Get.arguments['couponid'];
    super.onInit();
  }
}

