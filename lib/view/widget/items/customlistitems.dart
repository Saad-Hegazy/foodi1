import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/favorite_controller.dart';
import '../../../controller/items_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imageassets.dart';
import '../../../core/functions/translatefatabase.dart';
import '../../../core/functions/truncatetext.dart';
import '../../../data/model/itemsmodel.dart';
import '../../../linkabi.dart';
class CustomListItems extends GetView<ItemsControllerImp> {
  final ItemsModel itemsModel;
  final void Function()? onAdd;
  const CustomListItems({Key? key,
    required this.itemsModel,
    required this.onAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.goToPageProductDetails(itemsModel);
      },
      child: Card(
        elevation: 5, // Add shadow for depth
        margin: const EdgeInsets.all(8), // Margin around the card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        child: Stack(
          children: [
            SingleChildScrollView ( // Make the content scrollable
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Product image
                    Hero(
                      tag: "${itemsModel.itemsId}",
                      child: CachedNetworkImage(
                        imageUrl: "${AppLink.imagestItems}/${itemsModel.itemsImage!}",
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover, // Ensure image fits within the space
                        placeholder: (context, url) => CircularProgressIndicator(),
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
                        color: AppColor.black,
                        fontSize: 14, // Adjust font size for readability
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis, // Handle long text
                    ),
                    // Price and Favorite Icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Price
                            Text(
                              "${controller.getPrice(itemsModel).toStringAsFixed(2)} SAR",
                              style: TextStyle(
                                color: AppColor.primaryColor,
                                fontSize: 14, // Slightly larger for emphasis
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                       IconButton(
                                  onPressed: onAdd,
                                  icon: Icon(Icons.add_shopping_cart_outlined,
                                    color: AppColor.primaryColor,
                                  )
                              )

                      ],
                    ),
                    controller.hasDiscount(itemsModel) == 1? Text("${controller.getPricewithoutDiscount(itemsModel).toStringAsFixed(2)} SAR",
                      style: const TextStyle(
                        fontSize: 12,
                        height: 0.9,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.lineThrough, // Strikethrough
                      ),
                    ):Text(""),
                  ],
                ),
              ),
            ),
              Positioned(
                top: 5,
                right: 0,
                  // Favorite Icon
                  child: GetBuilder<FavoriteController>(
                  builder: (controller) => IconButton(
                  onPressed: () {
                    if (controller.isFavorite[itemsModel.itemsId] == "1") {
                      controller.setFavorite(itemsModel.itemsId, "0");
                      controller.removeFavorite(itemsModel.itemsId!.toString());
                    } else {
                      controller.setFavorite(itemsModel.itemsId, "1");
                      controller.addFavorite(itemsModel.itemsId!.toString());
                    }
                  },
                  icon: Icon(
                    controller.isFavorite[itemsModel.itemsId] == "1"
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    color: AppColor.primaryColor,
                  ),
                ),
                ),
              ),
            // Sale Badge (only if there's a discount)
            if (controller.hasDiscount(itemsModel) > 0)
              Positioned(
                top: 10,
                left: 10,
                child: Image.asset(
                  AppImageAsset.saleOne,
                  width: 50,
                  height: 50, // Increase size of the sale badge
                ),
              ),
          ],
        ),
      ),
    );
  }
}
