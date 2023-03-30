import 'package:brasil_fields/brasil_fields.dart';
import 'package:commercialize/helper/ProductCategories.dart';
import 'package:commercialize/res/app_colors.dart';
import 'package:commercialize/res/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:validadores/validadores.dart';

class DropdownFilter extends StatefulWidget {
  const DropdownFilter({Key? key}) : super(key: key);

  @override
  State<DropdownFilter> createState() => _DropdownFilterState();
}

class _DropdownFilterState extends State<DropdownFilter> {

  final List<DropdownMenuItem> _listStates = [const DropdownMenuItem(value: AppStrings.filterDefault, child: Text(AppStrings.filterDefault))];
  String _stateSelected = AppStrings.filterDefault;
  final List<DropdownMenuItem> _listCategory = [const DropdownMenuItem(value: AppStrings.filterDefault, child: Text(AppStrings.filterDefault))];
  String _categorySelected = AppStrings.filterDefault;

  @override
  void initState() {
    super.initState();

    for (var estado in Estados.listaEstadosSigla) {
      _listStates.add(DropdownMenuItem(
        value: estado,
        child: Text(estado),
      ));
    }

    for (var category in ProducyCategories.listCategories) {
      _listCategory.add(DropdownMenuItem(value: category, child: Text(category)));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: DropdownButtonFormField(
                icon: const Icon(Icons.keyboard_arrow_down),
                decoration: InputDecoration(border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(8, 0, 4, 0),
                ),
                items: _listStates,
                value: _stateSelected,
                hint: const Text(AppStrings.stateDropDown),
                style: const TextStyle(color: Colors.black, fontSize: 18),
                onChanged: (value) {
                  _stateSelected = value;
                },
                validator: (value) {
                  return Validador()
                      .add(Validar.OBRIGATORIO, msg: AppStrings.requiredField)
                      .valido(value);
                },
              ),
            )),
        Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: DropdownButtonFormField(
                icon: const Icon(Icons.keyboard_arrow_down),
                decoration: InputDecoration(border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                  contentPadding: const EdgeInsets.fromLTRB(8, 0, 4, 0),
                ),
                value: _categorySelected,
                items: _listCategory,
                hint: const Text(AppStrings.categoryDropDown),
                style: const TextStyle(color: Colors.black, fontSize: 18),
                onChanged: (value) {
                  _categorySelected = value;
                },
                validator: (value) {
                  return Validador()
                      .add(Validar.OBRIGATORIO, msg: AppStrings.requiredField)
                      .valido(value);
                },
              ),
            )),
      ],
    );
  }
}
