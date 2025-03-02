import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/auth/login_controller.dart';
import '../../../core/class/handlingdataview.dart';
import '../../../core/constant/color.dart';
import '../../../core/functions/alertexitapp.dart';
import '../../../core/functions/validinput.dart';
import '../../widget/auth/custombuttomauth.dart';
import '../../widget/auth/customtextbodyauth.dart';
import '../../widget/auth/customtextformauth.dart';
import '../../widget/auth/customtexttitleauth.dart';
import '../../widget/auth/logoauth.dart';
import '../../widget/auth/textsignup.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
        elevation: 0.0,
        title: Text("41".tr,
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(color: Colors.white)),
      ),
      body: WillPopScope(
          onWillPop: alertExitApp,
          child: GetBuilder<LoginControllerImp>(
            builder: (controller) =>
    HandlingDataRequest(
    statusRequest : controller.statusRequest,widget: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 15, horizontal: 30),
              child: Form(
                key: controller.formstate,
                child: ListView(children: [
                  const LogoAuth(),
                  const SizedBox(height: 20),
                  CustomTextTitleAuth(text: "10".tr),
                  const SizedBox(height: 10),
                  CustomTextBodyAuth(text: "11".tr),
                  const SizedBox(height: 15),
                  CustomTextFormAuth(
                    isNumber: false,
                    valid: (val) {
                      return validInput(val!, 5, 100, "email");
                    },
                    mycontroller: controller.email,
                    hinttext: "12".tr,
                    iconData: Icons.email_outlined,
                    labeltext: "18".tr,
                    // mycontroller: ,
                  ),
                  GetBuilder<LoginControllerImp>(
                    builder: (controller) => CustomTextFormAuth(
                      obscureText: controller.isshowpassword,
                      onTapIcon: () {
                        controller.showPassword();
                      },
                      isNumber: false,
                      valid: (val) {
                        return validInput(val!, 3, 30, "password");
                      },
                      mycontroller: controller.password,
                      hinttext: "13".tr,
                      iconData: Icons.remove_red_eye_outlined,
                      labeltext: "19".tr,
                      // mycontroller: ,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      controller.goToForgetPassword();
                    },
                    child: Text(
                      style: TextStyle(color: Colors.black),
                      "14".tr,
                      textAlign: TextAlign.right,
                    ),
                  ),
                  CustomButtomAuth(
                      text: "15".tr,
                      onPressed: () {
                        controller.login();
                      }),
                  const SizedBox(height: 40),
                  CustomTextSignUpOrSignIn(
                    textone: "16".tr,
                    texttwo: "17".tr,
                    onTap: () {
                      controller.goToSignUp();
                    },
                  )
                ]),
              ),
            ),
          )
          )
      ),
    );
  }
}