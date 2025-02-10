import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/favorite_controller.dart';
import '../../controller/items_controller.dart';
import '../../core/class/handlingdataview.dart';
import '../../core/constant/routes.dart';
import '../../data/model/itemsmodel.dart';
import '../widget/customappbar.dart';
import '../widget/items/customlistitems.dart';
import '../widget/items/listcaregoirseitems.dart';
import 'home.dart';

class Items extends StatelessWidget {
  const Items({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ItemsControllerImp controller = Get.put(ItemsControllerImp());
    FavoriteController controllerFav = Get.put(FavoriteController());
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: ListView(
          controller: controller.scrollController,  // Attach the scroll controller to ListView
          children: [
            CustomAppBar(
              mycontroller: controller.search!,
              titleappbar: "55".tr,
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
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (BuildContext context, index) {
                    if (index == controller.data.length) {
                      // Show loading indicator if we're loading more data
                      return controller.isLoading
                          ? Center(child: CircularProgressIndicator())
                          : SizedBox.shrink();  // Empty widget when no more data to load
                    }
                    // Handling favorite status
                    controllerFav.isFavorite[controller.data[index]['items_id']] =
                    controller.data[index]['favorite'];
                    return CustomListItems(
                      itemsModel: ItemsModel.fromJson(controller.data[index]),
                        onAdd:()async{
                         await controller.addItems(
                           controller.data[index]['items_id'],
                           "0",
                           controller.getPrice(ItemsModel.fromJson(controller.data[index])).toString(),
                           1,
                         );
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
