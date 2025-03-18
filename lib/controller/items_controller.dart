import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/class/statusrequest.dart';
import '../core/functions/handlingData.dart';
import '../core/services/services.dart';
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
  MyServices myServices = Get.find();
  ItemsData itemsData = ItemsData(Get.find());
  late StatusRequest statusRequest;
  List categories = [];
  String? catid;
  int? selectedCat;
  List data = [];
  @override
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
}