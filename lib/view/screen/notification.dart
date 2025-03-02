import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controller/notification_controller.dart';
import '../../core/class/handlingdataview.dart';
import '../../core/constant/color.dart';
class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
Get.put(NotificationController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title:  Text('54'.tr,style: TextStyle(color: Colors.white)),
      ),
      body: GetBuilder<NotificationController>(
            builder: (controller) => HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: Container(
                    padding: const EdgeInsets.all(0),
                    child: ListView(children: [
                      ...List.generate(
                          controller.data.length,
                              (index) => Container(
                            child: Stack(
                              children: [
                                   ListTile(
                                    title: Text(controller.data[index]
                                    ['notification_title']  +"                                  "+ DateFormat('dd-MMM-yyyy').format(
                                      DateTime.parse(controller.data[index]['notification_datetime']),
                                    ),style: const TextStyle(
                                        color: AppColor.primaryColor,
                                        fontWeight: FontWeight.bold
                                    ),
                                    ),
                                    subtitle: Text(controller.data[index]
                                    ['notification_body']),
                                  ),



                              ],
                            ),
                          ))
                    ]))),
      ),
    );
  }
}