import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/cart_controller.dart';
import '../../controller/home_controller.dart';
import '../../controller/myfavoritecontroller.dart';
import '../../core/constant/color.dart';
import '../widget/cart/buttoncart.dart';
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
            builder: (controller) => CustomButtonCart(
      textbutton: "132".tr,
      onPressed: () {
        controller.goToPageCheckout() ;
      },
    )),
        body: GetBuilder<CartController>(
            builder: ((controller) => ListView(
                  children: [
                    AppBar(
                      backgroundColor: AppColor.primaryColor,
                      title:  Text('71'.tr,style: TextStyle(color: Colors.white),),
                    ),
                    const SizedBox(height: 10),
                    TopCardCart(
                        message:"${"72".tr}  ${cartController.totalcountitems}  ${"73".tr}"),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          ...List.generate(
                            cartController.data!.length,
                                (index) => CustomItemsCartList(
                              onAdd: () async {
                                await cartController
                                    .addfromcartpage(
                                  cartController.data![index].itemsId!,
                                  cartController.data![index].cartitemisbox!.toString(),
                                  cartController.data![index].cartitemprice.toString(),
                                  cartController.data![index].cartitemisbox==1?cartController.data![index].cartitemcount!+cartController.data![index].itemsquantityinbox!.toInt():cartController.data![index].cartitemcount!+1,
                                );
                                HomeControllerImp homeController=Get.put(HomeControllerImp());
                                homeController.refreshPage();
                                MyFavoriteController myFavoriteController=Get.put(MyFavoriteController());
                                myFavoriteController.getData();
                              },
                               onDelet: () async {
                                await cartController.delete(
                                  cartController.data![index].itemsId!,
                                );
                                // HomeControllerImp homeController=Get.put(HomeControllerImp());
                                // homeController.refreshPage();
                                // MyFavoriteController myFavoriteController=Get.put(MyFavoriteController());
                                // myFavoriteController.getData();
                              },
                              onRemove:() async {
                                await cartController
                                    .remove(
                                  cartController.data![index].itemsId!,
                                  cartController.data![index].cartitemisbox!.toString(),
                                  cartController.data![index].cartitemprice.toString(),
                                  cartController.data![index].cartitemisbox==1?cartController.data![index].cartitemcount!- cartController.data![index].itemsquantityinbox!.toInt():cartController.data![index].cartitemcount!-1,
                                );
                                // HomeControllerImp homeController=Get.put(HomeControllerImp());
                                // homeController.refreshPage();
                                // MyFavoriteController myFavoriteController=Get.put(MyFavoriteController());
                                // myFavoriteController.getData();
                              },
                              imagename:
                              "${cartController.data?[index].itemsImage}",
                              unit:cartController.data?[index].cartitemisbox==1? "192".tr :"191".tr,
                              name: "${cartController.data?[index].itemsName}",
                              namear: "${cartController.data?[index].itemsNameAr}",
                              price:cartController.getPrice(cartController.data![index]).toStringAsFixed(1),
                              totalitemeprice: cartController.data![index].totalitemsPrice!.toStringAsFixed(1),
                              cartModel: cartController.data![index],
                            ),
                          ),
                          BottomNavgationBarCart(
                              controllercoupon: controller.controllercoupon!,
                              onApplyCoupon: () {
                                controller.checkcoupon();
                              },
                              price: controller.priceorders.toStringAsFixed(1),
                              discount: "${controller.discountcoupon}%",
                              totalprice: "${controller.getTotalPrice().toStringAsFixed(1)}")
                        ],
                      ),
                    )
                  ],
                ))));
  }
}