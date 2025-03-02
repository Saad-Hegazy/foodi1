import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/class/statusrequest.dart';
import '../core/functions/handlingData.dart';
import '../core/services/services.dart';
import '../data/datasource/remote/cart_data.dart';
import '../data/model/cartmodel.dart';
import '../view/screen/home.dart';
import '../view/screen/notification.dart';
import '../view/screen/categoriesview.dart';
import '../view/screen/settings.dart';

abstract class HomeScreenController extends GetxController{
  changepage(int currentpage);
}

class  HomeScreenControllerImp extends HomeScreenController{
  int currentpage = 0;
  List<Widget> listPage = [
    const HomePage(),
    const NotificationView() ,
    const CategoriesView(),
    const Settings()
  ];
  List bottomappbar = [
    {"title": "201", "icon": Icons.home_outlined},
    {"title": "202", "icon": Icons.notifications_active_outlined},
    {"title": "203", "icon":Icons.grid_view, },
    {"title": "204", "icon": Icons.settings_outlined}
  ];
  @override
  changepage(int i) {
    currentpage=i;
    update();
  }
}