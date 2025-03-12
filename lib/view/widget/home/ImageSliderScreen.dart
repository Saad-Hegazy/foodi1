import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/home_controller.dart';
import '../../../core/constant/color.dart';
import '../../../linkabi.dart';
import 'package:flutter/material.dart' hide CarouselController;
class ImageSlider extends StatelessWidget {
  const ImageSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeControllerImp controller = Get.put(HomeControllerImp());
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.0),
        child: CarouselSlider.builder(
                itemCount:controller.imageSlider.length,
                itemBuilder: (context, index, realIdx) {
              return controller.imageSlider.isEmpty?const CircularProgressIndicator(
                color: AppColor.primaryColor,
              ):
                CachedNetworkImage (
                  imageUrl:  "${AppLink.imageSliderUpload}/" +  controller.imageSlider[index]["ImageSlider_name"],
                  height: 100,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => CircularProgressIndicator(
                    color: AppColor.primaryColor,
                  ),
                );
                },
                options: CarouselOptions(
                  scrollPhysics: const BouncingScrollPhysics(),
                  autoPlay: true,
                  aspectRatio: 2,
                  viewportFraction: 1,
                ),
        ),
      ),
    );
  }
}
