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

class BestSillingItemsList extends GetView<HomeControllerImp> {
  const BestSillingItemsList({Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Featured Products Grid
    return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
        ),
        itemCount:controller.items.length,
        itemBuilder: (context, i) {
          return ItemsHome(
              itemsModel: ItemsModel.fromJson(controller.items[i]));
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
    return InkWell(
      onTap: () {
        controller.goToPageProductDetails(itemsModel,);
      },
      child: Card(
        color: AppColor.backgroundcolor2,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ConstrainedBox( // Add constrained box to limit height
          constraints: BoxConstraints(
            minHeight: 180, // Set minimum height
            maxHeight: 220, // Set maximum height based on your design
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min, // Prevent column from expanding
                  children: [
                    Expanded( // Use Expanded for the image section
                      flex: 3, // Adjust flex values as needed
                      child: Hero(
                        tag: "${itemsModel.itemsId}",
                        child: CachedNetworkImage(
                          imageUrl: "${AppLink.imagestItems}/${itemsModel.itemsImage!}",
                          height: 80,
                          width: 80,
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                          placeholder: (context, url) => CircularProgressIndicator(
                            color: AppColor.primaryColor,
                          ),
                          errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4), // Add spacing
                    Expanded( // Use Expanded for text sections
                      flex: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            translateDatabase(
                              truncateProductName(itemsModel.itemsNameAr.toString()),
                              truncateProductName(itemsModel.itemsName.toString()),
                            ),
                            style: TextStyle(
                                height: 0.7,
                                color: AppColor.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                            ),
                            maxLines: 1, // Ensure single line
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "${itemsModel.itemPrice!.toStringAsFixed(2)} SAR",
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    Expanded( // Use Expanded for cart controls
                      flex: 2,
                      child:                    // Reactive cart controls
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
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 10,
                right: 0,
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
            ],
          ),
        ),
      ),
    );
  }
}
