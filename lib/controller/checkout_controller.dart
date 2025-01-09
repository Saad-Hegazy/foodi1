import 'package:get/get.dart';
import '../core/class/statusrequest.dart';
import '../core/constant/routes.dart';
import '../core/functions/handlingData.dart';
import '../core/services/services.dart';
import '../data/datasource/remote/address_data.dart';
import '../data/datasource/remote/checkout_date.dart';
import '../data/model/addressmodel.dart';
class CheckoutController extends GetxController {
  AddressData addressData = Get.put(AddressData(Get.find()));
  CheckoutData checkoutData = Get.put(CheckoutData(Get.find()));

  MyServices myServices = Get.find();

  StatusRequest statusRequest = StatusRequest.none;

  String? paymentMethod;
  String? deliveryType;
  String addressid = "0";

  late String couponid;
  late String coupondiscount;
  late String priceorders;
  late String ordersAddressLat="0.0";
  late String ordersAddressLong="0.0";

  List<AddressModel> dataaddress = [];

  choosePaymentMethod(String val) {
    paymentMethod = val;
    print(paymentMethod);
    update();
  }

  chooseDeliveryType(String val) {
    deliveryType = val;
    print(deliveryType);

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
      // Start backend
      if (response['status'] == "success") {
        List listdata = response['data'];
        dataaddress.addAll(listdata.map((e) => AddressModel.fromJson(e)));
        addressid =dataaddress[0].addressId!.toString();
        ordersAddressLat=dataaddress[0].addressLat!.toString();
        ordersAddressLong=dataaddress[0].addressLong!.toString();
      } else {
        statusRequest = StatusRequest.success;
      }
      // End
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
    if(dataaddress.isEmpty){
      return Get.snackbar("147".tr, "150".tr);
    }

    statusRequest = StatusRequest.loading;

    update();

    Map data = {
      "usersid": myServices.sharedPreferences.getString("id"),
      "customerdeviceToken": myServices.sharedPreferences.getString("DeviceToken"),
      "userstype": myServices.sharedPreferences.getString("userType"),
      "addressid": addressid.toString(),
      "orderstype": deliveryType.toString(),
      "pricedelivery": "0",
      "ordersprice": priceorders,
      "couponid": couponid,
      "paymentmethod": paymentMethod.toString(),
      "coupondiscount" : coupondiscount.toString() ,
      "ordersAddressLat": ordersAddressLat.toString(),
      "ordersAddressLong": ordersAddressLong.toString()
    };

    var response = await checkoutData.checkout(data);

    print("=============================== checkoutController $response ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        Get.offAllNamed(AppRoute.homepage);
        Get.snackbar("151".tr, "152".tr);
      } else {
        statusRequest = StatusRequest.none;
        Get.snackbar("147".tr, "153".tr);
      }
      // End
    }
    update();
  }

  @override
  void onInit() {
    couponid = Get.arguments['couponid'].toString();
    priceorders = Get.arguments['priceorder'];
    coupondiscount = Get.arguments['discountcoupon'].toString();
    getShippingAddress();
    super.onInit();
  }
}

