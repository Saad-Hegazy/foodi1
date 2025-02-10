import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import '../../../../controller/forgetpassword/verifycod_controller.dart';
import '../../../../core/constant/color.dart';
import '../../../widget/auth/countdownTimer.dart';
import '../../../widget/auth/customtextbodyauth.dart';
import '../../../widget/auth/customtexttitleauth.dart';



class VerfiyCode extends StatelessWidget {
  const VerfiyCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VerifyCodeControllerImp controller =
    Get.put(VerifyCodeControllerImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
        elevation: 0.0,
        title: Text('85'.tr,
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(color: AppColor.grey)),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: ListView(children: [
          const SizedBox(height: 20),
           CustomTextTitleAuth(text: "86".tr),
          const SizedBox(height: 10),
           CustomTextBodyAuth(
              text:
              "87".tr+" ${controller.email}"),
          const SizedBox(height: 15),
          OtpTextField(
            textStyle: TextStyle(color: Colors.black),
            fieldWidth: 42.0,
            borderRadius: BorderRadius.circular(20),
            numberOfFields: 6,
            borderColor:const  Color(0xff639c1d),
            //set to true to show as box or false to show as dash
            showFieldAsBox: true,
            //runs when a code is typed in
            onCodeChanged: (String code) {
              //handle validation or checks here
            },
            //runs when every textfield is filled
            onSubmit: (String verificationCode) {
              controller.goToResetPassword(verificationCode) ;
            },

            // end onSubmit
          ),
          const SizedBox(height: 20),
          CountdownTimerWidget(durationInSeconds: 60,),
          const SizedBox(height: 40),
          InkWell(onTap: (){
            controller.reSend() ;
          }, child:  Center(child: Text("88".tr , style: TextStyle(color: AppColor.primaryColor , fontSize: 20 ),)),)


        ]),
      ),
    );
  }
}