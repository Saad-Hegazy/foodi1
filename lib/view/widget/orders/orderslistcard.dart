import 'package:get/get.dart';
import '../../../controller/orders/pending_controller.dart';
import '../../../core/constant/color.dart';
import 'package:flutter/material.dart';
import '../../../core/constant/routes.dart';
import '../../../data/model/ordersmodel.dart';
class CardOrdersList extends GetView<OrdersPendingController> {
  final OrdersModel listdata;
  const CardOrdersList({Key? key, required this.listdata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("112 : #${listdata.ordersId}".tr,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  // Text(listdata.ordersDatetime!)
                  Text(
                    listdata.ordersDatetime!,
                    style: const TextStyle(
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const Divider(),
              Text(
                  "113 : ${controller.printOrderType(listdata.ordersType!)}".tr),
              Text("114 : ${listdata.ordersPrice?.toStringAsFixed(2)} SAR".tr),
              Text("115 : ${listdata.ordersPricedelivery?.toStringAsFixed(2)} SAR ".tr),
              Text(
                  "116 : ${controller.printPaymentMethod(listdata.ordersPaymentmethod!)} ".tr),
              Text(
                  "117 : ${controller.printOrderStatus(listdata.ordersStatus!)} ".tr),
              const Divider(),
              Text("118 : ${listdata.ordersTotalprice!.toStringAsFixed(2)} SAR ".tr,
                        style: const TextStyle(
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.bold)),
              Row(
                children: [
                  const Spacer(),
                  MaterialButton(
                    onPressed: () {
                      Get.toNamed(AppRoute.ordersdetails,
                          arguments: {"ordersmodel": listdata});
                    },
                    color: AppColor.thirdColor,
                    textColor: AppColor.secondColor,
                    child:  Text("119".tr),
                  ),
                  const SizedBox(width: 3),
                  if (listdata.ordersStatus! == 0) MaterialButton(
                    onPressed: () {
                      controller.deleteOrder(listdata.ordersId!);
                    },
                    color: AppColor.thirdColor,
                    textColor: AppColor.secondColor,
                    child:  Text("120".tr),
                  )
                ],
              ),
            ],
          )),
    );
  }
}