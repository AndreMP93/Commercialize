import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final VoidCallback onPressed;
  const CustomButton({
    required this.text,
    required this.textColor,
    required this.onPressed,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.fromLTRB(32, 16, 32, 16)
      ),
      child: Text(text, style: TextStyle(color: textColor, fontSize: 20),),
    );
  }
}
