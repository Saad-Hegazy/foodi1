import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/class/statusrequest.dart';
import '../core/functions/handlingData.dart';
import '../core/services/services.dart';
import '../data/datasource/remote/cart_data.dart';
import '../data/datasource/remote/items_data.dart';
import '../data/model/itemsmodel.dart';
import 'home_controller.dart';
abstract class ItemsController extends GetxController {
  intialData();
  changeCat(int val, String catval);
  getItems(String categoryid , int page , int recordsPerPage);
  goToPageProductDetails(ItemsModel itemsModel);
}

class ItemsControllerImp extends SearchMixController {
  CartData cartData = CartData(Get.find());

  List categories = [];
  String? catid;
  int? selectedCat;
  ItemsData itemsData = ItemsData(Get.find());
  List data = [];
  Map itemisadd={};
  @override
  late StatusRequest statusRequest;
  MyServices myServices = Get.find();
  ScrollController scrollController = ScrollController();
  bool isLoading = false;  // Track if more data is being loaded
  bool datacompleted = false;  // Track if more data is being loaded
  int page = 1;  // Current page number
  final int recordsPerPage = 10;  // Number of records per page

  @override
  void onInit() {
    search = TextEditingController();
    intialData();
    super.onInit();
  }
  intialData() {
    categories = Get.arguments['categories'];
    selectedCat = Get.arguments['selectedcat'];
    catid = Get.arguments['catid'];
    getItems(catid!,page,recordsPerPage);
    scrollController.addListener(() {
          // Detect when the user scrolls to the bottom
          if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
            if (!isLoading) {
              loadMoreData();
            }
          }
        }
    );
  }
  setItem(id, val) {
    itemisadd[id] = val;
    update();
  }
  changeCat(val, catval) {
    selectedCat = val;
    catid = catval;
    getItems(catid!,1,recordsPerPage);
    update();
  }

  getItems(categoryid,page,recordsPerPage) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await itemsData.getData(
        categoryid,
        myServices.sharedPreferences.getString("id")!,
        page.toString(),
        recordsPerPage.toString()
    );
    print("=============================== ItemsController $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        if (page == 1) {
          data.clear();
        }
        data.addAll(response['data']);
      } else {
        datacompleted=true;
       statusRequest = StatusRequest.none;
      }
    } else {
      statusRequest = StatusRequest.failure;
    }
    update();
  }
  getItems2(categoryid,page,recordsPerPage) async {
    statusRequest = StatusRequest.none;
    update();
    var response = await itemsData.getData(
        categoryid,
        myServices.sharedPreferences.getString("id")!,
        page.toString(),
        recordsPerPage.toString()
    );
    print("=============================== ItemsController $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        if (page == 1) {
          data.clear();
        }
        data.addAll(response['data']);
      } else {
        datacompleted=true;
        statusRequest = StatusRequest.none;
      }
    } else {
      statusRequest = StatusRequest.failure;
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


  // Load more items when the user scrolls to the bottom
  Future<void> loadMoreData() async {
    if(datacompleted==false){
      isLoading = true;
      update();
      ItemsControllerImp controller = Get.find();
      await controller.getItems2(
        controller.catid,
        page + 1,
        recordsPerPage,
      );
      isLoading = false;
      page++;  // Increment page number for next load
      update();
    }

  }


  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
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

        Get.snackbar("155".tr, "154".tr,);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }
}