import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/home_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imageassets.dart';
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
    return InkWell(
      onTap: () {
        controller.goToPageProductDetailsItemModel(itemsModel);
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
                        fit: BoxFit.cover, // Ensure image fits within the space
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
                        fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis, // Handle long text
                    ),
                    Text(
                      "${controller.getPrice(itemsModel).toStringAsFixed(1)} SAR",
                      style: TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: 14, // Slightly larger for emphasis
                          // fontWeight: FontWeight.bold
                      ),
                    ),
                    // Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Price
                        controller.checkItemInCart(itemsModel)?
                        Flexible(
                          child: Row(
                            mainAxisSize: MainAxisSize.min, // Use minimal space
                            children: [
                              // Decrement button
                              FutureBuilder(
                                future: controller.getCountItems(itemsModel.itemsId!),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return
                                      snapshot.data! < 2
                                          ? IconButton(
                                        onPressed: () async {
                                          await controller.delete(itemsModel.itemsId!);
                                          controller.cartController.refreshPage();

                                          controller.update();
                                        },
                                        icon: const Icon(Icons.delete, color:AppColor.primaryColor,),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                      )
                                          : IconButton(
                                        onPressed: () async {
                                          final currentCount = await controller.getCountItems(itemsModel.itemsId!);
                                          await controller.removeItems(
                                            itemsModel.itemsId!,
                                            "0",
                                            controller.getPrice(itemsModel).toString(),
                                            currentCount - 1,
                                          );
                                          controller.cartController.refreshPage();

                                          controller.update();
                                        },
                                        icon: const Icon(Icons.remove_circle_outline, color:AppColor.primaryColor,),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                      );
                                  } else {
                                    return  SizedBox();
                                  }
                                },
                              ),
                              // Display count
                              FutureBuilder(
                                future: controller.getCountItems(itemsModel.itemsId!),
                                builder: (context, snapshot) {
                                  return Text(snapshot.hasData ? snapshot.data!.toString() : "");
                                },
                              ),
                              // Increment button
                              FutureBuilder(
                                future: controller.getCountItems(itemsModel.itemsId!),
                                builder: (context, snapshot) {
                                  if(snapshot.hasData){
                                    return
                                      IconButton(
                                        onPressed: () async {
                                          final currentCount = await controller.getCountItems(itemsModel.itemsId!);
                                          await controller.addItems(
                                            itemsModel.itemsId!,
                                            "0",
                                            controller.getPrice(itemsModel).toString(),
                                            currentCount + 1,
                                          );
                                          controller.cartController.refreshPage();

                                          controller.update();
                                        },
                                        icon: const Icon(Icons.add_circle_outline, color:AppColor.primaryColor,),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                      );
                                  }else{
                                    return TextButton.icon(
                                      onPressed: (){
                                        controller.addItems(
                                            itemsModel.itemsId!,
                                            "0",
                                            controller.getPrice(itemsModel).toString(),
                                            1
                                        );
                                        controller.cartController.refreshPage();

                                      },
                                      label: Text("100".tr,style:TextStyle(color:AppColor.primaryColor,)),
                                      icon:Icon(Icons.shopping_cart,color: AppColor.primaryColor),

                                    );
                                  }
                                  // return Text(snapshot.hasData ? snapshot.data!.toString() : "0");
                                },
                              ),
                            ],
                          ),
                        )
                            :
                        TextButton.icon(
                          onPressed: (){
                            controller.addItems(
                                itemsModel.itemsId!,
                                "0",
                                controller.getPrice(itemsModel).toString(),
                                1
                            );
                            controller.cartController.refreshPage();

                          },
                          iconAlignment:IconAlignment.start,
                          label: Text("100".tr,style:TextStyle(color:AppColor.primaryColor,fontWeight:FontWeight.w700 ,fontSize: 14)),
                          icon:Icon(Icons.shopping_cart,color: AppColor.primaryColor,size: 24,),
                        )
                      ],
                    ),
                  ],
                ),
           ),
            Positioned(
              top: 10,
              right: 5,
              // Favorite Icon
              child: IconButton(
                onPressed: () {
                  controller.checkItemInFavorite(itemsModel)
                      ? controller.removeFavorite(itemsModel.itemsId!.toString())
                      : controller.addFavorite(itemsModel.itemsId!.toString());
                },
                icon: Icon(
                  controller.checkItemInFavorite(itemsModel)
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                  color: AppColor.primaryColor,
                ),
              ),
            ),
            // Sale Badge (only if there's a discount)
            if (controller.hasDiscount(itemsModel) > 0)
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
                    "${controller.amountofDiscount(itemsModel)}% OFF",
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