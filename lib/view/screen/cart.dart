import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/cartlocal_controller.dart';
import '../../core/constant/color.dart';
import '../widget/cart/buttoncart.dart';
import '../widget/cart/custom_bottom_navgationbar_cart.dart';
import '../widget/cart/customitemscartlist.dart';
import '../widget/cart/topcardcart.dart';
class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartControllerLocal = Get.find<CartControllerLocal>();
    return Scaffold(
      body: Obx(() => ListView(
        children: [
          AppBar(
            backgroundColor: AppColor.primaryColor,
            title: Text('71'.tr, style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 10),
          TopCardCart(
            message: "${"72".tr}  ${cartControllerLocal.cartItems.length}  ${"73".tr}",
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                ...cartControllerLocal.cartItems.map(
                        (item) => CustomItemsCartList(cartItemModel: item)
                ),
                BottomNavgationBarCart(
                    controllercoupon: cartControllerLocal.controllercoupon!,
                    onApplyCoupon: cartControllerLocal.checkcoupon,
                    price: cartControllerLocal.totalPrice.toStringAsFixed(2),
                    discount: "${cartControllerLocal.discountcoupon.value}%",
                    totalprice: cartControllerLocal.getOrderPrice.toStringAsFixed(2)
                )
              ],
            ),
          ),
        ],
      )
      ),
      bottomNavigationBar: CustomButtonCart(
        textbutton: "132".tr,
        onPressed: cartControllerLocal.goToPageCheckout,
      ),
    );
  }
}