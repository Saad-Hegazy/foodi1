import 'package:get/get.dart';
import '../../../controller/orders/archive_controller.dart';
import '../../../core/constant/color.dart';
import 'package:flutter/material.dart';
import '../../../core/constant/routes.dart';
import '../../../data/model/ordersmodel.dart';
import 'dialograting.dart';
class CardOrdersListArchive extends GetView<OrdersArchiveController> {
  final OrdersModel listdata;

  const CardOrdersListArchive({Key? key, required this.listdata})
      : super(key: key);

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
                  Text("103 : #${listdata.ordersId}".tr,
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
                  "104 : ${controller.printOrderType(listdata.ordersType!)}".tr),
              Text("105 : ${listdata.ordersPrice} \S\A\R".tr),
              Text("106 : ${listdata.ordersPricedelivery} \S\A\R ".tr),
              Text("107 : ${controller.printPaymentMethod(listdata.ordersPaymentmethod!)} ".tr),
              Text(
                  "108 : ${controller.printOrderStatus(listdata.ordersStatus!)} ".tr),
              const Divider(),
                  Text("109 : ${listdata.ordersTotalprice!.toStringAsFixed(2)} SAR ".tr,
                      style: const TextStyle(
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.bold)),
              Row(
                children: [
                  const Spacer(),
                  if (listdata.ordersStatus! == 4)
                    MaterialButton(
                      onPressed: () {
                        Get.toNamed(AppRoute.ordersdetails,
                            arguments: {"ordersmodel": listdata});
                      },
                      color: AppColor.thirdColor,
                      textColor: AppColor.secondColor,
                      child:  Text("110".tr),
                    ),
                  const SizedBox(width: 3),
                  MaterialButton(
                    onPressed: () {
                      showDialogRating(context,listdata.ordersId!.toString());
                    },
                    color: AppColor.thirdColor,
                    textColor: AppColor.secondColor,
                    child:  Text("111".tr),

                  ),
                ],
              ),
            ],
          )),
    );
  }
}