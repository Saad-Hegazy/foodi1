import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/class/statusrequest.dart';
import '../core/constant/routes.dart';
import '../core/functions/handlingData.dart';
import '../core/services/services.dart';
import '../data/datasource/remote/cart_data.dart';
import '../data/datasource/remote/favorite_data.dart';
import '../data/datasource/remote/home_data.dart';
import '../data/model/cartmodel.dart';
import '../data/model/itemsmodel.dart';
import 'cart_controller.dart';
import 'favorite_controller.dart';


abstract class HomeController extends SearchMixController {
  initialData();
  getdata();
  goToItems(List categories, int selectedCat, String categoryid);
}

class HomeControllerImp extends HomeController {
  MyServices myServices = Get.find();
  CartData cartData = CartData(Get.find());
  FavoriteController favoriteController =Get.put(FavoriteController());
  CartController cartController =Get.put(CartController());
  List data = [];


  late StatusRequest statusRequest;
  String? username;
  String? id;
  String? lang;
  num totalcountitems = 0;

  @override
  HomeData homedata = HomeData(Get.find());

  List categories = [];
  List offers = [];
  List items = [];
  List imageSlider = [];

  @override
  initialData() {
    lang = myServices.sharedPreferences.getString("lang");
    username = myServices.sharedPreferences.getString("username");
    id = myServices.sharedPreferences.getString("id");
  }

  @override
  void onInit() {
    search = TextEditingController();
    getdata();
    initialData();
    view();
    super.onInit();
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
          data.clear();
          data.addAll(dataresponse.map((e) => CartModel.fromJson(e)));
          Map dataresponsecountprice = response['countprice'];
          totalcountitems = dataresponsecountprice['totalcount'];
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }
bool checkItemInCart(ItemsModel targetItem){
  return  data.any((item)=>item.cartItemsid==targetItem.itemsId);
}
  resetVarCart() {
    totalcountitems = 0;
  }

  refreshPage() {
    resetVarCart();
    view();
  }
  getDescount(){
    switch(myServices.sharedPreferences.getString("userType")){
      case  "Normal User":
        return "items_descount";
      case  "mosque":
        return "items_descount_mosque";
      case  "Merchant":
        return "items_descount_Merchant";
    }
  }
  @override
  getdata() async {
    statusRequest = StatusRequest.loading;
    var response = await homedata.getData(
        getDescount(),
        myServices.sharedPreferences.getString("userType")!,
        myServices.sharedPreferences.getString("id")!
    );
    print("=============================== HomeController $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        categories.addAll(response['categories']['data']);
        items.addAll(response['items']['data']);
        offers.addAll(response['offers']['data']);
        imageSlider.addAll(response['ImageSlider']['data']);

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
      return response['itemcount']["countitems"] as int;
    } else {
      statusRequest = StatusRequest.failure;
      return 0; // Return 0 as fallback
    }
  }

  @override
  goToItems(categories, selectedCat, categoryid) {
    Get.toNamed(AppRoute.items, arguments: {
      "categories": categories,
      "selectedcat": selectedCat,
      "catid": categoryid
    });
  }

  addItems(int itemsid,String isbox ,String itempriceforunit,int countitembyunit) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await cartData.addCart(
      myServices.sharedPreferences.getString("id")!,
      itemsid.toString(),
      isbox,
      itempriceforunit,
      countitembyunit,
    );
    print("=============================== addItemsController $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        cartController.setInCart(itemsid,"1");
        cartController.refreshPage();
        getCountItems(itemsid);
        refreshPage();
        // Get.snackbar("155".tr, "154".tr,);
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
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
        cartController.refreshPage();
        getCountItems(itemsid);
        refreshPage();
        // Get.snackbar("155".tr, "157".tr);
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
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

  goToPageProductDetails(MyFavoriteitemsModel) {
    Get.toNamed("productdetails", arguments: {"itemsmodel": MyFavoriteitemsModel});
  }
  goToPageProductDetailsItemModel(itemsModel) {
    Get.toNamed("productDetailsItemModel", arguments: {"itemsmodel": itemsModel});
  }
}

class SearchMixController extends GetxController {
  List<ItemsModel> listdata = [];
  late StatusRequest statusRequest;
  HomeData homedata = HomeData(Get.find());

  searchData() async {
    statusRequest = StatusRequest.loading;
    if(search!.text=="</>" || search!.text==">"||search!.text=="/"||search!.text=="<"||search!.text=="</"||search!.text==""){
      statusRequest = StatusRequest.failure;
    }else{
      var response = await homedata.searchData(search!.text);
      print("=============================== searchDataController $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          listdata.clear();
          List responsedata = response['data'];
          listdata.addAll(responsedata.map((e) => ItemsModel.fromJson(e)));
        } else {
          statusRequest = StatusRequest.failure;
        }
      }

    }

    update();
  }

  bool isSearch = false;
  TextEditingController? search;
  checkSearch(val) {
    if (val == "" || val =="<"||val ==">"||val =="/"||val =="</>") {
      statusRequest = StatusRequest.none;
      isSearch = false;
    }
    update();
  }

  onSearchItems() {
    isSearch = true;
    searchData();
    update();
  }
}