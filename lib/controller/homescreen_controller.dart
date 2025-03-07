import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/class/statusrequest.dart';
import '../core/functions/handlingData.dart';
import '../core/services/services.dart';
import '../data/datasource/remote/cart_data.dart';
import '../data/model/cartmodel.dart';
import '../view/screen/cart.dart';
import '../view/screen/home.dart';
import '../view/screen/myfavorite.dart';
import '../view/screen/notification.dart';
import '../view/screen/offers.dart';
import '../view/screen/settings.dart';
import 'cart_controller.dart';
import 'home_controller.dart';
import 'myfavoritecontroller.dart';

abstract class HomeScreenController extends GetxController{
  changepage(int currentpage);
}

class  HomeScreenControllerImp extends HomeScreenController{
  MyFavoriteController myFavoritecontroller=Get.put(MyFavoriteController());
  HomeControllerImp homeController= Get.put(HomeControllerImp());
  CartController cartController = Get.put(CartController());


  int currentpage = 0;
  List<Widget> listPage = [
    const HomePage(),
    const OffersView(),
    const MyFavorite(),
    const Cart() ,
    const Settings()
  ];
  List bottomappbar = [
    {"title": "201", "icon": Icons.home_outlined},
    {"title": "212", "icon":Icons.local_offer_outlined },
    {"title": "195", "icon": Icons.favorite_border},
    {"title": "213", "icon": Icons.shopping_cart_outlined},
    {"title": "204", "icon": Icons.settings_outlined}
  ];
  @override
  changepage(int i) {
    if(i==0){
      homeController.refreshPage();
    }else if(i==1){
      homeController.refreshPage();
    }else if(i==2){
      myFavoritecontroller.getData();
    } else if(i==3){
      cartController.refreshPage();
    }
    currentpage=i;
    update();
  }
}