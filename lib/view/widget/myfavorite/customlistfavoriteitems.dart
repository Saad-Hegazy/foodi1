import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../controller/myfavoritecontroller.dart';
import '../../../core/constant/color.dart';
import '../../../core/functions/translatefatabase.dart';
import '../../../data/model/myfavorite.dart';
import '../../../linkabi.dart';

class CustomListFavoriteItems extends GetView<MyFavoriteController> {
  final  MyFavoriteModel MyFavoriteitemsModel;

  // final bool active;
   const CustomListFavoriteItems({Key? key, required this.MyFavoriteitemsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
         // controller.goToPageProductDetails(MyFavoriteitemsModel);
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: "${MyFavoriteitemsModel.itemsId}",
                    child: CachedNetworkImage(
                      imageUrl:
                      "${AppLink.imagestItems}/${MyFavoriteitemsModel.itemsImage!}",
                      height: 100,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Text(
                        translateDatabase(
                            MyFavoriteitemsModel.itemsNameAr, MyFavoriteitemsModel.itemsName),
                        style: const TextStyle(
                            color: AppColor.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.bottomCenter,
                        height: 22,
                        child: Row(
                          children: [
                            ...List.generate(
                                5,
                                    (index) => const Icon(
                                  Icons.star,
                                  size: 15,
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${controller.getPrice(MyFavoriteitemsModel).toStringAsFixed(2)} SAR",
                          style: const TextStyle(
                              color: AppColor.primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: "sans")),
                      IconButton(
                          onPressed: () {
                            controller.deleteFromFavorite(MyFavoriteitemsModel.favoriteId!) ;
                          },
                          icon: const Icon(
                            Icons.delete_outline_outlined,
                            color: AppColor.primaryColor,
                          ))
                    ],
                  )
                ]),
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