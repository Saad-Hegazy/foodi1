import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/class/statusrequest.dart';
import '../../core/constant/routes.dart';
import '../../core/functions/handlingData.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/auth/sinup.dart';
abstract class SignUpController extends GetxController {
  signUp();
  goToSignIn();
}
class SignUpControllerImp extends SignUpController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController password;
  String? selectedUserType ;
  String? verificationId ;
  bool isshowpassword = true;

  MyServices myServices=Get.find();

  StatusRequest statusRequest= StatusRequest.none;

  SignupData signupData = SignupData(Get.find());

  List data = [];
  void setUserType(String type) {
    selectedUserType = type;
    update();
  }
  @override
  signUp() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
            var response = await signupData.postdata(
              username.text,
              password.text,
              email.text,
              phone.text,
              selectedUserType!,
            );
            print("=============================== signUpController $response ");
            statusRequest = handlingData(response);
            if (StatusRequest.success == statusRequest) {
              if (response['status'] == "success") {
                // data.addAll(response['data']);
                requestOTP(phone.text);
                Get.offNamed(AppRoute.verifyCodeSignUp,arguments: {"email":email.text,"phone": phone.text,"verificationId": verificationId});
              } else {
                Get.defaultDialog(title: "158".tr , middleText: "173".tr,middleTextStyle:TextStyle(color: Colors.black)) ;
                statusRequest = StatusRequest.failure;
              }
            }
      update();
    } else {}
  }

  Future<void> requestOTP(String phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        // Auto verification in some cases
        print("Verification Completed: $credential");
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle errors
        print("Verification Failed: ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        // Store verification ID to use for sign-in
        print("Code Sent. Verification ID: $verificationId");
        verificationId =verificationId;
        // Save verificationId to use later
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Handle timeout
        print("Timeout: $verificationId");
      },
    );
  }


  showPassword() {
    isshowpassword = isshowpassword == true ? false : true;
    update();
  }
  @override
  goToSignIn() {
    Get.offNamed(AppRoute.login);
  }

  @override
  void onInit() {
    username = TextEditingController();
    phone = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    phone.text="+966";
    super.onInit();
  }

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    super.dispose();
  }
}