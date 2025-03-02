import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/class/statusrequest.dart';
import '../core/constant/routes.dart';
import '../core/functions/handlingData.dart';
import '../core/services/services.dart';
import '../data/datasource/remote/cart_data.dart';
import '../data/datasource/remote/home_data.dart';
import '../data/model/itemsmodel.dart';


abstract class HomeController extends SearchMixController {
  initialData();
  getdata();
  goToItems(List categories, int selectedCat, String categoryid);
}

class HomeControllerImp extends HomeController {
  MyServices myServices = Get.find();
  CartData cartData = CartData(Get.find());
  late StatusRequest statusRequest;

  String? username;
  String? id;
  String? lang;

  @override
  HomeData homedata = HomeData(Get.find());

  // List data = [];
  List categories = [];
  List offers = [];
  List items = [];
  List imageSlider = [];
  int totalcount=0  ;
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
    super.onInit();
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
        totalcount=await response['totalcount']['data']["count(countitems)"];

      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }
  resetVar() {
    categories.clear();
    items.clear();
    offers.clear();
    imageSlider.clear();
    totalcount=0;
    }

  refreshPage() {
    resetVar();
    getdata();
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
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        Get.snackbar("155".tr, "154".tr,);
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



  goToPageProductDetails(itemsModel) {
    Get.toNamed("productdetails", arguments: {"itemsmodel": itemsModel});
  }
}

class SearchMixController extends GetxController {
  List<ItemsModel> listdata = [];
  late StatusRequest statusRequest;
  HomeData homedata = HomeData(Get.find());

  searchData() async {
    statusRequest = StatusRequest.loading;
    if(search!.text=="</>" || search!.text==">"||search!.text=="/"||search!.text=="/"){
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