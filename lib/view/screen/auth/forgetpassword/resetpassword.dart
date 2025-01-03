import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/forgetpassword/resetpassword_controller.dart';
import '../../../../core/class/handlingdataview.dart';
import '../../../../core/constant/color.dart';
import '../../../../core/functions/validinput.dart';
import '../../../widget/auth/custombuttomauth.dart';
import '../../../widget/auth/customtextbodyauth.dart';
import '../../../widget/auth/customtextformauth.dart';
import '../../../widget/auth/customtexttitleauth.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ResetPasswordControllerImp());
    return Scaffold(
        appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.backgroundcolor,
        elevation: 0.0,
        title: Text('Reset Password',
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(color: AppColor.grey)),
      ),
      body: GetBuilder<ResetPasswordControllerImp>(builder: (controller)=>

          HandlingDataRequest(
            statusRequest : controller.statusRequest,widget:Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Form(
          key: controller.formstate,
          child: ListView(children: [
            const SizedBox(height: 20),
            CustomTextTitleAuth( text: "35".tr,),
            const SizedBox(height: 10),
            CustomTextBodyAuth(
                text: "35".tr),
            const SizedBox(height: 15),
            GetBuilder<ResetPasswordControllerImp>(builder: (controller)=>    CustomTextFormAuth(
              onTapIcon: (){
                controller.showPassword();
              },
              obscureText: controller.isshowpassword,
              mycontroller: controller.password,
              hinttext: "13".tr,
              iconData: Icons.remove_red_eye_outlined,
              labeltext: "19".tr,
              valid: (val ) {
                return validInput(val!, 5, 30, "password");
              }, isNumber: false,
            ),
            )
            ,
            GetBuilder<ResetPasswordControllerImp>(builder: (controller)=> CustomTextFormAuth(
              onTapIcon: (){
                controller.showrePassword();
              },
              obscureText: controller.isshowrepassword,
              valid: (val ) {
                return validInput(val!, 5, 30, "password");
              },
              mycontroller: controller.repassword,
              hinttext: "Re ${"13".tr}",
              iconData: Icons.remove_red_eye_outlined,
              labeltext:  "19".tr, isNumber: false,
              // mycontroller: ,
            ),),

            CustomButtomAuth( text: "33".tr, onPressed: () {
              controller.goToSuccessResetPassword();
            }),
            const SizedBox(height: 40),
          ]),
        ),
      ),
    )
      )

    );
  }
}