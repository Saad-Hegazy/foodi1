import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/favorite_controller.dart';
import '../../../controller/offers_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imageassets.dart';
import '../../../core/functions/translatefatabase.dart';
import '../../../data/model/itemsmodel.dart';
import '../../../linkabi.dart';
class CustomListItemsOffer extends GetView<OffersController> {
  final ItemsModel itemsModel;
  // final bool active;
  const CustomListItemsOffer({Key? key, required this.itemsModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          controller.goToPageProductDetails(itemsModel);
        },
        child: Card(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Hero(
                        tag: "${itemsModel.itemsId}",
                        child: CachedNetworkImage(
                          imageUrl:
                          "${AppLink.imagestItems}/${itemsModel.itemsImage!}",
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                          translateDatabase(
                              itemsModel.itemsNameAr, itemsModel.itemsName),
                          style: const TextStyle(
                              color: AppColor.black,
                              fontSize: 13,
                              fontWeight: FontWeight.bold)),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text("${controller.getPrice(itemsModel).toStringAsFixed(2)} SAR",
                                  style: const TextStyle(
                                      color: AppColor.primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "sans")),
                              controller.hasDiscount(itemsModel) == 1? Text("${controller.getPricewithoutDiscount(itemsModel).toStringAsFixed(2)} SAR",
                                style: const TextStyle(
                                  fontSize: 13,
                                  height: 0.9,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.lineThrough, // Strikethrough
                                ),
                              ):Text(""),
                            ],
                          ),
                          GetBuilder<FavoriteController>(
                              builder: (controller) => IconButton(
                                  onPressed: () {
                                    if (controller.isFavorite[itemsModel.itemsId] ==
                                        "1") {
                                      controller.setFavorite(
                                          itemsModel.itemsId, "0");
                                      controller
                                          .removeFavorite(itemsModel.itemsId!.toString());
                                    } else {
                                      controller.setFavorite(
                                          itemsModel.itemsId, "1");
                                      controller.addFavorite(itemsModel.itemsId!.toString());
                                    }
                                  },
                                  icon: Icon(
                                    controller.isFavorite[itemsModel.itemsId] == "1"
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined,
                                    color: AppColor.primaryColor,
                                  )))
                        ],
                      )
                    ]),
              ),
              if (controller.hasDiscount(itemsModel) > 0)   Positioned(
                  top: 10,
                  left: 15,
                  child: Image.asset(AppImageAsset.saleOne , width: 60,))
            ],
          ),
        ));
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