import 'package:get/get.dart';
import '../../core/class/statusrequest.dart';
import '../../core/constant/color.dart';
import '../../core/constant/routes.dart';
import '../../core/functions/handlingData.dart';
import '../../data/datasource/remote/auth/verfiycodesignup.dart';
import '../../data/datasource/remote/forgetpassword/verfycode.dart';
import 'package:flutter/material.dart';
abstract class VerifyCodeSignUpController extends GetxController {
  checkCode();
  goToSuccessSignUp(String verfiyCodeSignUp);
}

class VerifyEmailCodeSignUpControllerImp extends VerifyCodeSignUpController {
  VerfiyCodeSignUpData verfiyCodeSignUpData = VerfiyCodeSignUpData(Get.find());
  String? email;
  VerifyCodeForgetPasswordData verifyCodeForgetPasswordData =
  VerifyCodeForgetPasswordData(Get.find());
  StatusRequest statusRequest=StatusRequest.none;

  @override
  checkCode() {}

  @override
  Future<void> goToSuccessSignUp( String  verfiyCodeSignUp) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await verfiyCodeSignUpData.postdata(
        email!, verfiyCodeSignUp);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        Get.offNamed(AppRoute.successSignUp);
      } else {
        Get.defaultDialog(
            title: "158".tr,
            middleText: "172".tr);
        statusRequest = StatusRequest.failure;
      }
      update();
    }
  }



  @override
  void onInit() {
    email = Get.arguments['email'];
    super.onInit();
  }
  reSend(){
    verifyCodeForgetPasswordData.resendData(email!);
    Get.rawSnackbar(
        backgroundColor:AppColor.primaryColor,
        title: "89".tr,
        messageText:  Text("185".tr,style: TextStyle(color: Colors.white),));
  }
}