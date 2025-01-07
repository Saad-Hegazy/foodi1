import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../controller/cart_controller.dart';

class ItemQuantityPicker extends StatelessWidget {
  late  int? initialQuantity;
  int? itemId;
  Duration delayDuration =  Duration(seconds: 2);

  CartController cartController = Get.put(CartController());
  // Constructor to initialize the initial value and the callback
   ItemQuantityPicker({
    super.key,
    this.initialQuantity,
  });

  @override
  Widget build(BuildContext context) {
    // List of quantities (1 to 100, you can adjust this as per your need)
    List<int> quantities = List.generate(1000, (index) => index + 1);
    int gapcount;
    return CupertinoPicker(
          itemExtent: 79.0, // Height of each item in the picker
          scrollController: FixedExtentScrollController(initialItem: initialQuantity! - 1),
          onSelectedItemChanged: (index) {
    Future.delayed(delayDuration, ()
    {
      if (quantities[index] > initialQuantity!) {
        gapcount = quantities[index] - initialQuantity!;
        cartController.add(1, gapcount);
        initialQuantity = quantities[index];
        cartController.refreshPage();
      } else if (quantities[index] < initialQuantity!) {
        gapcount = initialQuantity! - quantities[index];
        cartController.delete(1, gapcount);
        initialQuantity = quantities[index];
        cartController.refreshPage();
      } else if (quantities[index] == initialQuantity) {

      }
    });
          },
          children: quantities.map((quantity) {
            return Center(
              child: Text(
                '$quantity',
                style: TextStyle(fontSize: 24),
              ),
            );
          }).toList(),
        );

  }
}
