import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
                  Text("112".tr + ": #${listdata.ordersId}",
                      style: const TextStyle(

                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  // Text(listdata.ordersDatetime!)
        Text(
          DateFormat('dd-MMM-yyyy').format(
            DateTime.parse(listdata.ordersDatetime!,),
          ),    style: const TextStyle(
            color: AppColor.primaryColor,
            fontSize:12),
        )
                ],
              ),
              const Divider(),
              Text("113".tr + ":${controller.printOrderType(listdata.ordersType!)}"),
              Text("114".tr + ": ${listdata.ordersPrice?.toStringAsFixed(2)} SAR"),
              Text("115".tr + ": ${listdata.ordersPricedelivery?.toStringAsFixed(2)} SAR"),
              Text("116".tr + ": ${controller.printPaymentMethod(listdata.ordersPaymentmethod!)}"),
              Text("117".tr+": ${controller.printOrderStatus(listdata.ordersStatus!)}"),
              const Divider(),
              Text("118".tr + ": ${listdata.ordersTotalprice!.toStringAsFixed(2)} SAR ",
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
                    child:  Text("119".tr,style: TextStyle(color: Colors.black)),
                  ),
                  const SizedBox(width: 3),
                  if (listdata.ordersStatus! == 0) MaterialButton(

                    onPressed: () {
                      Get.defaultDialog(
                          title: "158".tr,
                          middleText: "181".tr,
                          onCancel: (){},
                          onWillPop:null,
                          onConfirm:(){
                            controller.deleteOrder(listdata.ordersId!);
                            Get.back();
                          }
                      );

                    },
                    color: AppColor.thirdColor,
                    textColor: AppColor.secondColor,
                    child:  Text("120".tr,style: TextStyle(color: Colors.black)),
                  )
                ],
              ),
            ],
          )),
    );
  }
}