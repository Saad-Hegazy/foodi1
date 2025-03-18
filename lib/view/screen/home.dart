import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/cartlocal_controller.dart';
import '../../controller/home_controller.dart';
import '../../core/constant/routes.dart';
import '../../data/model/itemsmodel.dart';
import '../../linkabi.dart';
import '../widget/home/ImageSliderScreen.dart';
import '../widget/home/bestofferslisthome.dart';
import '../widget/home/customtitlehome.dart';
import '../widget/home/listcategorieshome.dart';
import '../widget/home/listitemshome.dart';
import '../widget/items/customappbaritems.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cartControllerLocal = Get.find<CartControllerLocal>();
    Get.put(HomeControllerImp());
    return GetBuilder<HomeControllerImp>(
        builder: (controller) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              children: [
                 Obx((){
                   return CustomAppBarItems(
                     mycontroller: controller.search!,
                     titleappbar: "58".tr,
                     onPressedSearch: () {
                       controller.onSearchItems();
                     },
                     onChanged: (val) {
                       controller.checkSearch(val);
                     },
                     onPressedIconCart: () => Get.toNamed(AppRoute.cart),
                     itemCount:cartControllerLocal.cartItems.length,
                   );
                    }
                 ),
                !controller.isSearch
                        ?  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageSlider(),
                        CustomTitleHome(title: "59".tr),
                        ListCategories(),
                        CustomTitleHome(title: "200".tr),
                        BestOffersListHome(),
                        CustomTitleHome(title: "60".tr),
                        BestSillingItemsList(),
                      ],
                    )
                        : ListItemsSearch(listdatamodel: controller.listdata)
              ],
            )
        )
    );
  }
}

class ListItemsSearch extends GetView<HomeControllerImp> {
  final List<ItemsModel> listdatamodel;
  const ListItemsSearch({Key? key, required this.listdatamodel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listdatamodel.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              controller.goToPageProductDetails(listdatamodel[index]);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Card(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                            child: CachedNetworkImage(
                                imageUrl:
                                "${AppLink.imagestItems}/${listdatamodel[index].itemsImage}")),
                        Expanded(
                            flex: 2,
                            child: ListTile(
                              title: Text(listdatamodel[index].itemsName!),
                              subtitle: Text(listdatamodel[index].categoriesName!),
                            )),
                      ],
                    ),
                  )),
            ),
          );
        });
  }
}