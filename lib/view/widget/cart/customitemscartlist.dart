import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/cart_controller.dart';
import '../../../controller/home_controller.dart';
import '../../../controller/items_controller.dart';
import '../../../controller/myfavoritecontroller.dart';
import '../../../core/constant/color.dart';
import '../../../data/model/cartmodel.dart';
import '../../../data/model/itemsmodel.dart';
import '../../../linkabi.dart';
class CustomItemsCartList extends GetView<CartController> {
  final CartModel cartModel;
  final String name;
  final String totalitemeprice;
  final num price;
  final num count;
  final String imagename;
  final String unit;
  final void Function()? onAdd;
  final void Function()? onRemove;
  final void Function()? onDelet;
  const CustomItemsCartList({Key? key,
    required this.cartModel,
    required this.name,
    required this.totalitemeprice,
    required this.price,
    required this.count,
    required this.imagename,
    required this.unit,
    required this.onAdd,
    required this.onRemove,
    required this.onDelet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(cartModel.itemsId.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: AppColor.primaryColor,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white, size: 30),
      ),
      confirmDismiss: (direction) async {
        // // // Optional: Add confirmation dialog
        CartController cartController = Get.put(CartController());
        return await cartController.delete(
                    cartModel.itemsId!,
                  );
        // return await showDialog(
        //   context: context,
        //   builder: (context) => AlertDialog(
        //     backgroundColor: AppColor.secondColor,
        //     title:  Text("209".tr),
        //     content:  Text("208".tr),
        //     actions: [
        //       TextButton(
        //         onPressed: () => Get.back(),
        //         child:  Text("210".tr),
        //       ),
        //       TextButton(
        //         onPressed: ()async{
        //           CartController cartController = Get.put(CartController());
        //           await cartController.deleteSwap(
        //             cartModel.itemsId!,
        //           );
        //
        //         },
        //         child:  Text("211".tr, style: TextStyle(color: AppColor.primaryColor)),
        //       ),
        //     ],
        //   ),
        // );
      },
      onDismissed: (direction) {
      onDelet; // Call your controller method
      Get.showSnackbar(GetSnackBar(
      message: "Item removed from cart",
      duration: const Duration(seconds: 2),
      backgroundColor: AppColor.primaryColor,
      )
      );},
      child: InkWell(
        onTap: () {
          controller.goToPageProductDetails(cartModel);
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
                // Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(
                    imageUrl: "${AppLink.imagestItems}/$imagename",
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                // Product Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "$price ${"190".tr} $unit",
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),

                // Price & Quantity Control
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Price
                    Text(
                      "$totalitemeprice" + " SAR",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold, color:AppColor.primaryColor),
                    ),
                    const SizedBox(height: 8),
                    // Quantity Picker
                    Row(
                      children: [
                        count<2? IconButton(
                            onPressed: onDelet,
                              icon: const Icon(Icons.delete,  color:AppColor.primaryColor),
                              iconSize: 20,
                            )
                            : IconButton(
                          onPressed: onRemove,
                          icon: const Icon(Icons.remove_circle_outline,  color:AppColor.primaryColor),
                          iconSize: 20,
                        ),
                        Text(
                          count.toStringAsFixed(0),
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: onAdd,
                          icon: const Icon(Icons.add_circle_outline,color:AppColor.primaryColor),
                          iconSize: 20,
                        ),
                      ],
                    ),
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
