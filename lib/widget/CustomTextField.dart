import 'package:flutter/material.dart';
import 'package:commercialize/res/app_colors.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextStyle labelStyle;
  final TextStyle style;
  final TextEditingController controller;
  final Icon icon;
  final bool isPassword;
  final TextInputType keyboardType;
  final Color focusColor;
  final Color enabledColor;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final String? Function(String?)? validator;

  const CustomTextField({
        Key? key,
        required this.labelText,
        required this.controller,
        required this.icon,
        this.keyboardType = TextInputType.text,
        this.isPassword = false,
        this.style = const TextStyle(color: Colors.black, fontSize: 20),
        this.labelStyle = const TextStyle(fontSize: 20),
        this.focusColor = AppColors.primaryColor,
        this.enabledColor = Colors.grey,
        this.inputFormatters,
        this.maxLines = 1,
        this.validator
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword,
        style: style,
        inputFormatters: inputFormatters,
        maxLines: maxLines,
        validator: validator,
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: labelStyle,
            prefixIcon: icon,
            focusColor: focusColor,
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(
                  color: enabledColor,
                  width: 3,
                )
            ), //normal border
            enabledBorder: OutlineInputBorder( //Outline border type for TextFeild
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(
                  color: enabledColor,
                  width: 3,
                )
            ), //enabled border
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(
                  color: focusColor,
                  width: 3,
                )
            )
        )
    );
  }
}
