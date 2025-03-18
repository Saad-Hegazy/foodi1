import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/class/statusrequest.dart';
import '../core/constant/routes.dart';
import '../core/functions/handlingData.dart';
import '../core/services/services.dart';
import '../data/datasource/remote/home_data.dart';
import '../data/model/itemsmodel.dart';
abstract class HomeController extends SearchMixController {
  initialData();
  getdata();
  void goToItems(List<dynamic>? categories, int selectedCat, String categoryid);
}
class HomeControllerImp extends HomeController {
  MyServices myServices = Get.find();
  @override
  HomeData homedata = HomeData(Get.find());
  late StatusRequest statusRequest;
  List categories = [];
  List offers = [];
  List items = [];
  List imageSlider = [];
  String? username;
  String? id;
  String? lang;

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
    categories.clear();
    items.clear();
    offers.clear();
    imageSlider.clear();
    statusRequest = StatusRequest.loading;
    var response = await homedata.getData(
        getDescount(),
        myServices.sharedPreferences.getString("userType")!,
    );
    print("=============================== HomeController $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        categories.addAll(response['categories']['data']);
        offers.addAll(response['offers']['data']);
        imageSlider.addAll(response['ImageSlider']['data']);
        items.addAll(response['items']['data']);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  goToItems(List<dynamic>? categories, int selectedCat, String categoryid) {
    Get.toNamed(AppRoute.items, arguments: {
      if (categories != null) "categories": categories,
      "selectedcat": selectedCat,
      "catid": categoryid,
    });
  }

  goToPageProductDetails(itemsModel) {
    Get.toNamed("productdetails", arguments: {"itemsmodel": itemsModel});
  }

}

class SearchMixController extends GetxController {
  HomeData homedata = HomeData(Get.find());
  TextEditingController? search;
  List<ItemsModel> listdata = [];
  late StatusRequest statusRequest;

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