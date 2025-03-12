import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/myfavoritecontroller.dart';
import '../../core/constant/routes.dart';
import '../widget/items/customappbaritems.dart';
import '../widget/myfavorite/customlistfavoriteitems.dart';
class MyFavorite extends StatelessWidget {

  const MyFavorite({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(MyFavoriteController());
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GetBuilder<MyFavoriteController>(
            builder: ((controller) => ListView(children: [
              CustomAppBarItems(
                mycontroller: controller.homeController.search!,
                titleappbar: "58".tr,
                onPressedSearch: () {
                  controller.homeController.onSearchItems();
                },
                onChanged: (val) {
                  controller.homeController.checkSearch(val);
                },
                onPressedIconCart: () => Get.toNamed(AppRoute.cart),
                itemCount:controller.totalcountitems.toInt(),
              ),
              const SizedBox(height: 20),
            GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.data.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 0.9),
                    itemBuilder: (context, index) {
                      return  CustomListFavoriteItems(
                        myFavoriteitemsModel: controller.data[index],
                      );
                    },
                  )
            ]))),
      ),
    );
  }
}