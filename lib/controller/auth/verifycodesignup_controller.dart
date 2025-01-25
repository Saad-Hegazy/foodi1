import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../core/class/statusrequest.dart';
import '../../core/constant/routes.dart';
import '../../core/functions/handlingData.dart';
import '../../data/datasource/remote/auth/verfiycodesignup.dart';

abstract class VerifyCodeSignUpController extends GetxController {
  checkCode();
  goToSuccessSignUp(String verfiyCodeSignUp);
}

class VerifyCodeSignUpControllerImp extends VerifyCodeSignUpController {
  VerfiyCodeSignUpData verfiyCodeSignUpData = VerfiyCodeSignUpData(Get.find());


  String? email;
  String? phone;
  String? verificationId;

  StatusRequest statusRequest=StatusRequest.none;

  @override
  checkCode() {}

  @override
  Future<void> goToSuccessSignUp(otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: otp,
      );
      // Sign in the user
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      print("Successfully signed in: ${userCredential.user?.uid}");
      statusRequest = StatusRequest.loading;
      update();
      var response = await verfiyCodeSignUpData.postdata(email!);
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
      }
      update();

    } catch (e) {
      print("Error verifying OTP: $e");
    }
  }


  @override
  void onInit() {
    email = Get.arguments['email'];
    phone = Get.arguments['phone'];
    verificationId = Get.arguments['verificationId'];
    super.onInit();
  }
  @override
  goToForgetPassword() {
    Get.toNamed(AppRoute.forgetPassword);
  }
}