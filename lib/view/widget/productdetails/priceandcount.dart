import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constant/color.dart';
import '../items/ProductCountSelector.dart';
class PriceAndCountItems extends StatelessWidget {

  final ValueChanged<int> onCountChanged;
  final String count;
  // final void Function()? onAdd;
  final String price;
  final String oldprice;
  final int hasDiscount;
   const PriceAndCountItems(
      {super.key,
        // required this.onAdd,
        required this.count,
        required this.price,
        required this.oldprice,
        required this.hasDiscount,
        required this.onCountChanged,

      });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
          Text("186".tr,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor, fontSize: 24, height: 1.1),),

            ProductCountRollCircle(
                initialCount: int.parse(count),
                onCountChanged:onCountChanged,
              ),
          ],
        ),
        const Spacer(),
        Column(
          children: [
            Text(
              "$price SAR",
              style: const TextStyle(
                  color: AppColor.primaryColor, fontSize: 20,),
            ),
            Text("197".tr,
              style: const TextStyle(
              color: AppColor.grey, fontSize: 12),),
            hasDiscount==1?
            Text("$oldprice SAR",
              style: const TextStyle(
                height: 0.9,
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.lineThrough, // Strikethrough
              ),
            ):Text("")
          ],
        )
      ],
    );
  }
}