import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/class/statusrequest.dart';
import '../../core/constant/routes.dart';
import '../../core/functions/handlingData.dart';
import '../../data/datasource/remote/forgetpassword/checkemail.dart';
abstract class ForgetPassword extends GetxController {
  checkemail();
}

class ForgetPasswordImp extends ForgetPassword {
  CheckEmailData   checkemailData = CheckEmailData(Get.find());
  late TextEditingController email;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  StatusRequest statusRequest=StatusRequest.none;


  @override
  checkemail() async{
    if(formstate.currentState!.validate()){

      statusRequest = StatusRequest.loading;
      update();
      var response = await checkemailData.postdata(email.text);
     // print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          Get.offNamed(AppRoute.verifyCode,arguments: {
            "email":email.text
          });
        } else {
          Get.defaultDialog(title: "ُWarning" , middleText: " Email  Not Found") ;
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    } else {}
    }


  @override
  void onInit() {
    email = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }
}