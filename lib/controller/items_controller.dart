import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/class/statusrequest.dart';
import '../core/functions/handlingData.dart';
import '../core/services/services.dart';
import '../data/datasource/remote/cart_data.dart';
import '../data/datasource/remote/favorite_data.dart';
import '../data/datasource/remote/items_data.dart';
import '../data/model/cartmodel.dart';
import '../data/model/itemsmodel.dart';
import '../data/model/myfavorite.dart';
import 'cart_controller.dart';
import 'home_controller.dart';
import 'myfavoritecontroller.dart';
abstract class ItemsController extends GetxController {
  intialData();
  changeCat(int val, String catval);
  getItems(String categoryid , int page , int recordsPerPage);
  goToPageProductDetails(ItemsModel itemsModel);
}

class ItemsControllerImp extends SearchMixController {
  CartData cartData = CartData(Get.find());
  FavoriteData favoriteData = FavoriteData(Get.find());

  CartController cartController =Get.put(CartController());
  MyFavoriteController myfavoriteController =    Get.put(MyFavoriteController());
  HomeControllerImp homeController=Get.put(HomeControllerImp());

  List categories = [];
  String? catid;
  int? selectedCat;
  ItemsData itemsData = ItemsData(Get.find());
  List data = [];
  List datacart = [];
  List dataFavorit = [];
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
    categories = Get.arguments?['categories']; // Optional, can be null
    selectedCat = Get.arguments!['selectedcat']; // Required, non-null
    catid = Get.arguments!['catid']; // Required, non-null
    getItems(catid, page, recordsPerPage); // catid is non-null here
    view();
    getfavoriteData();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
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
  bool checkItemInCart(ItemsModel targetItem){
    return  datacart.any((item)=>item.cartItemsid==targetItem.itemsId);
    // return true;
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
        view();
        cartController.refreshPage();
        getCountItems(itemsid);
        getItems(catid!,page,recordsPerPage);
        Get.snackbar("155".tr, "157".tr);
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
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

  goToPageProductDetails(itemsModel) {
    Get.toNamed("productdetails", arguments: {"itemsmodel": itemsModel});
  }
  goToPageProductDetailsItemModel(itemsModel) {
    Get.toNamed("productDetailsItemModel", arguments: {"itemsmodel": itemsModel});
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

  getfavoriteData() async {
    dataFavorit.clear();
    statusRequest = StatusRequest.loading;
    var response = await favoriteData
        .getData(myServices.sharedPreferences.getString("id")!);
    print("=============================== MyFavoriteController $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        List responsedata = response['data'];
        dataFavorit.addAll(responsedata.map((e) => MyFavoriteModel.fromJson(e)));

      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();

  }
  bool checkItemInFavorite(ItemsModel targetItem){
    return  dataFavorit.any((item)=>item.favoriteItemsid==targetItem.itemsId);
  }
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  removeFavorite(String itemsid) async {
    dataFavorit.clear();
    statusRequest = StatusRequest.loading;
    var response = await favoriteData.removeFavorite(
        myServices.sharedPreferences.getString("id")!, itemsid);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {

        getfavoriteData();

        Get.snackbar("144".tr, "143".tr,);
        // data.addAll(response['data']);
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();

  }
  addFavorite(String itemsid) async {
    dataFavorit.clear();
    statusRequest = StatusRequest.loading;
    var response = await favoriteData.addFavorite(
        myServices.sharedPreferences.getString("id")!, itemsid);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        getfavoriteData();

        Get.snackbar("146".tr, "145".tr,);
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();

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
      cartController.refreshPage();
        getCountItems(itemsid);
        getItems(catid, page, recordsPerPage);
        Get.snackbar("155".tr, "154".tr,);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }
  removeItems(int itemsid,String isbox, String itempriceforunit,int countitembyunit) async {
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
        cartController.refreshPage();
        getCountItems(itemsid);
        getItems(catid, page, recordsPerPage);
        Get.snackbar("155".tr, "157".tr);

      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }
}