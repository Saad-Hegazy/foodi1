import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/home_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/functions/translatefatabase.dart';
import '../../../core/functions/truncatetext.dart';
import '../../../data/model/itemsmodel.dart';
import '../../../linkabi.dart';


  class BestOffersListHome extends GetView<HomeControllerImp> {
    const BestOffersListHome({Key? key,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return SizedBox(
        height: 216,
        child: ListView.builder(
            itemCount: controller.offers.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              return ItemsHome(
                  itemsModel: ItemsModel.fromJson(controller.offers[i]));
            }),
      );
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
                      fontSize: 12, // Adjust font size for readability
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis, // Handle long text
                  ),
                  // Price and Favorite Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price
                      Text(
                        "${controller.getPrice(itemsModel).toStringAsFixed(1)} SAR",
                        style: TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: 12, // Slightly larger for emphasis
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5,),
                      controller.hasDiscount(itemsModel) == 1? Text("${controller.getPricewithoutDiscount(itemsModel).toStringAsFixed(1)}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough, // Strikethrough
                        ),
                      ):Text(""),
                    ],
                  ),
                  controller.checkItemInCart(itemsModel)?
                  Row(
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
                              icon: const Icon(Icons.delete, color:AppColor.primaryColor),
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
                              icon: const Icon(Icons.remove_circle_outline, color:AppColor.primaryColor),
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
                              icon: const Icon(Icons.add_circle_outline, color:AppColor.primaryColor),
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
                            label: Text("100".tr,style:TextStyle(color:AppColor.primaryColor,fontSize: 16)),
                            icon:Icon(Icons.shopping_cart,color: AppColor.primaryColor,size: 25,),
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
                                  itemsModel.itemsId!,
                                  "0",
                                  controller.getPrice(itemsModel).toString(),
                                  1
                              );
                              controller.cartController.refreshPage();

                          },
                          label: Text("100".tr,style:TextStyle(color:AppColor.primaryColor,fontSize: 16)),
                          icon:Icon(Icons.shopping_cart,color: AppColor.primaryColor,size: 25,),
                      )
                ],
              ),
            ),
            Positioned(
              top: 10,
              right: 0,
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
            if (controller.hasDiscount(itemsModel) > 0)
              Positioned(
                top: 8,
                left: 5,
                child:Container(
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
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