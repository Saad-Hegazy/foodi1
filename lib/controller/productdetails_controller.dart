import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/class/statusrequest.dart';
import '../core/constant/routes.dart';
import '../core/functions/handlingData.dart';
import '../core/services/services.dart';
import '../data/datasource/remote/cart_data.dart';
import '../data/model/cartmodel.dart';
import '../data/model/itemsmodel.dart';
import '../linkabi.dart';
import 'cart_controller.dart';
abstract class ProductDetailsController extends GetxController {}

class ProductDetailsControllerImp extends ProductDetailsController {

  CartData cartData = CartData(Get.find());
   late StatusRequest statusRequest;
   MyServices myServices = Get.find();
  CartController cartController = Get.put(CartController());

  int countitems = 0;
   var itemsModel;
  CartModel? cartModel ;
   bool? isbox;
   bool? isunit;
   int? selectedCount;
  String? previousRoute;

  intialData() async {
    statusRequest = StatusRequest.loading;
    if(previousRoute=="/cart" ||previousRoute=="/homepage" ){
      itemsModel = Get.arguments['cartModel'];
      isbox=itemsModel.cartitemisbox==1?true:false;
      isunit=itemsModel.cartitemisbox==1?false:true;
      countitems =itemsModel.cartitemisbox==1
          ? (await getCountItems(itemsModel.itemsId!) ~/ itemsModel.itemsquantityinbox)
          : await getCountItems(itemsModel.itemsId!);

    }else{
      itemsModel = Get.arguments['itemsmodel'];
      isbox=false;
      isunit=false;
      countitems = await getCountItems(itemsModel!.itemsId!);
    }
    selectedCount = await getCountItems(itemsModel!.itemsId!);
    
    statusRequest = StatusRequest.success;
    update();
  }

  getCountItems(int itemsid) async {
    statusRequest = StatusRequest.loading;
    var response = await cartData.getCountCart(
        myServices.sharedPreferences.getString("id")!, itemsid.toString());
    print("=============================== getCountItemsProductDetailsController $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        return  response['data'];
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    update();
  }

   isBox(bool type) {
    isbox = type;
    isunit = !type;
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
         cartController.refreshPage();
       } else {
         statusRequest = StatusRequest.failure;
       }
     }
     update();
   }

   deleteitems(int itemsid) async {
     statusRequest = StatusRequest.loading;
     update();
     var response = await cartData.deleteCart(
         myServices.sharedPreferences.getString("id")!,
         itemsid.toString(),
     );
     print("=============================== deleteitemsController $response ");
     statusRequest = handlingData(response);
     if (StatusRequest.success == statusRequest) {
       if (response['status'] == "success") {
       } else {
         statusRequest = StatusRequest.failure;
       }
     }
     update();
   }



   addselectedCount(num itemprice){
     String itemisbox;
     int count;
     num? itempriceforunit;
     isbox!?count =(selectedCount!*itemsModel!.itemsquantityinbox!).toInt():count=selectedCount!;
     isbox!? itemisbox= "1" : itemisbox = "0";
     isbox!?itempriceforunit=itemprice /itemsModel!.itemsquantityinbox!:itempriceforunit=itemprice;
     addItems(itemsModel!.itemsId!,itemisbox,itempriceforunit.toString().toString(),count);
     Get.snackbar("155".tr, "154".tr,);
     update();
   }
  refreshcart(){
      if(previousRoute=="/cart"){
        CartController cartController = Get.put(CartController());
        cartController.refreshPage();
        Get.back();
      }else{
        Get.back();
      }
    }
   getPriceforcart(itemsModel){
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


   getPrice(itemsModel){
     switch(myServices.sharedPreferences.getString("userType")){
       case  "Normal User":
         if(itemsModel.itemsDescount >0){
           if(isbox!){
             return  (itemsModel.itemspricrofbox - itemsModel.itemspricrofbox *itemsModel.itemsDescount /100) ;
           }else{
             return  itemsModel.itemsPrice - itemsModel.itemsPrice *itemsModel.itemsDescount /100;
           }
         }else {
           if(isbox!){
             return  itemsModel.itemspricrofbox ;
           }else{
             return  itemsModel.itemsPrice;
           }

         }
       case  "mosque":
         if(itemsModel.itemsDescountMosque >0){
           if(isbox!){
             return  (itemsModel.itemspricrofboxmosque - itemsModel.itemspricrofboxmosque *itemsModel.itemsDescountMosque /100);
           }else{
             return  itemsModel.itemsPriceMosque - itemsModel.itemsPriceMosque *itemsModel.itemsDescountMosque /100;
           }
         }else {
           if(isbox!){
             return  itemsModel.itemspricrofboxmosque ;
           }else{
             return  itemsModel.itemsPriceMosque;
           }
         }
       case  "Merchant":
         if(itemsModel.itemsPriceMerchant >0){
           if(isbox!){
             return  (itemsModel.itemspricrofboxmerchant - itemsModel.itemspricrofboxmerchant *itemsModel.itemsDescountMerchant /100) ;

           }else{
             return  itemsModel.itemsPriceMerchant - itemsModel.itemsPriceMerchant *itemsModel.itemsDescountMerchant /100;
           }
         }else {
           if(isbox!){
             return  itemsModel.itemspricrofboxmerchant;

           }else{
             return  itemsModel.itemsPriceMerchant;

           }

         }

     }
   }

   getPricewithoutDiscount(itemsModel){
     switch(myServices.sharedPreferences.getString("userType")){
       case  "Normal User":
           if(isbox!){
             return  itemsModel.itemspricrofbox  ;
           }else{
             return  itemsModel.itemsPrice;
         }
       case  "mosque":
           if(isbox!){
             return  itemsModel.itemspricrofboxmosque;
           }else{
             return  itemsModel.itemsPriceMosque;
         }
       case  "Merchant":
           if(isbox!){
             return  itemsModel.itemspricrofboxmerchant;
           }else{
             return  itemsModel.itemsPriceMerchant;
         }
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
    previousRoute = Get.previousRoute;
    intialData();
    super.onInit();
  }
}