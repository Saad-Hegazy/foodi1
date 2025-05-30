
import 'package:flutter/material.dart';

import '../../core/constant/color.dart';
import '../../core/functions/validinput.dart';

class CustomAppBar extends StatelessWidget {
  final String titleappbar;
  final void Function()? onPressedIconFavorite;
  final void Function()? onPressedSearch;
  final void Function(String)? onChanged;
  final TextEditingController mycontroller;
  const CustomAppBar(
      {Key? key,
        required this.titleappbar,
        this.onPressedSearch,
        required this.onPressedIconFavorite,
        this.onChanged,
        required this.mycontroller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: const EdgeInsets.only(top: 10,bottom: 5,left: 3,right: 3),
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
          child: IconButton(
              onPressed: onPressedIconFavorite,
              icon: Icon(
                Icons.favorite_border_outlined,
                size: 20,
                color: Colors.grey[600],
              )),
        )
      ]),
    );
  }
}