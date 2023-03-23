import 'package:flutter/material.dart';
import 'package:commercialize/res/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final Icon icon;
  final bool isPassword;
  final TextInputType keyboardType;

  const CustomTextField({
        Key? key,
        required this.labelText,
        required this.controller,
        required this.icon,
        this.keyboardType = TextInputType.text,
        this.isPassword = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword,
        decoration: InputDecoration(
            labelText: labelText,
            prefixIcon: icon,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(
                  color:Colors.grey,
                  width: 3,
                )
            ), //normal border
            enabledBorder: const OutlineInputBorder( //Outline border type for TextFeild
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(
                  color:Colors.grey,
                  width: 3,
                )
            ), //enabled border
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(
                  color: AppColors.primaryColor,
                  width: 3,
                )
            )
        )
    );
  }
}
