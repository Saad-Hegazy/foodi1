import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/class/statusrequest.dart';
import '../core/constant/routes.dart';
import '../core/functions/handlingData.dart';
import '../core/services/services.dart';
import '../data/datasource/remote/checkCoupon_data.dart';
import '../data/model/couponmodel.dart';
import '../data/model/crtitem.dart';
import '../data/model/itemsmodel.dart';

class CartControllerLocal extends GetxController {
  checkCouponData checkCoupondata = checkCouponData(Get.find());
  MyServices myServices = Get.find();
  late StatusRequest statusRequest;
  final couponModel = Rx<CouponModel?>(null);
  TextEditingController? controllercoupon;
  final discountcoupon = 0.obs;
  final couponname = "".obs;
  final couponid = 0.obs;
  final RxList<CartItem> cartItems = <CartItem>[].obs;
  @override
  void onInit() {
    controllercoupon = TextEditingController();
    super.onInit();
    loadCart();
  }
  num get totalPrice => cartItems.fold(0, (sum, item) => sum + (item.itemTotalPrice ?? 0));


  num get getOrderPrice {
    return couponModel.value != null
        ? (totalPrice - totalPrice * couponModel.value!.couponDiscount! / 100)
        : totalPrice;
  }

  void addToCart(ItemsModel item, int quantity, int unit) {
    final existingIndex = cartItems.indexWhere((items) => items.item.itemsId == item.itemsId);
    if (existingIndex >= 0) {
      // Use copyWith to create a new instance
      cartItems[existingIndex] = cartItems[existingIndex].copyWith(
        quantity: cartItems[existingIndex].quantity + quantity,
        unit: unit,
      );
    } else {
      cartItems.add(CartItem(item: item, quantity: quantity, unit: unit));
    }
    update(); // Notify listeners
    saveCart(); // Save to SharedPreferences
  }
  void removeFromCart(ItemsModel item, int quantity, int unit) {
    final existingIndex = cartItems.indexWhere((items) => items.item.itemsId == item.itemsId);
    if (existingIndex >= 0) {
      cartItems[existingIndex] = cartItems[existingIndex].copyWith(
        quantity: cartItems[existingIndex].quantity - quantity,
        unit: unit,
      );
      if (cartItems[existingIndex].quantity <= 0) {
        deleteFromCart(item.itemsId!);
      }
    }
    update();
    saveCart();
  }
  void deleteFromCart(int itemId) {
      cartItems.removeWhere((items) => items.item.itemsId == itemId);
      update();
    }

  bool checkItemInCart(ItemsModel targetItem){
      return  cartItems.any((items)=>items.item.itemsId==targetItem.itemsId);
    }

  goToPageProductDetails(itemsModel) {
    Get.toNamed("productdetails", arguments: {"itemsmodel": itemsModel});
  }

  checkcoupon() async {
    statusRequest = StatusRequest.loading;
    var response = await checkCoupondata.checkCoupon(controllercoupon!.text);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        couponModel.value = CouponModel.fromJson(response['data']);
        discountcoupon.value = couponModel.value!.couponDiscount!;
        couponname.value = couponModel.value!.couponName!;
        couponid.value = couponModel.value!.couponId!;
      } else {
        statusRequest = StatusRequest.failure;
        Get.snackbar("158".tr, "159".tr);
      }
    }
  }


  goToPageCheckout() {
    if (cartItems.isEmpty) return Get.snackbar("146".tr, "156".tr);
    Get.toNamed(AppRoute.checkout, arguments: {
      "couponid": couponid.value , // Null-safe access
    });
  }

  void saveCart() {
    List<String> cartJsonList = cartItems.map((item) => jsonEncode({
      'item': item.item.toJson(),
      'quantity': item.quantity,
      'unit': item.unit,
    })).toList();
    myServices.sharedPreferences.setStringList('cart', cartJsonList);
  }

  

  void loadCart() {
    List<String>? cartJsonList = myServices.sharedPreferences.getStringList('cart');
    if (cartJsonList != null) {
      cartItems.assignAll(cartJsonList.map((jsonString) {
        Map<String, dynamic> json = jsonDecode(jsonString);
        return CartItem(
          item: ItemsModel.fromJson(json['item']),
          quantity: json['quantity'],
          unit: json['unit'],
        );
      }).toList());
    }
  }

  void clearCart() {
    myServices.sharedPreferences.remove('cart');
    cartItems.clear();
      update();
    }
}