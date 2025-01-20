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
  @override
  late StatusRequest statusRequest;
  MyServices myServices = Get.find();
  ScrollController scrollController = ScrollController();
  bool isLoading = false;  // Track if more data is being loaded
  int page = 1;  // Current page number
  final int recordsPerPage = 20;  // Number of records per page

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

  changeCat(val, catval) {
    selectedCat = val;
    catid = catval;
    getItems(catid!,page,recordsPerPage);
    update();
  }

  getItems(categoryid,page,recordsPerPage) async {
    // Check if already loading to avoid multiple simultaneous requests
  //  if (statusRequest == StatusRequest.loading) return  update();
    statusRequest = StatusRequest.loading;  // Set loading status
    update();

    // Send request to the backend with pagination parameters
    var response = await itemsData.getData(
        categoryid,
        myServices.sharedPreferences.getString("id")!,
        page.toString(),
        recordsPerPage.toString()
    );

    print("=============================== ItemsController $response ");
    statusRequest = handlingData(response);  // Update the status based on the response

    if (StatusRequest.success == statusRequest) {
      // Check backend response
      if (response['status'] == "success") {
        // Add data to the existing list
        if (page == 1) {
          // If it's the first page, clear and add new data
          data.clear();
        }
        data.addAll(response['data']);  // Append new data to the list

        // Check if there's more data to load, handle UI accordingly
        // For example, you could set a "hasMore" flag here to indicate if more pages are available.
      } else {
        statusRequest = StatusRequest.failure;  // Set failure status if no data found
      }
    } else {
      statusRequest = StatusRequest.failure;  // Set failure if request failed
    }
    update();  // Update the UI after the response
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
  // Load the first page of items
  Future<void> _loadData() async {
      isLoading = true;
    update();

    ItemsControllerImp controller = Get.find();
    await controller.getItems(
      controller.catid,
      page,
      recordsPerPage,
    );

      isLoading = false;
   update();
  }
  // Load more items when the user scrolls to the bottom
  Future<void> loadMoreData() async {

      isLoading = true;
     update();
    ItemsControllerImp controller = Get.find();
    await controller.getItems(
      controller.catid,
       page + 1,
       recordsPerPage,
    );

      isLoading = false;
      page++;  // Increment page number for next load
      update();
  }
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  // addItems(int itemsid ,int isbox, String itemprice ) async {
  //   statusRequest = StatusRequest.loading;
  //   update();
  //   var response = await cartData.addCart(
  //       myServices.sharedPreferences.getString("id")!,
  //       itemsid.toString(),
  //       isbox,
  //       itemprice,
  //       1);
  //   print("=============================== Controller $response ");
  //   statusRequest = handlingData(response);
  //   if (StatusRequest.success == statusRequest) {
  //     // Start backend
  //     if (response['status'] == "success") {
  //       Get.rawSnackbar(
  //           backgroundColor:Colors.grey,
  //           title: "155".tr,
  //           messageText:  Text("154".tr,style: TextStyle(color: Colors.white),));
  //       // data.addAll(response['data']);
  //     } else {
  //       statusRequest = StatusRequest.failure;
  //     }
  //     // End
  //   }
  //   update();
  // }

}


























// class FavoriteController extends GetxController {
//   Map isFavorite = {};

//   setFavorite(id, val) {
//     isFavorite[id] = val;
//     print(isFavorite[id]);
//     update();
//   }
// }