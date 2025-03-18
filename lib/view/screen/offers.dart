import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/cartlocal_controller.dart';
import '../../controller/home_controller.dart';
import '../../core/constant/routes.dart';
import '../widget/offers/offers.dart';
import '../widget/items/customappbaritems.dart';
import 'home.dart';
class OffersView extends StatelessWidget {
  const OffersView({super.key});
  @override
  Widget build(BuildContext context) {
    final cartControllerLocal = Get.find<CartControllerLocal>();
    return GetBuilder<HomeControllerImp>(builder: (controller) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
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
            const SizedBox(height: 20),
            !controller.isSearch?
            BestOffersList()
                : ListItemsSearch(listdatamodel: controller.listdata)

          ],
        ),
      );
    }
    );
  }
}