import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/home_controller.dart';
import '../../../core/functions/translatefatabase.dart';
import '../../../data/model/categoriesmodel.dart';
import '../../../linkabi.dart';

class ListCategories extends GetView<HomeControllerImp> {
  const ListCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.8,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.categories.length,
      itemBuilder: (context, index) => CategoryCard(categoriesModel: CategoriesModel.fromJson(controller.categories[index]), i: index,),
    );
  }
}

class CategoryCard extends GetView<HomeControllerImp> {
  final CategoriesModel categoriesModel;
  final int? i;
  const CategoryCard({Key? key, required this.categoriesModel, required this.i})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.goToItems(controller.categories, i!, categoriesModel.categoriesId!.toString());
      },
      child: Container(
        width: 120, // Set the card width for horizontal scrolling
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: "${AppLink.imagestCategories}/${categoriesModel.categoriesImage}",
                  fit: BoxFit.cover,
                ),
              ),
              // Category Name Overlay
              Positioned(
                top:-5,
                bottom: 70,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "${translateDatabase(categoriesModel.categoriesNameAr, categoriesModel.categoriesName)}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis, // Handle long text
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
