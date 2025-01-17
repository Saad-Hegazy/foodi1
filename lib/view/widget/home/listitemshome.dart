import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/home_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/functions/translatefatabase.dart';
import '../../../core/functions/truncatetext.dart';
import '../../../data/model/itemsmodel.dart';
import '../../../linkabi.dart';

class ListItemsHome extends GetView<HomeControllerImp> {
  const ListItemsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
          itemCount: controller.items.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            return ItemsHome(
                itemsModel: ItemsModel.fromJson(controller.items[i]));
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
      onTap: (){
        controller.goToPageProductDetails(itemsModel);
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal:5, vertical: 0),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: Color(0xfff4f6f7),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: CachedNetworkImage(
              imageUrl:"${AppLink.imagestItems}/${itemsModel.itemsImage}",
              height: 100,
              width: 100,
              fit: BoxFit.fill,
            ),
          ),
          // Container(
          //   decoration: BoxDecoration(
          //       color: AppColor.black.withOpacity(0.2),
          //       borderRadius: BorderRadius.circular(20)),
          //   height: 120,
          //   width: 105,
          // ),
          Positioned(
            top: 100,
            bottom: 0,
            right: 0,
            left: 0,
              child:Text(translateDatabase(
                  itemsModel.itemsNameAr.toString(),truncateProductName(itemsModel.itemsName.toString()) ),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold),textAlign: TextAlign.center,),)
        ],
      ),
    );
  }
}