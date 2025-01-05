import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/notification_controller.dart';
import '../../core/class/handlingdataview.dart';
import '../../core/constant/color.dart';
class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
Get.put(NotificationController());
    return Container(
      child: GetBuilder<NotificationController>(
          builder: (controller) => HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: Container(
                  padding: const EdgeInsets.all(10),
                  child: ListView(children: [
                     Center(
                        child: Text(
                          "54".tr,
                          style: TextStyle(
                              fontSize: 18,
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.bold),
                        )),
                    const SizedBox(height: 10),
                    ...List.generate(
                        controller.data.length,
                            (index) => Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: Stack(
                            children: [
                              ListTile(
                                title: Text(controller.data[index]
                                ['notification_title']),
                                subtitle: Text(controller.data[index]
                                ['notification_body']),
                              ),
                              Positioned(
                                  right: 5,
                                  top: -10,
                                  child: Text(
                                   controller.data[index]['notification_datetime'],
                                    style:const TextStyle(
                                        color: AppColor.primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        ))
                  ])))),
    );
  }
}