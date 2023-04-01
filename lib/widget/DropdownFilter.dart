import 'package:brasil_fields/brasil_fields.dart';
import 'package:commercialize/helper/ProductCategories.dart';
import 'package:commercialize/model/Ad.dart';
import 'package:commercialize/res/app_colors.dart';
import 'package:commercialize/res/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:validadores/validadores.dart';

class DropdownFilter extends StatefulWidget {
  final Function(String) onChangedState;
  final Function(String) onChangedCategory;
  final bool isForFiltering;
  final Ad? ad;
  const DropdownFilter({
    required this.onChangedState,
    required this.onChangedCategory,
    this.isForFiltering = false,
    this.ad, Key? key
  }) : super(key: key);

  @override
  State<DropdownFilter> createState() => _DropdownFilterState();
}

class _DropdownFilterState extends State<DropdownFilter> {

  final List<DropdownMenuItem> _listStates = [];
  String _stateSelected = AppStrings.filterDefault;
  final List<DropdownMenuItem> _listCategory = [];
  String _categorySelected = AppStrings.filterDefault;

  @override
  void initState() {
    super.initState();
    if(widget.isForFiltering){
      _listStates.add(const DropdownMenuItem(value: AppStrings.filterDefault, child: Text(AppStrings.filterDefault)));
      _listCategory.add(const DropdownMenuItem(value: AppStrings.filterDefault, child: Text(AppStrings.filterDefault)));
    }

    if(widget.ad != null){
      _stateSelected = widget.ad!.state;
      _categorySelected = widget.ad!.category;
    }

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
                value: (widget.isForFiltering || widget.ad != null) ? _stateSelected : null,
                hint: const Text(AppStrings.stateText),
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
                value: (widget.isForFiltering || widget.ad != null)? _categorySelected : null,
                isExpanded: true,
                items: _listCategory,
                hint: const Text(AppStrings.categoryText),
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
