import 'package:commercialize/res/app_strings.dart';
import 'package:commercialize/widget/CustomInputTextDialog.dart';
import 'package:flutter/material.dart';

class CustomAlertDialogEditData extends StatefulWidget {
  final Text title;
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final CustomInputTextDialog inputTextWidget;
  final Function() updateAdFunction;
  const CustomAlertDialogEditData({
    required this.title,
    required this.formKey,
    required this.controller,
    required this.inputTextWidget,
    required this.updateAdFunction,
    Key? key
  }) : super(key: key);

  @override
  State<CustomAlertDialogEditData> createState() => _CustomAlertDialogEditDataState();
}

class _CustomAlertDialogEditDataState extends State<CustomAlertDialogEditData> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(AppStrings.editTitle),
      content: CustomInputTextDialog(formKey: widget.formKey, controller: widget.controller),
      actions: [
        TextButton(
            onPressed: (){Navigator.of(context).pop();},
            child: const Text(AppStrings.cancelButton)
        ),
        TextButton(
            onPressed: ()async{
              if(widget.formKey.currentState!.validate()){
                widget.updateAdFunction();
                Navigator.of(context).pop();
              }
            },
            child: const Text(AppStrings.saveButton)
        )
      ],
    );
  }
}
