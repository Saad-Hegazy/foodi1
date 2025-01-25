import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../core/class/statusrequest.dart';
import '../../core/constant/routes.dart';
import '../../core/functions/handlingData.dart';
import '../../data/datasource/remote/auth/verfiycodesignup.dart';
import '../../data/datasource/remote/forgetpassword/verfycode.dart';
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
  Future<void> goToSuccessSignUp( String  otp) async {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: otp,
      );
      try {
        print("otp $otp");
      // Sign in the user
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        // OTP is correct, navigate to login page
        verifyuser();

      }
      } catch (e) {
        Get.defaultDialog(
            title: "158".tr,
            middleText: "172".tr);
      }
      update();
  }

  @override
  verifyuser() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await verfiyCodeSignUpData.verifydata(email!);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
          Get.offNamed(AppRoute.successSignUp);
      }
    }
    update();
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