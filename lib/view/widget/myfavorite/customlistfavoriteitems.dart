import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/cartlocal_controller.dart';
import '../../../controller/favorite_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/functions/translatefatabase.dart';
import '../../../core/functions/truncatetext.dart';
import '../../../data/model/itemsmodel.dart';
import '../../../linkabi.dart';

class CustomListFavoriteItems extends GetView<FavoriteController> {
  final ItemsModel itemsModel;
  const CustomListFavoriteItems({Key? key,
    required this.itemsModel})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cartControllerLocal = Get.find<CartControllerLocal>();
    final favoriteController = Get.find<FavoriteController>();
    return InkWell(
        onTap: () {
         controller.goToPageProductDetails(itemsModel);
        },
        child: Card(
          color: AppColor.backgroundcolor2,
          elevation: 3, // Add shadow for depth
          // margin: const EdgeInsets.all(8), // Margin around the card
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners
          ),
          child: Stack(
            children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 5, 12, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Hero(
                        tag: "${itemsModel.itemsId}",
                        child: CachedNetworkImage(
                          imageUrl: "${AppLink.imagestItems}/${itemsModel.itemsImage!}",
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover, // Ensure image fits within the space
                          placeholder: (context, url) => CircularProgressIndicator(
                            color: AppColor.primaryColor,
                          ),
                          errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red),
                        ),
                      ),
                      Text(
                        translateDatabase(
                          truncateProductName(itemsModel.itemsNameAr.toString()),
                          truncateProductName(itemsModel.itemsName.toString()),
                        ),
                        style: TextStyle(
                          height: 0.7,
                          color: AppColor.black,
                          fontSize: 12, // Adjust font size for readability
                          // fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis, // Handle long text
                      ),
                      // Price
                       Text( "${itemsModel.itemPrice!.toStringAsFixed(1)} SAR",
                        style: TextStyle(
                            color: AppColor.primaryColor,
                            height: 2,
                            fontSize: 14, // Slightly larger for emphasis
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      // Price and Favorite Icon
                      itemsModel.amountofDiscount > 0? Text("${itemsModel.pricewithoutDiscount.toStringAsFixed(1)} SAR",
                        style: const TextStyle(
                          fontSize: 14, // Slightly larger for emphasis
                          fontWeight: FontWeight.bold,
                          height: 0.8,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough, // Strikethrough
                        ),
                      ):SizedBox(),
                  // Reactive cart controls
                  Obx(() {
                    final existingIndex = cartControllerLocal.cartItems.indexWhere(
                            (item) => item.item.itemsId == itemsModel.itemsId
                    );
                    final isInCart = existingIndex != -1;
                    return isInCart ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Delete/Decrement button
                        IconButton(
                          onPressed: () {
                            if (cartControllerLocal.cartItems[existingIndex].quantity < 2) {
                              cartControllerLocal.deleteFromCart(itemsModel.itemsId!);
                            } else {
                              cartControllerLocal.removeFromCart(itemsModel, 1, 0);
                            }
                          },
                          icon: Icon(
                            cartControllerLocal.cartItems[existingIndex].quantity < 2
                                ? Icons.delete
                                : Icons.remove_circle_outline,
                            color: AppColor.primaryColor,
                          ),
                        ),
                        // Quantity display
                        Text(
                          "${cartControllerLocal.cartItems[existingIndex].quantity}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColor,
                          ),
                        ),
                        // Increment button
                        IconButton(
                          onPressed: () {
                            cartControllerLocal.addToCart(itemsModel, 1, 0);
                          },
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ],
                    ) : TextButton.icon(
                      onPressed: () {
                        cartControllerLocal.addToCart(itemsModel, 1, 0);
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
                  }
                  ),

                    ],
                  ),
                ),
              Positioned(
                  top: 10,
                  right: 5,
                child:
                IconButton(
                  icon: Obx(() => Icon(
                    favoriteController.isFavorite(itemsModel)
                        ? Icons.delete_outline_outlined
                        : Icons.delete_outline_outlined,
                    color: AppColor.primaryColor,
                  )
                    ),
                  onPressed: () => favoriteController.toggleFavorite(itemsModel),
                )
              ),
              if (itemsModel.amountofDiscount > 0)
                Positioned(
                  top:22,
                  left: 13,
                  child:Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColor.secondaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "${itemsModel.amountofDiscount}% OFF",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 9,
                      ),
                    ),
                  ),
                ),],
          ),
        ),
    );
  }
}






























// logical thinking

// GetBuilder<FavoriteController>(
//                         builder: (controller) => IconButton(
//                             onPressed: () {
//                                 if (controller.isFavorite[itemsModel.itemsId] == "1" ) {
//                                   controller.setFavorite(
//                                       itemsModel.itemsId, "0");
//                                 } else {
//                                   controller.setFavorite(
//                                       itemsModel.itemsId, "1");
//                                 }
//                             },
//                             icon: Icon(
//                               controller.isFavorite[itemsModel.itemsId] == "1"
//                                   ? Icons.favorite
//                                   : Icons.favorite_border_outlined,
//                               color: AppColor.primaryColor,
//                             )))