import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constant/color.dart';
import '../../core/constant/routes.dart';
import '../../core/localization/changelocal.dart';
import '../widget/language/custombuttomlang.dart';

class Language extends GetView<LocaleController> {
  const Language({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundcolor,
      body: Container(
        padding:const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text("1".tr,style:Theme.of(context).textTheme.displayLarge,),
            const SizedBox(height: 20,),
            CustomButtonLang(textbutton: 'Ar',onPressed: (){
              controller.changeLang("ar");
              Get.toNamed(AppRoute.OnBoarding);
            }),
            CustomButtonLang(textbutton: 'En',onPressed:(){
              controller.changeLang("en");
              Get.toNamed(AppRoute.OnBoarding);
            } ),


          ]
        )
      ),
    );
  }
}

