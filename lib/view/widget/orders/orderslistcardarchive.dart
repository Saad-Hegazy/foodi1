import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
                  Text("${"103".tr}: #${listdata.ordersId}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  // Text(listdata.ordersDatetime!)
                  Text(
                      DateFormat('dd-MMM-yyyy').format(
                        DateTime.parse(listdata.ordersDatetime!,),
                      ),
                    style: const  TextStyle(
                        color: AppColor.primaryColor,
                        fontSize:12)
                  )
                ],
              ),
              const Divider(),
              Text(
                  "${"104".tr} : ${controller.printOrderType(listdata.ordersType!)}"),
              Text("${"105".tr}: ${listdata.ordersTotalprice} SAR"),
              Text("${"106".tr}: ${listdata.ordersPricedelivery} SAR "),
              Text("${"107".tr} : ${controller.printPaymentMethod(listdata.ordersPaymentmethod!)} "),
              Text(
                  "${"108".tr}: ${controller.printOrderStatus(listdata.ordersStatus!)} "),
              const Divider(),
                  Text("${"109".tr}: ${listdata.ordersTotalprice!.toStringAsFixed(2)} SAR ",
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
                      child:  Text("110".tr, style: TextStyle(color: Colors.black),),
                    ),
                  const SizedBox(width: 3),
                  MaterialButton(
                    onPressed: () {
                      showDialogRating(context,listdata.ordersId!.toString());
                    },
                    color: AppColor.thirdColor,
                    textColor: AppColor.secondColor,
                    child:  Text("111".tr, style: TextStyle(color: Colors.black),),

                  ),
                ],
              ),
            ],
          )),
    );
  }
}