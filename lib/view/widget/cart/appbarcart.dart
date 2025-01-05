import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/color.dart';

class TopAppbarCart extends StatelessWidget {
  final String title ;
  const TopAppbarCart({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primaryColor,
        alignment: Alignment.center,
        child: Row(
          children: [
            Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      onPressed: () {
                        Get.back() ;
                      }, icon: const Icon(Icons.arrow_back,color: Colors.white,)),
                )),
            Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 20,color: Colors.white),
                  ),
                )),
            const Spacer()
          ],
        )) ;
  }
}