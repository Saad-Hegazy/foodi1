
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../core/constant/routes.dart';
import '../../core/functions/handlingData.dart';
import '../../data/datasource/remote/forgetpassword/resetpassword.dart';

abstract class ResetPasswordController extends GetxController {

  reccetpasword();
  goToSuccessResetPassword();

}

class ResetPasswordControllerImp extends ResetPasswordController {
  ResetPasswordData resetPasswordData=ResetPasswordData(Get.find());
  StatusRequest statusRequest=StatusRequest.none;
  late TextEditingController  password;
  late TextEditingController repassword;
  GlobalKey<FormState> formstate =GlobalKey<FormState>();
  bool isshowpassword =true;
  bool isshowrepassword =true;


  String? email;


  @override
  reccetpasword() {

  }
  showPassword(){
    isshowpassword=isshowpassword==true?false:true;
    update();
  }
  showrePassword(){
    isshowrepassword=isshowrepassword==true?false:true;
    update();
  }

  @override
  void onInit() {
    email = Get.arguments['email'];
    password = TextEditingController();
    repassword = TextEditingController();
    super.onInit();
  }

  @override
  goToSuccessResetPassword() async {
    if (password.text != repassword.text) {
      return Get.defaultDialog(
          title: "158".tr, middleText: "170".tr);
    }

    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await resetPasswordData.postdata(email!, password.text);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          // data.addAll(response['data']);
          Get.offNamed(AppRoute.successResetPassword);
        } else {
          Get.defaultDialog(
              title: "158".tr, middleText: "153".tr);
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    } else {
    }
  }

  @override
  void dispose() {
    password.dispose();
    repassword.dispose();
    super.dispose();
  }
}
