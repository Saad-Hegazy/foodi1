import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/cart_controller.dart';
import '../../core/class/handlingdataview.dart';
import '../widget/cart/appbarcart.dart';
import '../widget/cart/custom_bottom_navgationbar_cart.dart';
import '../widget/cart/customitemscartlist.dart';
import '../widget/cart/topcardcart.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());
    return Scaffold(
        bottomNavigationBar: GetBuilder<CartController>(
            builder: (controller) => BottomNavgationBarCart(
                shipping: "0",
                controllercoupon: controller.controllercoupon!,
                onApplyCoupon: () {
                  controller.checkcoupon();
                },
                price: cartController.priceorders.toStringAsFixed(2),
                discount: "${controller.discountcoupon}%",
                totalprice: "${controller.getTotalPrice().toStringAsFixed(2)}")),
        body: GetBuilder<CartController>(
            builder: ((controller) => HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: ListView(
                  children: [
                     TopAppbarCart(
                      title: '71'.tr,
                    ),
                    const SizedBox(height: 10),
                    TopCardCart(
                        message:"72".tr + "  ${cartController.totalcountitems}  " + "73".tr),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          ...List.generate(
                            cartController.data!.length,
                                (index) => CustomItemsCartList(
                                onAdd: () async {
                                  await cartController
                                      .add(cartController.data![index].itemsId!);
                                  cartController.refreshPage();
                                },
                                onRemove: () async {
                                  await cartController.delete(
                                      cartController.data![index].itemsId!);
                                  cartController.refreshPage();
                                },
                                imagename:
                                "${cartController.data?[index].itemsImage}",
                                name: "${cartController.data?[index].itemsName}",
                                price:
                                "${cartController.getPrice(cartController.data![index])!.toStringAsFixed(2)} SAR",
                                count:
                                "${cartController.data?[index].countitems}"),
                          )
                        ],
                      ),
                    )
                  ],
                )))));
  }
}