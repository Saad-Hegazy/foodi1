import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/cart_controller.dart';
import '../../core/class/handlingdataview.dart';
import '../../core/constant/color.dart';
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
                controllercoupon: controller.controllercoupon!,
                onApplyCoupon: () {
                  controller.checkcoupon();
                },
                price: cartController.getTotalPrice().toStringAsFixed(1),
                discount: "${controller.discountcoupon}%",
                totalprice: "${controller.getTotalPrice().toStringAsFixed(1)}")),
        body: GetBuilder<CartController>(
            builder: ((controller) => HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: ListView(
                  children: [
                    AppBar(
                      backgroundColor: AppColor.primaryColor,
                      title:  Text('71'.tr,style: TextStyle(color: Colors.white),),
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
                              count: cartController.data![index].cartitemisbox==1?(cartController.data![index].countitems!/cartController.data![index].itemsquantityinbox!.toInt()):cartController.data![index].countitems!,
                              onAdd: () async {
                                await cartController
                                    .addfromcartpage(
                                  cartController.data![index].itemsId!,
                                  cartController.data![index].cartitemisbox!.toString(),
                                  cartController.data![index].cartitemprice.toString(),
                                  cartController.data![index].cartitemisbox==1?cartController.data![index].cartitemcount!+cartController.data![index].itemsquantityinbox!.toInt():cartController.data![index].cartitemcount!+1,
                                );
                                cartController.refreshcartPage();
                                Get.snackbar("155".tr, "154".tr,);
                              },
                               onDelet: () async {
                                await cartController.delete(
                                  cartController.data![index].itemsId!,
                                );
                                cartController.refreshcartPage();
                              },
                              onRemove:() async {
                                await cartController
                                    .add(
                                  cartController.data![index].itemsId!,
                                  cartController.data![index].cartitemisbox!.toString(),
                                  cartController.data![index].cartitemprice.toString(),
                                  cartController.data![index].cartitemisbox==1?cartController.data![index].cartitemcount!- cartController.data![index].itemsquantityinbox!.toInt():cartController.data![index].cartitemcount!-1,
                                );
                                cartController.refreshcartPage();
                                Get.snackbar("155".tr, "154".tr,);
                              },
                              imagename:
                              "${cartController.data?[index].itemsImage}",
                              unit:"${cartController.data?[index].cartitemisbox==1? "192".tr :"191".tr}",
                              name: "${cartController.data?[index].itemsName}",
                              totalitemeprice:
                              cartController.data![index].totalitemsPrice!.toStringAsFixed(1),
                              price:cartController.getPrice(cartController.data![index]),
                              cartModel: cartController.data![index],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )))));
  }
}