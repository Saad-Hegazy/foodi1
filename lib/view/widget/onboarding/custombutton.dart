import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/onboarding_controller.dart';
import '../../../core/constant/color.dart';

class CustomButtonOnBoarding extends GetView<OnBoardingControllerImp> {
  const CustomButtonOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return        Container(
    margin: const EdgeInsets.only(bottom: 30),
        height: 40,
        child: MaterialButton(
        padding: const EdgeInsets.symmetric(horizontal: 100,vertical: 4),
        textColor:Colors.white,
          onPressed: (){
          controller.next();
          },
          color: AppColor.primaryColor,
          child: Text("124".tr,),
        ),
        );
  }
}
