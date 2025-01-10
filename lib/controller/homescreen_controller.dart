import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/screen/home.dart';
import '../view/screen/notification.dart';
import '../view/screen/offers.dart';
import '../view/screen/settings.dart';

abstract class HomeScreenController extends GetxController{
  changepage(int currentpage);
}

class  HomeScreenControllerImp extends HomeScreenController{
  int currentpage = 0;

  List<Widget> listPage = [
    const HomePage(),
    const NotificationView() ,
    const OffersView(),
    const Settings()
  ];
  List bottomappbar = [
    {"title": "home", "icon": Icons.home_outlined},
    {"title": "notifications", "icon": Icons.notifications_active_outlined},
    {"title": "Offers", "icon": Icons.local_offer_outlined},
    {"title": "settings", "icon": Icons.settings_outlined}
  ];
  @override
  changepage(int i) {
    currentpage=i;
    update();




  }

}