import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../controller/myfavoritecontroller.dart';
import '../../../controller/productDetailsItemModel_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imageassets.dart';
import '../../../core/functions/translatefatabase.dart';
import '../../../core/functions/truncatetext.dart';
import '../../../data/model/myfavorite.dart';
import '../../../linkabi.dart';
import '../../screen/productdetailsitemmodel.dart';

class CustomListFavoriteItems extends GetView<MyFavoriteController> {
  final  MyFavoriteModel myFavoriteitemsModel;

  const CustomListFavoriteItems({Key? key,
    required this.myFavoriteitemsModel})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
         controller.goToPageProductDetailsItemModel(myFavoriteitemsModel);
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
                      Hero(
                        tag: "${myFavoriteitemsModel.itemsId}",
                        child: CachedNetworkImage(
                          imageUrl: "${AppLink.imagestItems}/${myFavoriteitemsModel.itemsImage!}",
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
                          truncateProductName(myFavoriteitemsModel.itemsNameAr.toString()),
                          truncateProductName(myFavoriteitemsModel.itemsName.toString()),
                        ),
                        style: TextStyle(
                          color: AppColor.black,
                          fontSize: 14, // Adjust font size for readability
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis, // Handle long text
                      ),
                      // Price
                      Text(
                        "${controller.getPrice(myFavoriteitemsModel).toStringAsFixed(1)} SAR",
                        style: TextStyle(
                            color: AppColor.primaryColor,
                            height: 0.8,
                            fontSize: 14, // Slightly larger for emphasis
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      // Price and Favorite Icon
                      controller.hasDiscount(myFavoriteitemsModel) == 1? Text("${controller.getPricewithoutDiscount(myFavoriteitemsModel).toStringAsFixed(2)} SAR",
                        style: const TextStyle(
                          fontSize: 14, // Slightly larger for emphasis
                          fontWeight: FontWeight.bold,
                          height: 0.8,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough, // Strikethrough
                        ),
                      ):SizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Price
                          controller.checkItemInCart(myFavoriteitemsModel)?
                          Row(
                            children: [
                              // Decrement button
                              FutureBuilder(
                                future: controller.getCountItems(myFavoriteitemsModel.itemsId!),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return
                                      snapshot.data! < 2
                                          ? IconButton(
                                        onPressed: () async {
                                          await controller.delete(myFavoriteitemsModel.itemsId!);
                                          controller.update();
                                          controller.cartController.refreshPage();
                                          controller.homeController.refreshPage();
                                          controller.homeController.getfavoriteData();
                                        },
                                        icon: const Icon(Icons.delete, color:AppColor.primaryColor,),
                                      )
                                          : IconButton(
                                        onPressed: () async {
                                          final currentCount = await controller.getCountItems(myFavoriteitemsModel.itemsId!);
                                          await controller.addItems(
                                            myFavoriteitemsModel.itemsId!,
                                            "0",
                                            controller.getPrice(myFavoriteitemsModel).toString(),
                                            currentCount - 1,
                                          );
                                          controller.cartController.refreshPage();
                                          controller.homeController.refreshPage();
                                          controller.update();
                                        },
                                        icon: const Icon(Icons.remove_circle_outline, color:AppColor.primaryColor,),
                                      );
                                  } else {
                                    return  SizedBox();
                                  }
                                },
                              ),
                              // Display count
                              FutureBuilder<int>(
                                future: controller.getCountItems(myFavoriteitemsModel.itemsId!),
                                builder: (context, snapshot) {
                                  return Text(snapshot.hasData ? snapshot.data!.toString() : "");
                                },
                              ),
                              // Increment button
                              FutureBuilder<int>(
                                future: controller.getCountItems(myFavoriteitemsModel.itemsId!),
                                builder: (context, snapshot) {
                                  if(snapshot.hasData){
                                    return
                                      IconButton(
                                        onPressed: () async {
                                          final currentCount = await controller.getCountItems(myFavoriteitemsModel.itemsId!);
                                          await controller.addItems(
                                            myFavoriteitemsModel.itemsId!,
                                            "0",
                                            controller.getPrice(myFavoriteitemsModel).toString(),
                                            currentCount + 1,
                                          );
                                          controller.cartController.refreshPage();
                                          controller.homeController.refreshPage();

                                          controller.update();
                                        },
                                        icon: const Icon(Icons.add_circle_outline, color:AppColor.primaryColor,),
                                      );
                                  }else{
                                    return TextButton.icon(
                                      onPressed: (){
                                        controller.addItems(
                                            myFavoriteitemsModel.itemsId!,
                                            "0",
                                            controller.getPrice(myFavoriteitemsModel).toString(),
                                            1
                                        );
                                        controller.cartController.refreshPage();
                                        controller.homeController.refreshPage();
                                        controller.update();

                                      },
                                      label: Text("100".tr,style:TextStyle(color:AppColor.primaryColor,)),
                                      icon:Icon(Icons.shopping_cart,color: AppColor.primaryColor),
                                    );
                                  }
                                  // return Text(snapshot.hasData ? snapshot.data!.toString() : "0");
                                },
                              ),
                            ],
                          )
                              :
                          TextButton.icon(
                            onPressed: (){
                              controller.addItems(
                                  myFavoriteitemsModel.itemsId!,
                                  "0",
                                  controller.getPrice(myFavoriteitemsModel).toString(),
                                  1
                              );
                              controller.cartController.refreshPage();
                              controller.homeController.refreshPage();
                              },
                            label: Text("100".tr,style:TextStyle(color:AppColor.primaryColor,height: 0.8),),
                            icon:Icon(Icons.shopping_cart,color: AppColor.primaryColor,),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
              Positioned(
                top: 5,
                right: 0,
                child:
                IconButton(
                          onPressed: () {
                            controller.deleteFromFavorite(myFavoriteitemsModel.favoriteId!) ;
                          },
                          icon: const Icon(
                            Icons.delete_outline_outlined,
                            color: AppColor.primaryColor,
                          )
                )
                ),
              // Sale Badge (only if there's a discount)
              if (controller.hasDiscount(myFavoriteitemsModel) > 0)
                Positioned(
                  top: 15,
                  left: 8,
                  child:Container(
                    padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColor.secondaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "${controller.amountofDiscount(myFavoriteitemsModel)}% OFF",
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