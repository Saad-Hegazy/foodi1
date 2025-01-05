import 'package:flutter/material.dart';

class CustomTextFormAuth extends StatelessWidget {
  final String    hinttext;
  final String    labeltext;
  final IconData  iconData;
  final TextEditingController?   mycontroller;
  final String? Function(String?) valid;
  final bool isNumber ;
  final bool? obscureText ;
  final void Function()? onTapIcon;

   const CustomTextFormAuth({
    super.key, required this.hinttext, required this.labeltext, required this.iconData,  this.mycontroller,   required this.valid, required this.isNumber, this.obscureText, this.onTapIcon,
  } );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        style:  TextStyle(color: Colors.black),
        obscureText:obscureText==null||obscureText==false ?false:true,
        validator:valid ,
        controller: mycontroller,
        keyboardType: isNumber?const TextInputType.numberWithOptions(decimal: true):TextInputType.text,
        decoration: InputDecoration(
            filled:true,
            fillColor: Colors.white,
            hintText:hinttext,
            hintStyle:const  TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:const  EdgeInsets.symmetric(vertical: 5 , horizontal: 30),
            label: Container(
                margin:const  EdgeInsets.symmetric(vertical: 5,horizontal: 30),
                child: Text(labeltext)),
            suffixIcon: InkWell(
              onTap:onTapIcon ,
                child: Icon(iconData)
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30)
            )
        ),
      ),
    );
  }
}