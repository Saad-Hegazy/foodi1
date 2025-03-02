import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/class/statusrequest.dart';
import '../../core/constant/routes.dart';
import '../../core/functions/handlingData.dart';
import '../../core/services/notification_service.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/auth/login.dart';

abstract class LoginController extends GetxController {
  login();
  goToSignUp();
  goToForgetPassword();
}

class LoginControllerImp extends LoginController {

  LoginData loginData  = LoginData(Get.find()) ;

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController email;
  late TextEditingController password;

  bool isshowpassword = true;
  MyServices myServices=Get.find();
  StatusRequest statusRequest=StatusRequest.none ;
  showPassword() {
    isshowpassword = isshowpassword == true ? false : true;
    update();
  }
  @override
  login() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update() ;
      var response = await loginData.postdata(email.text , password.text);
      print("=============================== loginController $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          // data.addAll(response['data']);
          if (response['data']['users_approve'] == 1) {
            myServices.sharedPreferences.setString("id", response['data']['users_id'].toString());
            String userid = myServices.sharedPreferences.getString("id")!;
            myServices.sharedPreferences.setString("username", response['data']['users_name']);
            myServices.sharedPreferences.setString("email", response['data']['users_email']);
            myServices.sharedPreferences.setString("phone", response['data']['users_phone'].toString());
            myServices.sharedPreferences.setString("userType", response['data']['users_type']);
            myServices.sharedPreferences.setString("step", "2");
            switch (response['data']['users_type']){
              case "Normal User":
                FirebaseMessaging.instance.subscribeToTopic("users");
                FirebaseMessaging.instance.subscribeToTopic("users$userid");
                break;
              case "mosque":
                FirebaseMessaging.instance.subscribeToTopic("mosque");
                FirebaseMessaging.instance.subscribeToTopic("users$userid");
                break;
              case "Merchant":
                FirebaseMessaging.instance.subscribeToTopic("Merchant");
                FirebaseMessaging.instance.subscribeToTopic("users$userid");
                break;
            }
            NotificationService notificationService =NotificationService();
            String DeviceToken =await notificationService.getDeviceToken();
            myServices.sharedPreferences.setString("DeviceToken", DeviceToken);
            Get.offNamed(AppRoute.homepage);
          } else {
            Get.toNamed(AppRoute.verifyCodeSignUp,
                arguments: {"email": email.text});
          }
        } else {
          Get.defaultDialog(title: "158".tr , middleText: "179".tr,middleTextStyle: TextStyle(color: Colors.black));
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    } else {

    }
  }

  @override
  goToSignUp() {
    Get.offNamed(AppRoute.signUp);
  }
  @override
  void onInit() async{
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  goToForgetPassword() {
    Get.toNamed(AppRoute.forgetPassword);
  }
}