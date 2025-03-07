import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/cart_controller.dart';
import '../../controller/favorite_controller.dart';
import '../../controller/home_controller.dart';
import '../../controller/items_controller.dart';
import '../../core/class/handlingdataview.dart';
import '../../core/constant/color.dart';
import '../../core/constant/routes.dart';
import '../../data/model/itemsmodel.dart';
import '../widget/customappbar.dart';
import '../widget/home/custombottomappbarhome.dart';
import '../widget/items/customappbaritems.dart';
import '../widget/items/customlistitems.dart';
import '../widget/items/listcaregoirseitems.dart';
import 'home.dart';

class Items extends StatelessWidget {
  const Items({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ItemsControllerImp controllerItems = Get.put(ItemsControllerImp());
    FavoriteController controllerFav = Get.put(FavoriteController());
    CartController controllerCart = Get.put(CartController());
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: ListView(
          controller: controllerItems.scrollController,
          children: [
            GetBuilder<CartController>(
              builder: (cartController) => CustomAppBarItems(
                mycontroller: controllerItems.search!,
                titleappbar: "55".tr,
                onPressedSearch: () => controllerItems.onSearchItems(),
                onChanged: (val) => controllerItems.checkSearch(val),
                onPressedIconCart: () => Get.toNamed(AppRoute.cart),
                itemCount: cartController.totalcountitems.toInt(),
              ),
            ),
            const SizedBox(height: 20),
            const ListCategoriesItems(),
            GetBuilder<ItemsControllerImp>(
              builder: (controller) => HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: !controller.isSearch
                    ? GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.data.length + 1,  // Add one for the loading indicator
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (BuildContext context, index) {
                    if (index == controller.data.length) {
                        // Show loading indicator if we're loading more data
                      return controller.isLoading
                          ? Center(child: CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      ))
                          : SizedBox.shrink();  // Empty widget when no more data to load
                    }
                    // Handling favorite status
                    controllerFav.isFavorite[controller.data[index]['items_id']] =
                    controller.data[index]['favorite'];
                    return CustomListItems(
                      itemsModel: ItemsModel.fromJson(controller.data[index]),
                      onAdd:()async{
                        if (controller.itemisadd[controller.data[index]['items_id']] == 1) {
                          Get.snackbar("135".tr, "206".tr);
                        } else {
                          await controller.addItems(
                            controller.data[index]['items_id'],
                            "0",
                            controller.getPrice(ItemsModel.fromJson(controller.data[index])).toString(),
                            1,
                          );
                          controllerCart.view();
                          HomeControllerImp Controller =     Get.put(HomeControllerImp());
                          Controller.refreshPage();
                          // Get.snackbar("155".tr, "154".tr,);
                        }
                      },
                    );
                  },
                )
                    : ListItemsSearch(listdatamodel: controller.listdata),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
