

import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';
import '../../../core/shared/CustomTextfield.dart';
import '../items/quantitypicker.dart';

class PriceAndCountItems extends StatelessWidget {
  final void Function()? onAdd;
  final void Function()? onRemove;
  final String price;
  final String oldprice;
  final String count;
  final int hasDiscount;

   PriceAndCountItems(
      {Key? key,
        required this.onAdd,
        required this.onRemove,
        required this.price,
        required this.oldprice,
        required this.count,
        required this.hasDiscount,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            IconButton(onPressed: () {onAdd!();}, icon: const Icon(Icons.add)),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 2),
                width: 50,
                // height: 30,
                decoration:
                BoxDecoration(border: Border.all(color: Colors.black)),
                child: Text(
                  count,
                  style: const TextStyle(fontSize: 20, height: 1.1,color: Colors.black),
                )
            ),
            IconButton(onPressed: () {onRemove!();}, icon: const Icon(Icons.remove)),
          ],
        ),
        const Spacer(),
        Container(
          child: Column(
            children: [
              Text(
                "$price SAR",
                style: const TextStyle(
                    color: AppColor.primaryColor, fontSize: 30, height: 1.1),
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