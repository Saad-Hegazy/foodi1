import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/cart_controller.dart';
import '../../controller/home_controller.dart';
import '../../controller/productdetails_controller.dart';
import '../../core/class/handlingdataview.dart';
import '../../core/constant/color.dart';
import '../../core/functions/translatefatabase.dart';
import '../widget/productdetails/priceandcount.dart';
import '../widget/productdetails/toppageproductdetails.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(ProductDetailsControllerImp());
    return Scaffold(
      body: GetBuilder<ProductDetailsControllerImp>(
        builder: (controller) => HandlingDataView(
          statusRequest: controller.statusRequest,
          widget: Column(
            children: [
              const TopProductPageDetails(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Header Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              translateDatabase(
                                controller.itemsModel!.itemsNameAr,
                                controller.itemsModel!.itemsName,
                              ),
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: AppColor.darkGrey,
                                height: 1.3,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (controller.hasDiscount(controller.itemsModel) > 0)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColor.secondaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "${controller.amountofDiscount(controller.itemsModel)}% OFF",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Price and Quantity Section
                      PriceAndCountItems(
                        onCountChanged: (selectedCount) {
                            controller.selectedCount = selectedCount;
                        },
                        count:controller.countitems.toString(),
                        price: "${controller.getPrice(controller.itemsModel).toStringAsFixed(2)}",
                        oldprice: "${controller.getPricewithoutDiscount(controller.itemsModel).toStringAsFixed(2)}",
                        hasDiscount: controller.hasDiscount(controller.itemsModel),
                      ),
                      const SizedBox(height: 25),
                      // Package Selector
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildPackageOption(
                                context: context,
                                title: "183".tr,
                                selected: controller.isbox!,
                                onTap: () {
                                  controller.isBox(true);
                                },
                                icon: Icons.inventory_2_outlined,
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 40,
                              color: Colors.grey[200],
                            ),
                            Expanded(
                              child: _buildPackageOption(
                                context: context,
                                title: "184".tr,
                                selected: controller.isunit!,
                                onTap: () {
                                  controller.isBox(false);
                                },
                                icon: Icons.style_outlined,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Description Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "193".tr,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColor.darkGrey,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            translateDatabase(
                              controller.itemsModel!.itemsDescAr,
                              controller.itemsModel!.itemsDesc,
                            ),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColor.grey,
                              height: 1.6,
                              letterSpacing: 0.1,
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Add to Cart Button
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SizedBox(
            height: 55,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.shopping_cart, size: 22,
                color:Colors.white,
              ),
              label: Text(
                "194".tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                shadowColor: AppColor.primaryColor.withOpacity(0.3),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: () {
                ProductDetailsControllerImp   controller= Get.put(ProductDetailsControllerImp());
                if(controller.selectedCount==0 || controller.selectedCount==null || (controller.isbox==false && controller.isunit==false)){
                  Get.snackbar(
                      "155".tr,"207".tr);
                }else{
                  controller.addselectedCount(
                      controller.getPrice(controller.itemsModel)
                  );
                  controller.cartController.refreshPage();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPackageOption({
    required BuildContext context,
    required String title,
    required bool selected,
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: selected ? AppColor.primaryColor.withOpacity(0.08) : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 22,
                color: selected ? AppColor.primaryColor : AppColor.grey),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: selected ? AppColor.primaryColor : AppColor.grey,
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}