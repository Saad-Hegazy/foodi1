import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/cartlocal_controller.dart';
import '../../../controller/favorite_controller.dart';
import '../../../controller/home_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/functions/translatefatabase.dart';
import '../../../core/functions/truncatetext.dart';
import '../../../data/model/itemsmodel.dart';
import '../../../linkabi.dart';


class BestOffersList extends GetView<HomeControllerImp> {
  const BestOffersList({Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
        ),
        itemCount:controller.offers.length,
        itemBuilder: (context, i) {
          return ItemsHome(
              itemsModel: ItemsModel.fromJson(controller.offers[i]));
        });
  }
}

class ItemsHome extends GetView<HomeControllerImp> {

  final ItemsModel itemsModel;
  const ItemsHome({Key? key, required this.itemsModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartControllerLocal = Get.find<CartControllerLocal>();
    final favoriteController = Get.find<FavoriteController>();
    final existingIndex = cartControllerLocal.cartItems.indexWhere(
            (item) => item.item.itemsId == itemsModel.itemsId);
    return InkWell(
      onTap: () => controller.goToPageProductDetails(itemsModel),
      child: Card(
        // ... existing Card properties ...
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Flexible image section
                  Expanded(
                    child: Hero(
                      tag: "${itemsModel.itemsId}-UniqueKey",
                      child: CachedNetworkImage(
                        imageUrl: "${AppLink.imagestItems}/${itemsModel.itemsImage!}",
                        width: 80,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),
                  // Product name with line limit
                  Text(
                    translateDatabase(
                      truncateProductName(itemsModel.itemsNameAr.toString()),
                      truncateProductName(itemsModel.itemsName.toString()),
                    ),
                    style: TextStyle(
                      color: AppColor.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${itemsModel.itemPrice!.toStringAsFixed(2)} SAR",
                        style: TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5),
                      itemsModel.amountofDiscount >0
                          ? Text(
                        "${itemsModel.pricewithoutDiscount.toStringAsFixed(1)}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough,
                        ),
                      )
                          : Text(""),
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
                          "${cartControllerLocal.cartItems[existingIndex].quantity }",
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
            if (itemsModel.amountofDiscount >0)
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
                    "${itemsModel.amountofDiscount }% OFF",
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