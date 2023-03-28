import 'package:commercialize/res/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:validadores/Validador.dart';

class CustomInputTextDialog extends StatelessWidget {

  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType keyboardType;

  const CustomInputTextDialog({
    required this.formKey,
    required this.controller,
    this.inputFormatters,
    this.keyboardType = TextInputType.text,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: (value) {
            return Validador()
                .add(Validar.OBRIGATORIO, msg: AppStrings.requiredField)
                .valido(value);
          },
        )
    );
  }
}
