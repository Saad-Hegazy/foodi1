import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/screen/cart.dart';
import '../view/screen/home.dart';
import '../view/screen/myfavorite.dart';
import '../view/screen/offers.dart';
import '../view/screen/settings.dart';
abstract class HomeScreenController extends GetxController{
  changepage(int currentpage);
}
class  HomeScreenControllerImp extends HomeScreenController{
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
    currentpage=i;
    update();
  }
}