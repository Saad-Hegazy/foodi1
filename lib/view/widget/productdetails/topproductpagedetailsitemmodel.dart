import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/productdetails_controller.dart';
import '../../../core/constant/color.dart';
import '../../../linkabi.dart';


class TopProductPageDetailsItemModel extends GetView<ProductDetailsControllerImp> {
  const TopProductPageDetailsItemModel({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColor.secondColor.withOpacity(0.2),
                  AppColor.secondColor.withOpacity(0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned.fill(
            child: Center(
              child: Hero(
                tag: "${controller.itemsModel!.itemsId}",
                child: Material(
                  type: MaterialType.transparency,
                  child: GestureDetector(
                    onTap: () => controller.showFullScreenImage(context),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                        "${AppLink.imagestItems}/${controller.itemsModel!.itemsImage!}",
                        fit: BoxFit.contain,
                        height: 280,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            color: AppColor.primaryColor,
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.image_not_supported_outlined,
                          color: AppColor.grey,
                          size: 60,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.9),
              child: IconButton(
                  icon: Icon(Icons.arrow_back, color: AppColor.primaryColor),
                  onPressed: () {
                    Get.back();
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
