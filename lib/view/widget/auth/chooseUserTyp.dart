import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/auth/signup_controller.dart';
class chooseUserType extends StatelessWidget {
  const chooseUserType({
    super.key,
    required this.SignUpController,
  });
  final SignUpControllerImp SignUpController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Text(
          "175".tr,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
        ),
        RadioListTile(
          title:  Text("176".tr),
          value: "Normal User",
          groupValue: SignUpController.selectedUserType,
          onChanged: ( value) {
            if (value != null) {
              SignUpController.setUserType(value);
            }
          },
        ),
        RadioListTile(
          title:  Text("177".tr),
          value: "mosque",
          groupValue: SignUpController.selectedUserType,
          onChanged: (value) {
            if (value != null) {
              SignUpController.setUserType(value);
            }
          },
        ),
        RadioListTile(
          title:  Text("178".tr),
          value: "Merchant",
          groupValue: SignUpController.selectedUserType,
          onChanged: ( value) {
            if (value != null) {
              SignUpController.setUserType(value);
            }
          },
        ),
      ],
    );
  }
}
