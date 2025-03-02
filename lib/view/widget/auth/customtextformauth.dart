import 'package:flutter/material.dart';
import 'package:foodi1/core/constant/color.dart';

class CustomTextFormAuth extends StatefulWidget {
  final String hinttext;
  final String labeltext;
  final IconData iconData;
  final TextEditingController? mycontroller;
  final String? Function(String?) valid;
  final bool isNumber;
  final bool? obscureText;
  final void Function()? onTapIcon;

  const CustomTextFormAuth({
    super.key,
    required this.hinttext,
    required this.labeltext,
    required this.iconData,
    this.mycontroller,
    required this.valid,
    required this.isNumber,
    this.obscureText,
    this.onTapIcon,
  });

  @override
  State<CustomTextFormAuth> createState() => _CustomTextFormAuthState();
}

class _CustomTextFormAuthState extends State<CustomTextFormAuth> {
  @override
  void initState() {
    super.initState();
    // Add listener to update UI when text changes
    widget.mycontroller?.addListener(_updateState);
  }

  @override
  void dispose() {
    // Remove listener to avoid memory leaks
    widget.mycontroller?.removeListener(_updateState);
    super.dispose();
  }

  void _updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Check if the controller has text
    bool hasText = widget.mycontroller?.text.isNotEmpty ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        cursorColor:AppColor.primaryColor,
        style: const TextStyle(color: Colors.black),
        obscureText: widget.obscureText ?? false,
        validator: widget.valid,
        controller: widget.mycontroller,
        keyboardType: widget.isNumber
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        decoration: InputDecoration(
          focusColor: AppColor.primaryColor,
          hoverColor: AppColor.primaryColor,
          filled: true,
          fillColor: Colors.white,
          hintText: widget.hinttext,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding:
          const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          label: Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              child: Text(widget.labeltext,style: TextStyle(
                color: AppColor.grey
              ),)),
          suffixIcon: InkWell(
              onTap: widget.onTapIcon,
              child: Icon(widget.iconData, color: AppColor.grey)),
          // Update border colors based on text presence and focus
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: hasText ? AppColor.primaryColor : Colors.grey,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.primaryColor),
            borderRadius: BorderRadius.circular(30),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),

        ),
      ),
    );
  }
}