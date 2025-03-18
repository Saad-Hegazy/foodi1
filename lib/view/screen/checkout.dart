import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/checkout_controller.dart';
import '../../core/class/handlingdataview.dart';
import '../../core/constant/color.dart';
import '../../core/constant/imageassets.dart';
import '../../core/constant/routes.dart';
import '../widget/checkout/carddeliveerytype.dart';
import '../widget/checkout/cardpaymentmethod.dart';
import '../widget/checkout/cardshippingaddress.dart';
class Checkout extends StatelessWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CheckoutController controller = Get.put(CheckoutController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title:  Text('61'.tr,style: TextStyle(color: Colors.white),),
      ),
      body: GetBuilder<CheckoutController>(
          builder: (controller) => HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: Container(
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                    children: [
                       Text(
                        "62".tr,
                        style: TextStyle(
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          controller.choosePaymentMethod("0");
                        },
                        child: CardPaymentMethodCheckout(
                            title: "64".tr,
                            isActive: controller.paymentMethod == "0" // cash
                                ? true
                                : false),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          controller.choosePaymentMethod("1");
                        },
                        child: CardPaymentMethodCheckout(
                            title: "65".tr,
                            isActive: controller.paymentMethod == "1" // Card
                                ? true
                                : false),
                      ),
                      const SizedBox(height: 20),
                       Text(
                        "66".tr,
                        style: TextStyle(
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.chooseDeliveryType("0");// 0 => Delivery
                            },
                            child: CardDeliveryTypeCheckout(
                                imagename: AppImageAsset.deliveryImage2,
                                title: "67".tr,
                                active: controller.deliveryType == "0"
                                    ? true
                                    : false),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              controller.chooseDeliveryType("1"); // 1 => recive
                            },
                            child: CardDeliveryTypeCheckout(
                                imagename: AppImageAsset.drivethruImage,
                                title: "68".tr,
                                active: controller.deliveryType == "1"
                                    ? true
                                    : false),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      if (controller.deliveryType == "0")
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(controller.dataaddress.isNotEmpty)   Text(
                              "69".tr,
                              style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            if(controller.dataaddress.isEmpty)
                               TextButton(
                                  onPressed: (){
                                  Get.toNamed(AppRoute.addressadd);
                                }, child: Container(
                                 margin: const EdgeInsets.symmetric(horizontal: 10),
                                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                 decoration: BoxDecoration(
                                     color: AppColor.secondColor,
                                     borderRadius: BorderRadius.circular(20)),
                                  child:  Center(child: Text("70".tr,
                                    style: TextStyle(color: AppColor.primaryColor,fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  )),
                                ),),
                            const SizedBox(height: 10),
                            ...List.generate(
                              controller.dataaddress.length,
                                  (index) => InkWell(
                                onTap: () {
                                  controller.chooseShippingAddress(
                                      controller.dataaddress[index].addressId!.toString(),
                                         controller.dataaddress[index].addressLat!.toString(),
                                         controller.dataaddress[index].addressLong!.toString()
                                  );
                                },
                                child: CardShppingAddressCheckout(
                                    title:
                                    "${controller.dataaddress[index].addressName}",
                                    body:
                                    "${controller.dataaddress[index].addressCity} ${controller.dataaddress[index].addressStreet}",
                                    isactive: controller.addressid == controller.dataaddress[index].addressId.toString()
                                        ? true
                                        : false),
                              ),
                            )
                          ],
                        )
                    ],
                  )
              )
          )
      ),
      bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: MaterialButton(
            color: AppColor.primaryColor,
            textColor: Colors.white,
            onPressed: () {
              controller.checkout();
            },
            child:  Text("62".tr,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.white)),
          )),
    );
  }
}