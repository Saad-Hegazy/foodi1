import 'package:flutter/material.dart';
import '../../../core/constant/color.dart';
import '../../../core/functions/validinput.dart';
import 'package:badges/badges.dart' as badge;

class CustomAppBarItems extends StatelessWidget {
  final String titleappbar;
  final void Function()? onPressedIconCart;
  final void Function()? onPressedSearch;
  final void Function(String)? onChanged;
  final TextEditingController mycontroller;
  final int itemCount;

  const CustomAppBarItems(
      {Key? key,
        required this.titleappbar,
        this.onPressedSearch,
        required this.onPressedIconCart,
        this.onChanged,
        required this.mycontroller,
        required this.itemCount,

      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: const EdgeInsets.only(top: 10,bottom: 5,left: 3,right: 0),
      child: Row(children: [
        Expanded(
            child: TextFormField(
              onEditingComplete: onPressedSearch,
              controller: mycontroller,
              onChanged: onChanged,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: onPressedSearch,
                ),
                hintText: titleappbar,
                hintStyle: const TextStyle(fontSize: 18, color: AppColor.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              validator: (val) => validInput(val!, 3, 20, "search"), // Adjust min/max as needed
            )
        ),
        const SizedBox(width: 10),
        Container(
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
          width: 60,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: badge.Badge(
            position: badge.BadgePosition.topEnd(top: -6, end: 9),
            showBadge:itemCount> 0, // Only show if count > 0
            badgeContent: Text(
              itemCount.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),),
            child: IconButton(
              onPressed: onPressedIconCart,
              icon: Icon(
                Icons.shopping_cart,
                size: 20,
                color: AppColor.primaryColor,
              ),
            ),
          ),
        )
      ]),
    );
  }
}