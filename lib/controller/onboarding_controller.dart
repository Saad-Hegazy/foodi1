import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/constant/routes.dart';
import '../core/services/services.dart';
import '../data/datasource/static/static.dart';
abstract class OnBoardingController extends GetxController{
  next();
  onPageChanged(int index);
}

class OnBoardingControllerImp extends OnBoardingController{

  MyServices myServices = Get.find();
  late  PageController pageController ;
  int currentPage=0;

  @override
  next() {
    currentPage++;
    if (currentPage > onBoardingList.length - 1) {
      myServices.sharedPreferences.setString("step", "1");
      Get.offAllNamed(AppRoute.login) ;
    } else {
      pageController.animateToPage(currentPage,
          duration: const Duration(milliseconds: 900), curve: Curves.easeInOut);
    }
  }

  @override
  onPageChanged(int index) {
    currentPage=index;
    update();
  }

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }
}