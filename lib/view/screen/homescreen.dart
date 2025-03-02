import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controller/homescreen_controller.dart';
import '../../core/constant/color.dart';
import '../../core/constant/routes.dart';
import '../widget/home/custombottomappbarhome.dart';
import 'package:badges/badges.dart' as badge;
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(HomeScreenControllerImp());
    return GetBuilder<HomeScreenControllerImp>(
        builder: (controller) => Scaffold(
          floatingActionButton: badge.Badge(
            position: badge.BadgePosition.topEnd(top: -5, end: 12),
            showBadge:0> 0, // Only show if count > 0
            badgeContent: Text(
              0.toString(),
              style: TextStyle(color: Colors.white),
            ),
            child: FloatingActionButton(
                backgroundColor: AppColor.primaryColor,
                onPressed: () async{
                  await  launch("https://wa.me/569222419");
                },
                child: const Icon(Icons.message,color:Colors.white,)),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: const CustomBottomAppBarHome(),
          body: WillPopScope(
              child: controller.listPage.elementAt(controller.currentpage),
              onWillPop: (){
                Get.defaultDialog(
                    title: "56".tr,
                    titleStyle: const TextStyle(fontWeight: FontWeight.bold,color: AppColor.primaryColor),
                    middleText: "57".tr,
                    middleTextStyle:const TextStyle(fontWeight: FontWeight.bold,color: AppColor.grey) ,
                    confirmTextColor:AppColor.primaryColor,
                    cancelTextColor: AppColor.primaryColor,
                    backgroundColor:AppColor.secondColor,
                    buttonColor:Colors.white,
                    onCancel: (){
                    },
                    onConfirm: (){
                             exit(0);
                        }
                );
                return Future.value(false);
              }),
        ));
  }
}
