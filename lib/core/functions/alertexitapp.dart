import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> alertExitApp(){
   Get.defaultDialog(
    title: "140".tr,
    middleText: "139".tr,
    actions: [
      ElevatedButton(onPressed: (){
        exit(0);
      }, child:  Text("141".tr)),
      ElevatedButton(onPressed: (){
        Get.back();
      }, child:  Text("142".tr))
    ]
  );
   return Future.value(true);
}