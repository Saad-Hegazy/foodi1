
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/cart_controller.dart';
import '../../../core/constant/color.dart';
import 'buttoncart.dart';
import 'custombuttoncoupon.dart';

class BottomNavgationBarCart extends GetView<CartController> {
  final String price;
  final String discount;
  final String totalprice;
  final TextEditingController controllercoupon;
  final void Function()? onApplyCoupon;
  const BottomNavgationBarCart(
      {Key? key,
        required this.price,
        required this.discount,
        required this.totalprice,
        required this.controllercoupon,
        this.onApplyCoupon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColor.backgroundcolor2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GetBuilder<CartController>(
                builder: (controller) =>
                controller.couponname == null ?
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(children: [
                      Expanded(
                          flex: 2,
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            controller: controllercoupon,
                            decoration:  InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              hintText: "125".tr,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.primaryColor
                                ),),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColor.primaryColor),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColor.primaryColor),
                              ),
                            ),
                          )),
                      const SizedBox(width: 5),
                      Expanded(
                          flex: 1,
                          child: CustomButtonCoupon(
                            textbutton: "126".tr,
                            onPressed: onApplyCoupon,
                          ))
                    ]))
                    : Container(child: Text("127".tr+" ${controller.couponname!}" , style: const TextStyle(color: Colors.black , fontWeight: FontWeight.bold),))
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColor.primaryColor, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child:  Text("128".tr, style: TextStyle(fontSize: 16,color: Colors.black))),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text("$price SAR", style: const TextStyle(fontSize: 16,color: Colors.black)))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child:  Text("129".tr, style: TextStyle(fontSize: 16,color: Colors.black))),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text("$discount ", style: const TextStyle(fontSize: 16,color: Colors.black)))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child:  Text("130".tr, style: TextStyle(fontSize: 16,color: Colors.black))),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child:  Text("131".tr,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColor.primaryColor))),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text("$totalprice SAR",
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColor.primaryColor)))
                  ],
                ),
              ]),
            ),
            const SizedBox(height: 10),
          ],
        ));
  }
}
