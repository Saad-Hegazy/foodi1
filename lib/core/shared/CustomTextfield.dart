import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? mycontroller;
  final String count;
  void Function()? onEditingComplete;
   CustomTextField(
      {Key? key,
        required this.count,
        required this.onEditingComplete,
        required this.mycontroller,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        onEditingComplete:onEditingComplete ,
        keyboardType: TextInputType.number,
        controller: mycontroller,
        decoration: InputDecoration(
            hintText: count,
            hintStyle: const TextStyle(fontSize: 14),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10))
        ),
      ),
    );
  }
}