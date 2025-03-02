import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/home_controller.dart';
import '../../core/class/handlingdataview.dart';
import '../../core/constant/routes.dart';
import '../../data/model/categoriesmodel.dart';
import '../widget/category/customcategorycard.dart';
import '../widget/customappbar.dart';
class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp()); // Replace OffersController with CategoriesController

    return GetBuilder<HomeControllerImp>(builder: (controller) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            CustomAppBar(
              mycontroller: controller.search!,
              titleappbar: "58".tr,
              // onPressedIcon: () {},
              onPressedSearch: () {
                controller.onSearchItems();
              },
              onChanged: (val) {
                controller.checkSearch(val);
              },
              onPressedIconFavorite: () {
                Get.toNamed(AppRoute.myfavroite);
              },
            ),
            const SizedBox(height: 20),
            HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.93,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.categories.length,
                itemBuilder: (context, index) => CategoryCard(categoriesModel: CategoriesModel.fromJson(controller.categories[index]), i: index,),
              ),
            ),
          ],
        ),
      );
    });
  }
}