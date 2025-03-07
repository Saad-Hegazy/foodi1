import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constant/color.dart';

class CustomButtonAppBar extends StatelessWidget {
  final void Function()? onPressed;
  final String textbutton;
  final IconData icondata;
  final bool? active   ;
  const CustomButtonAppBar(
      {Key? key,
        required this.textbutton,
        required this.icondata,
        required this.onPressed,
        required this.active})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero, // Remove default button padding
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Remove extra tap target space
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icondata,
            size: 22, // Reduced from 25 to 22
            color: active! ? AppColor.primaryColor : AppColor.grey,
          ),
          const SizedBox(height: 2), // Explicit small spacing
          Text(
            textbutton.tr,
            style: TextStyle(
                fontSize: 10, // Reduced from 11 to 10
                color: active! ? AppColor.primaryColor : AppColor.grey2,
                height: 1.2 // Control text line height
            ),
          ),
        ],
      ),
    );
  }
}