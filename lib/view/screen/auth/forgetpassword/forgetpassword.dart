import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/forgetpassword/forgetpassword_controller.dart';
import '../../../../core/class/handlingdataview.dart';
import '../../../../core/constant/color.dart';
import '../../../../core/functions/validinput.dart';
import '../../../widget/auth/custombuttomauth.dart';
import '../../../widget/auth/customtextbodyauth.dart';
import '../../../widget/auth/customtextformauth.dart';
import '../../../widget/auth/customtexttitleauth.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ForgetPasswordImp());
    return Scaffold(
        appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
        elevation: 0.0,
        title: Text( '14'.tr,
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(color: Colors.white)),
      ),
      body: GetBuilder<ForgetPasswordImp>(
        builder: (controller)=>
        HandlingDataRequest(
        statusRequest : controller.statusRequest,widget:Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: Form(
            key: controller.formstate,
            child: ListView(children: [
              const SizedBox(height: 20),
              CustomTextTitleAuth(text: "27".tr),
              const SizedBox(height: 10),
              CustomTextBodyAuth(
                  text: "29".tr),
              const SizedBox(height: 15),
              CustomTextFormAuth(
                valid: (val ) {
                  return validInput(val!, 5, 100, "email");
                },
                mycontroller: controller.email,
                hinttext: "12".tr,
                iconData: Icons.email_outlined,
                labeltext: "18".tr, isNumber: false,
                // mycontroller: ,
              ),
              CustomButtomAuth(text: "30".tr, onPressed: () {
                controller.checkemail();
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