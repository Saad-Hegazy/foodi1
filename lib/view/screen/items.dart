import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/cartlocal_controller.dart';
import '../../controller/items_controller.dart';
import '../../core/class/handlingdataview.dart';
import '../../core/constant/color.dart';
import '../../core/constant/routes.dart';
import '../../data/model/itemsmodel.dart';
import '../widget/items/customappbaritems.dart';
import '../widget/items/customlistitems.dart';
import '../widget/items/listcaregoirseitems.dart';
import 'home.dart';

class Items extends StatelessWidget {
  const Items({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cartControllerLocal = Get.find<CartControllerLocal>();
    ItemsControllerImp controllerItems = Get.put(ItemsControllerImp());
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: ListView(
          controller: controllerItems.scrollController,
          children: [
            Obx((){
              return CustomAppBarItems(
                mycontroller: controllerItems.search!,
                titleappbar: "58".tr,
                onPressedSearch: () => controllerItems.onSearchItems(),
                onChanged: (val) => controllerItems.checkSearch(val),
                onPressedIconCart: () => Get.toNamed(AppRoute.cart),
                itemCount:cartControllerLocal.cartItems.length,
              );
            }
            ),
            const SizedBox(height: 20),
            const ListCategoriesItems(),
            GetBuilder<ItemsControllerImp>(
              builder: (controller) => !controller.isSearch
                    ? HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: GridView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: controller.data.length + 1,  // Add one for the loading indicator
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.9,
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
                      return CustomListItems(
                        itemsModel: ItemsModel.fromJson(controller.data[index]),
                      );
                                        },
                                      ),
                    )
                    : ListItemsSearch(listdatamodel: controller.listdata),
            ),
          ],
        ),
      ),
    );
  }
}
