import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/favorite_controller.dart';
import '../../../controller/home_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imageassets.dart';
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
          childAspectRatio: 0.735,
        ),
        itemCount:controller.items.length,
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
    return InkWell(
      onTap: () {
        controller.goToPageProductDetailsItemModel(itemsModel);
      },
      child: Card(
        color: AppColor.backgroundcolor2,
        elevation: 3, // Add shadow for depth
        margin: const EdgeInsets.all(8), // Margin around the card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
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
                          height: 0.8,
                          fontSize: 14, // Slightly larger for emphasis
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: (){
                          controller.addItems(
                              itemsModel.itemsId!,
                              "0",
                              controller.getPrice(itemsModel).toString(),
                              1
                          );
                          // Get.snackbar("155".tr, "154".tr,);
                        },
                        icon:  Icon(Icons.shopping_cart),
                        color: AppColor.primaryColor,
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
            Positioned(
              top: 10,
              right: 0,
              // Favorite Icon
              child: IconButton(
                onPressed: () {
                  if (controller.favoriteController.isFavorite[itemsModel.itemsId] == "1") {
                    controller.favoriteController.setFavorite(itemsModel.itemsId, "0");
                    controller.favoriteController.removeFavorite(itemsModel.itemsId!.toString());
                  } else {
                    controller.favoriteController.setFavorite(itemsModel.itemsId, "1");
                    controller.favoriteController.addFavorite(itemsModel.itemsId!.toString());
                  }
                  controller.refreshPage();
                },
                icon: Icon(
                  controller.favoriteController.isFavorite[itemsModel.itemsId] == "1"
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                  color: AppColor.primaryColor,
                ),
              ),
            ),
            if (controller.hasDiscount(itemsModel) > 0)
              Positioned(
                top: 10,
                left: 5,
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