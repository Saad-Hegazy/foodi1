import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/productdetails_controller.dart';
import '../../core/class/handlingdataview.dart';
import '../../core/constant/color.dart';
import '../../core/constant/routes.dart';
import '../../core/functions/translatefatabase.dart';
import '../../core/functions/truncatetext.dart';
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
          widget: ListView(
            children: [
              // Animated Top Page with smooth transition
              AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(seconds: 1),
                child: const TopProductPageDetails(),
              ),
              const SizedBox(height: 100),

              // Main Product Details Container with sliding effect
              AnimatedContainer(
                padding: const EdgeInsets.all(20),
                duration: Duration(milliseconds: 500), // Smooth transition
                curve: Curves.easeInOut,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name with smoother text animations
                    AnimatedSwitcher(
                      duration: Duration(seconds: 1),
                      child: Text(
                        translateDatabase(
                          controller.itemsModel!.itemsNameAr.toString(),
                          controller.itemsModel!.itemsName.toString(),
                        ),
                        key: ValueKey<String>(controller.itemsModel!.itemsName.toString()),
                        style: const TextStyle(
                          color: AppColor.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Quantity Selection (Radio Buttons with fade in effect)
                    FadeTransition(
                      opacity: AlwaysStoppedAnimation(1.0), // Full opacity
                      child: Row(
                        children: [
                          Expanded(
                            child: RadioListTile<bool>(
                              activeColor: AppColor.primaryColor,
                              selected: controller.itemsModel!.itemsquantityinbox! > 1,
                              title: Text("183".tr),
                              value: true,
                              groupValue: controller.isbox,
                              onChanged: (value) {
                                if (value != null) {
                                  controller.isBox(value);
                                  controller.modifyquantity();
                                }
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<bool>(
                              activeColor: AppColor.primaryColor,
                              selected: controller.itemsModel!.itemsquantityinbox! <= 1,
                              title: Text("184".tr),
                              value: false,
                              groupValue: controller.isbox,
                              onChanged: (value) {
                                if (value != null) {
                                  controller.isBox(value);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Price and Count Widgets with subtle fade-in effect
                    PriceAndCountItems(
                      onAdd: () {
                        controller.add(controller.getPrice(controller.itemsModel));
                      },
                      onRemove: () {
                        controller.remove();
                      },
                      price: "${controller.getPrice(controller.itemsModel).toStringAsFixed(2)}",
                      count: controller.isbox!
                          ? "${controller.countitems ~/ controller.itemsModel!.itemsquantityinbox!.toInt()}"
                          : controller.countitems.toString(),
                      oldprice: "${controller.getPricewithoutDiscount(controller.itemsModel).toStringAsFixed(2)}",
                      hasDiscount: controller.hasDiscount(controller.itemsModel),
                    ),

                    const SizedBox(height: 10),

                    // Product Description with smooth text fade in and animation
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: Text(
                        translateDatabase(controller.itemsModel!.itemsDescAr, controller.itemsModel!.itemsDesc),
                        key: ValueKey<String>(controller.itemsModel!.itemsDesc.toString()),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: AppColor.grey2,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom Cart Button with shadow effect and smooth tap animation
      bottomNavigationBar: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColor.primaryColor.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: AppColor.primaryColor,
          onPressed: () {
            Get.toNamed(AppRoute.cart);
          },
          child: Text(
            "52".tr,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}