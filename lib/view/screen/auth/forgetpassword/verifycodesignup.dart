import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import '../../../../controller/auth/verifycodesignup_controller.dart';
import '../../../../core/class/handlingdataview.dart';
import '../../../../core/constant/color.dart';
import '../../../widget/auth/customtextbodyauth.dart';
import '../../../widget/auth/customtexttitleauth.dart';

class VerifyCodeSignUp extends StatelessWidget {
  const VerifyCodeSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  Get.put(VerifyCodeSignUpControllerImp());
    return Scaffold(
        appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
        elevation: 0.0,
        title: Text('79'.tr,
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(color: AppColor.grey)),
      ),
      body:GetBuilder<VerifyCodeSignUpControllerImp>(
        builder:(controller)=>
        HandlingDataRequest(
        statusRequest : controller.statusRequest,widget:Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: ListView(children: [
          const SizedBox(height: 20),
           CustomTextTitleAuth(text: "80".tr),
          const SizedBox(height: 10),
           CustomTextBodyAuth(
              text:"81".tr + "  ${controller.phone}"),
          const SizedBox(height: 15),
          OtpTextField(
            textStyle: TextStyle(color: Colors.black),
            borderRadius: BorderRadius.circular(20),
            fieldWidth: 42.0,
            numberOfFields: 6,
            borderColor: AppColor.primaryColor,
            //set to true to show as box or false to show as dash
            showFieldAsBox: true,
            //runs when a code is typed in
            onCodeChanged: (String code) {
              //handle validation or checks here
            },
            //runs when every textfield is filled
            onSubmit: (String verificationCode){
              controller.goToSuccessSignUp( verificationCode);
              showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      title:  Text("82".tr,style: TextStyle(color: Colors.black),),
                      content: Text("83".tr + "$verificationCode",style: TextStyle(color: Colors.black)),
                    );
                  }
              );
            }, // end onSubmit
          ), const SizedBox(height: 40),
          InkWell(onTap: (){
            controller.goToForgetPassword();

          }, child:  Center(child: Text("187".tr , style: TextStyle(color: AppColor.primaryColor , fontSize: 20 ),)),)
        ]),
      ),
      )
      )
    );
  }
}