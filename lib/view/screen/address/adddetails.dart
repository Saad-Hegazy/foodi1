import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/address/adddetails_controller.dart';
import '../../../core/class/handlingdataview.dart';
import '../../../core/shared/custombutton.dart';
import '../../widget/auth/customtextformauth.dart';


class AddressAddDetails extends StatelessWidget {
  const AddressAddDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddAddressDetailsController());
    return Scaffold(
      appBar: AppBar(
        title:  Text('93'.tr),
      ),
      body: Container(
          padding: const EdgeInsets.all(15),
          child: GetBuilder<AddAddressDetailsController>(
            builder: (controller) => HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: ListView(children: [
                  CustomTextFormAuth(
                      hinttext: "94".tr,
                      labeltext: "95".tr,
                      iconData: Icons.location_city,
                      mycontroller: controller.city,
                      valid: (val) {
                        return null;
                      },
                      isNumber: false),
                  CustomTextFormAuth(
                      hinttext: "96".tr,
                      labeltext: "97".tr,
                      iconData: Icons.streetview,
                      mycontroller: controller.street,
                      valid: (val) {
                        return null;
                      },
                      isNumber: false),
                  CustomTextFormAuth(
                      hinttext: "98".tr,
                      labeltext: "99".tr,
                      iconData: Icons.near_me,
                      mycontroller: controller.name,
                      valid: (val) {
                        return null;
                      },
                      isNumber: false),
                  CustomButton(
                    text: "100".tr,
                    onPressed: () {
                      controller.addAddress() ;
                    },
                  )
                ])),
          )),
    );
  }
}