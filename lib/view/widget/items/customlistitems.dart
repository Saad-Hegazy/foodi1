import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/cartlocal_controller.dart';
import '../../../controller/favorite_controller.dart';
import '../../../controller/items_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/functions/translatefatabase.dart';
import '../../../core/functions/truncatetext.dart';
import '../../../data/model/itemsmodel.dart';
import '../../../linkabi.dart';

class CustomListItems extends GetView<ItemsControllerImp> {
  final ItemsModel itemsModel;
  const CustomListItems({Key? key, required this.itemsModel}) : super(key: key);
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 10, 0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Product image
                    Hero(
                      tag: "${itemsModel.itemsId}",
                      child: CachedNetworkImage(
                        imageUrl: "${AppLink.imagestItems}/${itemsModel.itemsImage!}",
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,// Ensure image fits within the space
                        alignment : Alignment. center,
                        placeholder: (context, url) => CircularProgressIndicator(
                          color: AppColor.primaryColor,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                    // Product name
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Price
                        Text(
                          "${itemsModel.itemPrice!.toStringAsFixed(2)} SAR",
                          style: TextStyle(
                            color: AppColor.primaryColor,
                            fontSize: 12, // Slightly larger for emphasis
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        itemsModel.amountofDiscount >0 ? Text("${itemsModel.pricewithoutDiscount.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            // fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough, // Strikethrough
                          ),
                        ):SizedBox(),
                      ],
                    ),
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
              // Favorite Icon
              child: IconButton(
                icon: Obx(() => Icon(
                  favoriteController.isFavorite(itemsModel)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: AppColor.primaryColor,
                )),
                onPressed: () => favoriteController.toggleFavorite(itemsModel),
              ),
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
              ),
          ],
        ),
      ),
    );

  }
}