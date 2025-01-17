import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/imageslider_controller.dart';
import '../../../linkabi.dart';
import 'package:flutter/material.dart' hide CarouselController;
class ImageSlider extends StatelessWidget {
  const ImageSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ImagesliderController controller = Get.put(ImagesliderController());
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: CarouselSlider.builder(
              itemCount:controller.data.length,
              itemBuilder: (context, index, realIdx) {
            return controller.data.isEmpty?const CircularProgressIndicator():
              CachedNetworkImage (
                imageUrl:  "${AppLink.imageSliderUpload}/" +  controller.data[index]["ImageSlider_name"],
                height: 100,
                fit: BoxFit.fill,
                placeholder: (context, url) => CircularProgressIndicator(),
              );
              },
              options: CarouselOptions(
                scrollPhysics: const BouncingScrollPhysics(),
                autoPlay: true,
                aspectRatio: 2,
                viewportFraction: 1,
              ),
      ),
    );
  }
}
