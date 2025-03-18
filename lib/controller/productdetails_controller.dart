import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/class/statusrequest.dart';
import '../core/services/services.dart';
import '../data/datasource/remote/checkCoupon_data.dart';
import '../data/model/cartmodel.dart';
import '../linkabi.dart';
import 'cartlocal_controller.dart';
abstract class ProductDetailsController extends GetxController {}

class ProductDetailsControllerImp extends ProductDetailsController {
  MyServices myServices = Get.find();
  final cartControllerLocal = Get.find<CartControllerLocal>();
  late StatusRequest statusRequest;
  var itemsModel;
  CartModel? cartModel ;
  RxBool isbox = false.obs;
  intialData() async {
    statusRequest = StatusRequest.loading;
    itemsModel = Get.arguments['itemsmodel'];
    final existingIndex = cartControllerLocal.cartItems.indexWhere(
            (item) => item.item.itemsId == itemsModel.itemsId);
    if(existingIndex>-1){
      cartControllerLocal.cartItems[existingIndex].unit==0?isbox.value=false:isbox.value=true;
    }else{
      isbox.value=false;
    }
    statusRequest = StatusRequest.success;
    update();
  }
   isBox(bool value) {
     isbox.value = value;
    update();
  }







  getPrice(itemsModel){
    switch(myServices.sharedPreferences.getString("userType")){
      case  "Normal User":
        if(itemsModel.itemsDescount >0){
          if(isbox.value){
            return  (itemsModel.itemspricrofbox - itemsModel.itemspricrofbox *itemsModel.itemsDescount /100) ;
          }else{
            return  itemsModel.itemsPrice - itemsModel.itemsPrice *itemsModel.itemsDescount /100;
          }
        }else {
          if(isbox.value){
            return  itemsModel.itemspricrofbox ;
          }else{
            return  itemsModel.itemsPrice;
          }

        }
      case  "mosque":
        if(itemsModel.itemsDescountMosque >0){
          if(isbox.value){
            return  (itemsModel.itemspricrofboxmosque - itemsModel.itemspricrofboxmosque *itemsModel.itemsDescountMosque /100);
          }else{
            return  itemsModel.itemsPriceMosque - itemsModel.itemsPriceMosque *itemsModel.itemsDescountMosque /100;
          }
        }else {
          if(isbox.value){
            return  itemsModel.itemspricrofboxmosque ;
          }else{
            return  itemsModel.itemsPriceMosque;
          }
        }
      case  "Merchant":
        if(itemsModel.itemsPriceMerchant >0){
          if(isbox.value){
            return  (itemsModel.itemspricrofboxmerchant - itemsModel.itemspricrofboxmerchant *itemsModel.itemsDescountMerchant /100) ;

          }else{
            return  itemsModel.itemsPriceMerchant - itemsModel.itemsPriceMerchant *itemsModel.itemsDescountMerchant /100;
          }
        }else {
          if(isbox.value){
            return  itemsModel.itemspricrofboxmerchant;

          }else{
            return  itemsModel.itemsPriceMerchant;

          }

        }

    }
  }

   void showFullScreenImage(BuildContext context) {
     showDialog(
       context: context,
       builder: (context) => Dialog(
         backgroundColor: Colors.transparent,
         child: GestureDetector(
           onTap: () => Get.back(),
           child: InteractiveViewer(
             minScale: 0.5,
             maxScale: 4.0,
             child: CachedNetworkImage(
               imageUrl: "${AppLink.imagestItems}/${itemsModel!.itemsImage!}",
               fit: BoxFit.contain,
             ),
           ),
         ),
       ),
     );
   }


  @override
  void onInit() {
    intialData();
    super.onInit();
  }
}