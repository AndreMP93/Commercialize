import 'package:brasil_fields/brasil_fields.dart';
import 'package:commercialize/helper/ProductCategories.dart';
import 'package:commercialize/res/app_colors.dart';
import 'package:commercialize/res/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:validadores/validadores.dart';

class DropdownFilter extends StatefulWidget {
  final Function(String) onChangedState;
  final Function(String) onChangedCategory;
  const DropdownFilter({required this.onChangedState,required this.onChangedCategory ,Key? key}) : super(key: key);

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
                decoration: InputDecoration(
                  labelText: AppStrings.stateDropDown,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(18, 0, 4, 0),
                ),
                items: _listStates,
                value: _stateSelected,
                style: const TextStyle(color: Colors.black, fontSize: 18),
                onChanged: (value) {
                  _stateSelected = value;
                  widget.onChangedState(_stateSelected);
                },
                validator: (value) {
                  return Validador()
                      .add(Validar.OBRIGATORIO, msg: AppStrings.requiredField)
                      .valido(value);
                },
              ),
            )),
        Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 8),
              child: DropdownButtonFormField(
                icon: const Icon(Icons.keyboard_arrow_down),
                decoration: InputDecoration(
                  labelText: AppStrings.categoryDropDown,
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                  contentPadding: const EdgeInsets.fromLTRB(18, 0, 4, 0),
                ),
                value: _categorySelected,isExpanded: true,
                items: _listCategory,
                hint: const Text(AppStrings.stateDropDown),
                style: const TextStyle(color: Colors.black, fontSize: 18),
                onChanged: (value) async {
                  _categorySelected = value;
                  await widget.onChangedCategory(_categorySelected);
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
