import 'package:get/get.dart';

import '../core/class/statusrequest.dart';
import '../core/functions/handlingData.dart';
import '../core/services/services.dart';
import '../data/datasource/remote/cart_data.dart';
import '../data/datasource/remote/myfavorite_data.dart';
import '../data/model/cartmodel.dart';
import '../data/model/itemsmodel.dart';
import '../data/model/myfavorite.dart';
import 'cart_controller.dart';
import 'favorite_controller.dart';
import 'home_controller.dart';
class MyFavoriteController extends GetxController {
  MyFavoriteData favoriteData = MyFavoriteData(Get.find());
  CartData cartData = CartData(Get.find());
  List datacart = [];

  List<MyFavoriteModel> data = [];
  FavoriteController favoriteController= Get.put(FavoriteController());
  HomeControllerImp homeController=Get.put(HomeControllerImp());
  CartController cartController =Get.put(CartController());

  late StatusRequest statusRequest;

  MyServices myServices = Get.find();

//  key => id items
//  Value => 1 OR 0

  getData() async {
    data.clear();
    statusRequest = StatusRequest.loading;
    var response = await favoriteData
        .getData(myServices.sharedPreferences.getString("id")!);
    print("=============================== MyFavoriteController $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        List responsedata = response['data'];
        data.addAll(responsedata.map((e) => MyFavoriteModel.fromJson(e)));
        view();
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();

  }
  bool checkItemInFavorite(ItemsModel targetItem){
    return  data.any((item)=>item.favoriteItemsid==targetItem.itemsId);
  }
  deleteFromFavorite(int favroiteid){
    favoriteData.deleteData(favroiteid.toString());
    // data.removeWhere((element) => element.favoriteId == favroiteid);
    getData();
    homeController.getfavoriteData();
    update();
  }
  goToPageProductDetails(MyFavoriteitemsModel) {
    Get.toNamed("productdetails", arguments: {"itemsmodel": MyFavoriteitemsModel});
  }
  goToPageProductDetailsItemModel(itemsModel) {
    Get.toNamed("productDetailsItemModel", arguments: {"itemsmodel": itemsModel});
  }
   getPrice(itemsModel){
    switch(myServices.sharedPreferences.getString("userType")){
      case  "Normal User":
        if(itemsModel.itemsDescount! >0){
          return  itemsModel.itemsPrice! - itemsModel.itemsPrice! *itemsModel.itemsDescount! /100;
        }else {
          return  itemsModel.itemsPrice!;
        }
      case  "mosque":
        if(itemsModel.itemsDescountMosque! >0){
          return  itemsModel.itemsPriceMosque! - itemsModel.itemsPriceMosque! *itemsModel.itemsDescountMosque! /100;
        }else {
          return  itemsModel.itemsPriceMosque!;
        }
      case  "Merchant":
        if(itemsModel.itemsPriceMerchant! >0){
          return  itemsModel.itemsPriceMerchant! - itemsModel.itemsPriceMerchant! *itemsModel.itemsDescountMerchant! /100;
        }else {
          return  itemsModel.itemsPriceMerchant!;
        }
    }
  }

  addItems(int itemsid,String isbox, String itempriceforunit,int countitembyunit) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await cartData.addCart(
      myServices.sharedPreferences.getString("id")!,
      itemsid.toString(),
      isbox,
      itempriceforunit,
      countitembyunit,
    );
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        view();
        // Get.snackbar("155".tr, "154".tr,);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }
  getPricewithoutDiscount(itemsModel){
    switch(myServices.sharedPreferences.getString("userType")){
      case  "Normal User":
        return  itemsModel.itemsPrice!;
      case  "mosque":
        return  itemsModel.itemsPriceMosque!;
      case  "Merchant":
        return  itemsModel.itemsPriceMerchant!;
    }
  }
  view() async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
    await cartData.viewCart(myServices.sharedPreferences.getString("id")!,
        myServices.sharedPreferences.getString("userType")!);
    print("=============================== viewController $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        if (response['datacart']['status'] == 'success') {
          List dataresponse = response['datacart']['data'];
          datacart.clear();
          datacart.addAll(dataresponse.map((e) => CartModel.fromJson(e)));
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }
  Future<int> getCountItems(int itemsid) async {
    statusRequest = StatusRequest.loading;
    var response = await cartData.getItemCount(
      myServices.sharedPreferences.getString("id")!,
      myServices.sharedPreferences.getString("userType")!,
      itemsid.toString(),
    );

    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest && response['status'] == "success") {
      return response['itemcount'];
    } else {
      statusRequest = StatusRequest.failure;
      return 0; // Return 0 as fallback
    }
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
        getCountItems(itemsid);
        getData();
        // Get.snackbar("155".tr, "157".tr);
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }
  amountofDiscount(itemsModel){
    switch(myServices.sharedPreferences.getString("userType")){
      case  "Normal User":
        if(itemsModel.itemsDescount >0){
          return itemsModel.itemsDescount;
        }else{
          return 0 ;
        }
      case  "mosque":
        if(itemsModel.itemsDescountMosque >0){
          return itemsModel.itemsDescountMosque;
        }else{
          return 0 ;
        }
      case  "Merchant":
        if(itemsModel.itemsPriceMerchant >0){
          return itemsModel.itemsPriceMerchant;
        }else{
          return 0 ;
        }
    }
  }
  bool checkItemInCart(MyFavoriteModel targetItem){
    return  datacart.any((item)=>item.cartItemsid==targetItem.itemsId);
  }
  hasDiscount(itemsModel){
    switch(myServices.sharedPreferences.getString("userType")){
      case  "Normal User":
        if(itemsModel.itemsDescount >0){
          return 1;
        }else{
          return 0 ;
        }
      case  "mosque":
        if(itemsModel.itemsDescountMosque >0){
          return 1;
        }else{
          return 0 ;
        }
      case  "Merchant":
        if(itemsModel.itemsPriceMerchant >0){
          return 1;
        }else{
          return 0 ;
        }
    }
  }
  @override
  void onInit() {
    getData();
    super.onInit();
  }
}