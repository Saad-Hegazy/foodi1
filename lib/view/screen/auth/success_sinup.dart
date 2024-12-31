import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/auth/successsignup_controller.dart';
import '../../../core/constant/color.dart';
import '../../widget/auth/custombuttomauth.dart';

class SuccessSignUp extends StatelessWidget {
  const SuccessSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    SuccessSignUpControllerImp controller =Get.put(SuccessSignUpControllerImp());
    return Scaffold(
      backgroundColor: AppColor.backgroundcolor,

      appBar:AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: AppColor.backgroundcolor,
        title:  Text('32'.tr,style: Theme.of(context).textTheme.displayLarge!.copyWith(color: AppColor.grey),),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
        children: [
            const Center(child: Icon(Icons.check_circle_outline,size: 200,color: AppColor.primaryColor,)),
          Text("37".tr,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(fontSize: 30)),
          Text("38".tr),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: CustomButtomAuth(  text: "31".tr, onPressed: () {
              controller.goToPageLogin();
            }),
          ),
          const SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
}
