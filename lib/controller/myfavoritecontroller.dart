import 'package:get/get.dart';

import '../core/class/statusrequest.dart';
import '../core/functions/handlingData.dart';
import '../core/services/services.dart';
import '../data/datasource/remote/myfavorite_data.dart';
import '../data/model/myfavorite.dart';
class MyFavoriteController extends GetxController {
  MyFavoriteData favoriteData = MyFavoriteData(Get.find());

  List<MyFavoriteModel> data = [];

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
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();

  }

  deleteFromFavorite(int favroiteid){
    favoriteData.deleteData(favroiteid.toString());
    data.removeWhere((element) => element.favoriteId == favroiteid);
    update();
  }
  goToPageProductDetails(MyFavoriteitemsModel) {
    Get.toNamed("productdetails", arguments: {"itemsmodel": MyFavoriteitemsModel});
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
  @override
  void onInit() {
    getData();
    super.onInit();
  }
}