import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/cartlocal_controller.dart';
import '../../controller/favorite_controller.dart';
import '../../controller/home_controller.dart';
import '../../core/constant/routes.dart';
import '../widget/items/customappbaritems.dart';
import '../widget/myfavorite/customlistfavoriteitems.dart';
import 'home.dart';
class MyFavorite extends StatelessWidget {
  const MyFavorite({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cartControllerLocal = Get.find<CartControllerLocal>();
    final favoriteController = Get.find<FavoriteController>();
    final homeController = Get.find<HomeControllerImp>();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GetBuilder<HomeControllerImp>(
            builder: ((controller) => ListView(children: [
              Obx((){
                return CustomAppBarItems(
                  mycontroller: homeController.search!,
                  titleappbar: "58".tr,
                  onPressedSearch: () {
                    homeController.onSearchItems();
                  },
                  onChanged: (val) {
                    homeController.checkSearch(val);
                  },
                  onPressedIconCart: () => Get.toNamed(AppRoute.cart),
                  itemCount:cartControllerLocal.cartItems.length,
                );
              }
              ),
              const SizedBox(height: 20),
              !controller.isSearch?
              Obx((){
                return  GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: favoriteController.favorites.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.9),
                  itemBuilder: (context, index) {
                    return  CustomListFavoriteItems(
                      itemsModel: favoriteController.favorites[index],
                    );},
                );
              })
                  : ListItemsSearch(listdatamodel: controller.listdata)

            ]))
        ),
      ),
    );
  }
}