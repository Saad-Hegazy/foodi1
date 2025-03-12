import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import '../../../../controller/auth/verifyemailcodesignup_controller.dart';
import '../../../../core/class/handlingdataview.dart';
import '../../../../core/constant/color.dart';
import '../../../widget/auth/countdownTimer.dart';
import '../../../widget/auth/customtextbodyauth.dart';
import '../../../widget/auth/customtexttitleauth.dart';

class VerifyEmailCodeSignUp extends StatelessWidget {
  const VerifyEmailCodeSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(VerifyEmailCodeSignUpControllerImp());
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
        body:GetBuilder<VerifyEmailCodeSignUpControllerImp>(
            builder:(controller)=>
                HandlingDataRequest(
                  statusRequest : controller.statusRequest,widget:Container(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: ListView(children: [
                    const SizedBox(height: 20),
                    CustomTextTitleAuth(text: "80".tr),
                    const SizedBox(height: 10),
                    CustomTextBodyAuth(
                        text:"${"81".tr}  ${controller.email}"),
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
                                content: Text("${"83".tr}$verificationCode",style: TextStyle(color: Colors.black)),
                              );
                            }
                        );
                      }, // end onSubmit
                    ), const SizedBox(height: 20),
                    CountdownTimerWidget(durationInSeconds: 60,),
                    const SizedBox(height: 40),
                    InkWell(onTap: (){
                      controller.reSend();

                    }, child:  Center(child: Text("187".tr , style: TextStyle(color: AppColor.primaryColor , fontSize: 20 ),)),)
                  ]),
                ),
                )
        )
    );
  }
}