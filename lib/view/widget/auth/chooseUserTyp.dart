import 'package:flutter/material.dart';
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
        const Text(
          "Choose your account type",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        RadioListTile(
          title: const Text("Normal User"),
          value: "Normal User",
          groupValue: SignUpController.selectedUserType,
          onChanged: ( value) {
            if (value != null) {
              SignUpController.setUserType(value);
            }
          },
        ),
        RadioListTile(
          title: const Text("Mosque"),
          value: "mosque",
          groupValue: SignUpController.selectedUserType,
          onChanged: (value) {
            if (value != null) {
              SignUpController.setUserType(value);
            }
          },
        ),
        RadioListTile(
          title: const Text("Merchant"),
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
