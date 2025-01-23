import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constant/color.dart';
import '../items/ProductCountSelector.dart';
class PriceAndCountItems extends StatelessWidget {

  final ValueChanged<int> onCountChanged;
  final String count;
  final void Function()? onAdd;
  final String price;
  final String oldprice;
  final int hasDiscount;
   PriceAndCountItems(
      {Key? key,
        required this.onAdd,
        required this.count,
        required this.price,
        required this.oldprice,
        required this.hasDiscount,
        required this.onCountChanged,

      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 18),
              child: Text("186".tr,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor, fontSize: 24, height: 1.1),),
            ),
            Container(
              decoration: BoxDecoration(
                  color:Colors.white70,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.black,
                  )
              ),
              child: ProductCountRollCircle(
                initialCount: int.parse(count),
                onCountChanged:onCountChanged,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: IconButton(
                  onPressed: () {onAdd!();},
                  icon: const Icon(Icons.add_shopping_cart_outlined,color: AppColor.primaryColor,size: 30,)
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          child: Column(
            children: [
              Text(
                "$price SAR",
                style: const TextStyle(
                    color: AppColor.primaryColor, fontSize: 24, height: 1.1),
              ),
              hasDiscount==1?
              Text("$oldprice SAR",
                style: const TextStyle(
                  height: 0.9,
                  fontSize: 20,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.lineThrough, // Strikethrough
                ),
              ):Text("")
            ],
          ),
        )
      ],
    );
  }
}