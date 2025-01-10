import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../controller/cart_controller.dart';

class ItemQuantityPicker extends StatelessWidget {
  late  int? initialQuantity;
  Function(int)? onSelectedItemChang;
  Duration delayDuration =  Duration(seconds: 1);
  // Constructor to initialize the initial value and the callback
   ItemQuantityPicker({
    super.key,
    required this.initialQuantity,
    required this.onSelectedItemChang,
  });

  @override
  Widget build(BuildContext context) {
    // List of quantities (1 to 100, you can adjust this as per your need)
    List<int> quantities = List.generate(1000, (index) => index + 1);
    return CupertinoPicker(
          itemExtent: 79.0, // Height of each item in the picker
          scrollController: FixedExtentScrollController(initialItem: initialQuantity! - 1),
          onSelectedItemChanged: (index) {
            Future.delayed(delayDuration, ()
            {
              onSelectedItemChang!(quantities[index]);
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
