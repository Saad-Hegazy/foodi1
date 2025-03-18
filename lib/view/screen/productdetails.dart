import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/cartlocal_controller.dart';
import '../../controller/productdetails_controller.dart';
import '../../core/class/handlingdataview.dart';
import '../../core/constant/color.dart';
import '../../core/constant/routes.dart';
import '../../core/functions/translatefatabase.dart';
import '../widget/productdetails/toppageproductdetails.dart';
class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cartControllerLocal = Get.find<CartControllerLocal>();
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
                          if (controller.itemsModel.amountofDiscount> 0)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColor.secondaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "${controller.itemsModel.amountofDiscount}% OFF",
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
                      // Package Selector
                      Obx((){
                        // Package Selector
                       return Container(
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
                                  selected: controller.isbox.value,
                                  onTap: () {
                                    controller.isBox(true);
                                    final existingIndex = cartControllerLocal.cartItems.indexWhere(
                                            (item) => item.item.itemsId == controller.itemsModel.itemsId);
                                    if(existingIndex>-1){
                                      cartControllerLocal.cartItems[existingIndex].unit==0?
                                      cartControllerLocal.cartItems[existingIndex].unit=1:
                                      cartControllerLocal.cartItems[existingIndex].unit=0;
                                    }
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
                                  selected: !controller.isbox.value,
                                  onTap: () {
                                    controller.isBox(false);
                                    final existingIndex = cartControllerLocal.cartItems.indexWhere(
                                            (item) => item.item.itemsId == controller.itemsModel.itemsId);
                                    if(existingIndex>-1){
                                      cartControllerLocal.cartItems[existingIndex].unit==1?
                                      cartControllerLocal.cartItems[existingIndex].unit=0:
                                      cartControllerLocal.cartItems[existingIndex].unit=1;
                                    }
                                  },
                                  icon: Icons.style_outlined,
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    " ${controller.isbox.value?controller.itemsModel.itemPriceBox: controller.itemsModel!.itemPrice} SAR",
                                    style: const TextStyle(
                                      color: AppColor.primaryColor, fontSize: 20,),
                                  ),
                                  controller.itemsModel!.amountofDiscount>0?
                                  Text("${controller.isbox.value?controller.itemsModel.priceBoxwithoutDiscount: controller.itemsModel!.pricewithoutDiscount} SAR",
                                    style: const TextStyle(
                                      height: 0.9,
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.lineThrough, // Strikethrough
                                    ),
                                  ):Text(""),
                                  Text("197".tr,
                                    style: const TextStyle(
                                        color: AppColor.grey, fontSize: 12),),
                                ],
                              )
                            ],
                          ),
                        );
                      }
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
      bottomNavigationBar: GetBuilder<ProductDetailsControllerImp>(
        builder: (controller) => SafeArea(
          child: Container(
            height: 90,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey.shade200),
              ),          ),
          child: Obx(() {
            final existingIndex = cartControllerLocal.cartItems.indexWhere(
                    (item) => item.item.itemsId == controller.itemsModel.itemsId
            );
            final isInCart = existingIndex != -1;
            final currentPrice = controller.isbox.value
                ? controller.itemsModel.itemPriceBox
                : controller.itemsModel.itemPrice;
            return Row(
              children: [
                // Price Section
                if (isInCart) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "214".tr,
                        style: TextStyle(
                          color: AppColor.grey,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "${cartControllerLocal.cartItems[existingIndex].itemTotalPrice!.toStringAsFixed(2)} SAR",
                        style: TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                ] else ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${currentPrice} SAR",
                        style: TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (controller.itemsModel.amountofDiscount > 0)
                        Text(
                          "${controller.isbox.value ? controller.itemsModel.priceBoxwithoutDiscount : controller.itemsModel.pricewithoutDiscount} SAR",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    ],
                  ),
                  Spacer(),
                ],

                // Add to Cart/Quantity Controls
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColor.primaryColor.withOpacity(0.1),
                  ),
                  child: isInCart ? Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (cartControllerLocal.cartItems[existingIndex].quantity < 2) {
                            cartControllerLocal.deleteFromCart(controller.itemsModel.itemsId!);
                          } else {
                            cartControllerLocal.removeFromCart(controller.itemsModel, 1, controller.isbox.value ? 1 : 0);
                          }
                        },
                        icon: Icon(
                          cartControllerLocal.cartItems[existingIndex].quantity < 2
                              ? Icons.delete
                              : Icons.remove,
                          color: AppColor.primaryColor,
                        ),
                      ),
                      Text(
                        "${cartControllerLocal.cartItems[existingIndex].quantity}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primaryColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          cartControllerLocal.addToCart(controller.itemsModel, 1, controller.isbox.value ? 1 : 0);
                        },
                        icon: Icon(Icons.add, color: AppColor.primaryColor),
                      ),
                    ],
                  ) : TextButton.icon(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                    onPressed: () {
                      cartControllerLocal.addToCart(controller.itemsModel, 1, controller.isbox.value ? 1 : 0);
                    },
                    icon: Icon(Icons.shopping_cart, color: AppColor.primaryColor),
                    label: Text(
                      "194".tr,
                      style: TextStyle(
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
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