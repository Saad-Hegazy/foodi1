import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/cartlocal_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/functions/translatefatabase.dart';
import '../../../core/functions/truncatetext.dart';
import '../../../data/model/crtitem.dart';
import '../../../linkabi.dart';
class CustomItemsCartList extends GetView<CartControllerLocal> {
  final CartItem cartItemModel;
  const CustomItemsCartList({
    Key? key,
    required this.cartItemModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartControllerLocal = Get.find<CartControllerLocal>();
    return Dismissible(
      key: Key(cartItemModel.item.itemsId.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: AppColor.primaryColor,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white, size: 30),
      ),
      onDismissed: (direction) {
        cartControllerLocal.deleteFromCart(cartItemModel.item.itemsId!);
      },
      child: InkWell(
        onTap: () {
          cartControllerLocal.goToPageProductDetails(cartItemModel.item);
        },
        child: Card(
          color: AppColor.backgroundcolor2,
          shadowColor: AppColor.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(
                    imageUrl:
                    "${AppLink.imagestItems}/${cartItemModel.item.itemsImage}",
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        translateDatabase(
                          truncateProductName(cartItemModel.item.itemsNameAr!),
                          truncateProductName(cartItemModel.item.itemsName!),
                        ),
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${cartItemModel.unit == 0 ? cartItemModel.item.itemPrice?.toStringAsFixed(2) : cartItemModel.item.itemPriceBox?.toStringAsFixed(2)} ${"190".tr} ${cartItemModel.unit==0?"184".tr:"183".tr}",
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${cartItemModel.itemTotalPrice?.toStringAsFixed(2)} SAR",
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primaryColor),
                    ),
                    const SizedBox(height: 8),
                    // Reactive cart controls remain inside Obx
                    Obx(() {
                      final existingIndex =
                      cartControllerLocal.cartItems.indexWhere((item) =>
                      item.item.itemsId == cartItemModel.item.itemsId);
                      final isInCart = existingIndex != -1;

                      return isInCart
                          ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (cartControllerLocal
                                  .cartItems[existingIndex].quantity <
                                  2) {
                                cartControllerLocal.deleteFromCart(
                                    cartItemModel.item.itemsId!);
                              } else {
                                cartControllerLocal.removeFromCart(
                                    cartItemModel.item, 1,
                                    cartControllerLocal.cartItems[existingIndex].unit==0?0:1);
                              }
                            },
                            icon: Icon(
                              cartControllerLocal.cartItems[existingIndex]
                                  .quantity <
                                  2
                                  ? Icons.delete
                                  : Icons.remove_circle_outline,
                              color: AppColor.primaryColor,
                            ),
                          ),
                          Text(
                            "${cartControllerLocal.cartItems[existingIndex].quantity}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColor.primaryColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              cartControllerLocal.addToCart(
                                  cartItemModel.item, 1,
                                  cartControllerLocal.cartItems[existingIndex].unit==0?0:1);
                            },
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ],
                      )
                          : TextButton.icon(
                        onPressed: () {
                          cartControllerLocal.addToCart(
                              cartItemModel.item, 1,
                              cartControllerLocal.cartItems[existingIndex].unit==0?0:1);
                        },
                        label: Text(
                          "100".tr,
                          style: TextStyle(
                            color: AppColor.primaryColor,
                            fontSize: 16,
                          ),
                        ),
                        icon: Icon(
                          Icons.shopping_cart,
                          color: AppColor.primaryColor,
                          size: 25,
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}