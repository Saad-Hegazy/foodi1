import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/class/statusrequest.dart';
import '../core/functions/handlingData.dart';
import '../core/services/services.dart';
import '../data/datasource/remote/cart_data.dart';
import '../data/datasource/remote/offers_data.dart';
import '../data/model/itemsmodel.dart';
import 'home_controller.dart';

class OffersController extends SearchMixController{

  OffersData  offersData = OffersData(Get.find());

  List<ItemsModel> data = [];
  CartData cartData = CartData(Get.find());

  MyServices myServices = Get.find();
  String? descountType;
  @override
  late StatusRequest statusRequest ;
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
  getData()async{
    statusRequest=StatusRequest.loading;
    var response = await offersData.getData( getDescount());
    print("=============== OffersController $response    ");
    statusRequest = handlingData(response);
    if(StatusRequest.success == statusRequest){
      if(response['status']=="success"){
        List listdata2 = response['data'];

        data.addAll(listdata2.map((e)=>ItemsModel.fromJson(e)));
        print("OffersController========$data");
      }else{
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }
  getPrice(itemsModel){
    switch(myServices.sharedPreferences.getString("userType")){
      case  "Normal User":
        if(itemsModel.itemsDescount >0){
          return  itemsModel.itemsPrice - itemsModel.itemsPrice *itemsModel.itemsDescount /100;
        }else {
          return  itemsModel.itemsPrice;
        }
      case  "mosque":
        if(itemsModel.itemsDescountMosque >0){
          return  itemsModel.itemsPriceMosque - itemsModel.itemsPriceMosque *itemsModel.itemsDescountMosque /100;
        }else {
          return  itemsModel.itemsPriceMosque;
        }
      case  "Merchant":
        if(itemsModel.itemsPriceMerchant >0){
          return  itemsModel.itemsPriceMerchant - itemsModel.itemsPriceMerchant *itemsModel.itemsDescountMerchant /100;
        }else {
          return  itemsModel.itemsPriceMerchant;
        }
    }
  }
  getPricewithoutDiscount(itemsModel){
    switch(myServices.sharedPreferences.getString("userType")){
      case  "Normal User":
          return  itemsModel.itemsPrice;
      case  "mosque":
          return  itemsModel.itemsPriceMosque;
      case  "Merchant":
          return  itemsModel.itemsPriceMerchant;
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


  addItems(int itemsid,String isbox, String itemprice,int countitembyunit) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await cartData.addCart(
      myServices.sharedPreferences.getString("id")!,
      itemsid.toString(),
      isbox,
      itemprice,
      countitembyunit,
    );
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        Get.snackbar("155".tr, "154".tr,);
        // data.addAll(response['data']);
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }



  @override
  void onInit() {
    search= TextEditingController();
    getDescount();
    getData();
    super.onInit();
  }
}
