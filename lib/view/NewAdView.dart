import 'dart:io';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:commercialize/helper/GetImage.dart';
import 'package:commercialize/helper/ProductCategories.dart';
import 'package:commercialize/model/Ad.dart';
import 'package:commercialize/model/AppUser.dart';
import 'package:commercialize/res/app_strings.dart';
import 'package:commercialize/viewmodel/MyAdsViewModel.dart';
import 'package:commercialize/widget/CustomButton.dart';
import 'package:commercialize/widget/CustomTextField.dart';
import 'package:commercialize/widget/DropdownFilter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:validadores/validadores.dart';

class NewAdView extends StatefulWidget {
  const NewAdView({Key? key}) : super(key: key);

  @override
  State<NewAdView> createState() => _NewAdViewState();
}

class _NewAdViewState extends State<NewAdView> {

  final _formKey = GlobalKey<FormState>();
  final List<File> _listImage = [];
  // final List<DropdownMenuItem> _listStates = [];
  String _stateSelected = "";
  // final List<DropdownMenuItem> _listCategory = [];
  String _categorySelected = "";

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _productDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // for (var estado in Estados.listaEstadosSigla) {
    //   _listStates.add(DropdownMenuItem(
    //     value: estado,
    //     child: Text(estado),
    //   ));
    // }
    //
    // for (var category in ProducyCategories.listCategories) {
    //   _listCategory.add(DropdownMenuItem(value: category, child: Text(category)));
    // }
  }

  @override
  Widget build(BuildContext context) {

    MyAdsViewModel myAdsViewModel = Provider.of<MyAdsViewModel>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.newAdTitle),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  FormField<List>(
                    builder: (state) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 100,
                            child: ListView.builder(
                              itemCount: _listImage.length + 1,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                if (index == _listImage.length) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: GestureDetector(
                                      onTap: () {
                                        _getProductImage();
                                      },
                                      child: const CircleAvatar(
                                        radius: 50,
                                        child: Icon(
                                          Icons.add_a_photo,
                                          size: 50,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                if (_listImage.isNotEmpty) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: GestureDetector(
                                      onTap: () {
                                        _showAlertDialog(index);
                                      },
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundImage: FileImage(_listImage[index]),
                                        child: Container(
                                          color: const Color.fromRGBO(255, 255, 255, 0.4),
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return Container();
                              },
                            ),
                          ),
                          if (state.hasError)
                            Text(
                              state.errorText!,
                              style: const TextStyle(color: Colors.red),
                            )
                        ],
                      );
                    },
                    initialValue: _listImage,
                    validator: (images) {
                      if (images!.isEmpty) {
                        return AppStrings.newAdNoImage;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 5,),
                  DropdownFilter(
                      onChangedState: (String valueSelected){_stateSelected = valueSelected;},
                      onChangedCategory: (String valueSelected){_categorySelected = valueSelected;}
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: CustomTextField(
                      labelText: AppStrings.productsName,
                      controller: _productNameController,
                      icon: const Icon(Icons.label_important),
                      validator: (value) {
                        return Validador()
                            .add(Validar.OBRIGATORIO, msg: AppStrings.requiredField)
                            .valido(value);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: CustomTextField(
                        labelText: AppStrings.productPrice,
                        controller: _productPriceController,
                        icon: const Icon(Icons.attach_money),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          RealInputFormatter(moeda: true)
                        ],
                        validator: (value) {
                          return Validador()
                              .add(Validar.OBRIGATORIO, msg: AppStrings.requiredField)
                              .valido(value);
                        }),
                  ),
                  CustomTextField(
                      labelText: AppStrings.phoneText,
                      controller: _phoneController,
                      keyboardType: TextInputType.number,
                      icon: const Icon(Icons.phone),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        TelefoneInputFormatter()
                      ],
                      validator: (value) {
                        return Validador()
                            .add(Validar.OBRIGATORIO, msg: AppStrings.requiredField)
                            .valido(value);
                      }),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: CustomTextField(
                        labelText: AppStrings.productDescription,
                        controller: _productDescriptionController,
                        icon: const Icon(Icons.info),
                        keyboardType: TextInputType.text,
                        maxLines: null,
                        validator: (value) {
                          return Validador()
                              .add(Validar.OBRIGATORIO, msg: AppStrings.requiredField)
                              .maxLength(500, msg: AppStrings.maxCharacters)
                              .valido(value);
                        }),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Observer(builder: (_){
                        return CustomButton(
                            child: (myAdsViewModel.isRegisteringAd)
                                ? const CircularProgressIndicator(color: Colors.white,)
                                : const Text(AppStrings.saveButton, style: TextStyle(color: Colors.white, fontSize: 20),),
                            onPressed: () async {
                              if (_formKey.currentState!.validate() && !myAdsViewModel.isRegisteringAd) {
                                Ad ad = Ad(
                                    state: _stateSelected,
                                    category: _categorySelected,
                                    title: _productNameController.text,
                                    price: _productPriceController.text,
                                    phone: _phoneController.text,
                                    description: _productDescriptionController.text,
                                    photos: []);
                                await myAdsViewModel.registerAd(ad, _listImage);
                                if (myAdsViewModel.errorMessage.isNotEmpty) {
                                  print("ERROR: <-> ${myAdsViewModel.errorMessage} ");
                                  SnackBar snackbar =
                                  SnackBar(content: Text(myAdsViewModel.errorMessage));
                                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                }else{
                                  Navigator.pop(context);
                                }
                              }
                            });
                      })
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future _getProductImage() async {
    File? image = await GetImage.fromGallery();
    if (image != null) {
      setState(() {
        _listImage.add(image);
      });
    }
  }

  Future<void> _showAlertDialog(int index){
    return showDialog(
        context: context,
        builder: (contex) => AlertDialog(
          title: Text("Você quer remover essa image?"),
          actions: [
            TextButton(
                onPressed: () {Navigator.of(context).pop();},
                child: const Text(AppStrings
                    .alertDialogNegativeButton)),
            TextButton(
                onPressed: () {
                  setState(() {
                    _listImage.removeAt(index);
                  });
                  Navigator.of(context).pop();
                },
                child: const Text(AppStrings
                    .alertDialogPositiveButton))
          ],
        )
    );
  }
}