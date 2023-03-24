import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:commercialize/helper/GetImage.dart';
import 'package:commercialize/helper/ProductCategories.dart';
import 'package:commercialize/res/app_strings.dart';
import 'package:commercialize/widget/CustomButton.dart';
import 'package:commercialize/widget/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:validadores/validadores.dart';

class NewAdView extends StatefulWidget {
  const NewAdView({Key? key}) : super(key: key);

  @override
  State<NewAdView> createState() => _NewAdViewState();
}

class _NewAdViewState extends State<NewAdView> {

  final _formKey = GlobalKey<FormState>();
  final List<File> _listImage = [];
  final List<DropdownMenuItem> _listStates = [];
  String _stateSelected = "";
  final List<DropdownMenuItem> _listCategory = [];
  String _categorySelected = "";

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _productDescriptionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(var estado in Estados.listaEstadosSigla){
      _listStates.add(DropdownMenuItem(
        value: estado,
        child: Text(estado),
      ));
    }
    
    for( var category in ProducyCategories.listCategories){
      _listCategory.add(DropdownMenuItem(value: category ,child: Text(category)));
    }

  }

  @override
  Widget build(BuildContext context) {
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
                      builder: (state){
                        return Column(
                          children: [
                            SizedBox(
                              height: 100,
                              child: ListView.builder(
                                itemCount: _listImage.length + 1,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index){
                                  if(index == _listImage.length){
                                    return Padding(
                                      padding: EdgeInsets.all(8),
                                      child: GestureDetector(
                                        onTap: (){
                                          _getProductImage();
                                        },
                                        child: const CircleAvatar(
                                          radius: 50,
                                          child: Icon(Icons.add_a_photo, size: 50,),
                                        ),
                                      ),
                                    );
                                  }
                                  if(_listImage.isNotEmpty){
                                    return Padding(
                                        padding: const EdgeInsets.all(8),
                                      child: GestureDetector(
                                        onTap: (){
                                          showDialog(
                                              context: context,
                                              builder: (contex) => Dialog(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    const Text(AppStrings.alertDialogRemoveImageTitle),
                                                    Image.file(_listImage[index]),
                                                    Row(
                                                      children: [
                                                        TextButton(
                                                            onPressed: (){
                                                              Navigator.of(context).pop();
                                                            },
                                                            child: const Text(AppStrings.alertDialogNegativeButton)
                                                        ),
                                                        TextButton(
                                                            onPressed: (){
                                                              _listImage.removeAt(index);
                                                              Navigator.of(context).pop();
                                                            },
                                                            child: const Text(AppStrings.alertDialogPositiveButton)
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )
                                          );
                                        },
                                        child: CircleAvatar(
                                          radius: 50,
                                          backgroundImage: FileImage(_listImage[index]),
                                          child: Container(
                                            color: Color.fromRGBO(255, 255, 255, 0.4),
                                            alignment: Alignment.center,
                                            child: Icon(Icons.delete, color: Colors.red,),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return Container();
                                },
                              ),
                            ),
                            if(state.hasError)
                              Text(state.errorText!, style: const TextStyle(color: Colors.red),)

                          ],
                        );
                      },
                      initialValue: _listImage,
                      validator: (images){
                        if(images!.length ==0){
                          return AppStrings.newAdNoImage;
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(left: 8, right: 8),
                              child: DropdownButtonFormField(
                                  items: _listStates,
                                  // value: _stateSelected,
                                  hint: const Text(AppStrings.stateDropDown),
                                  style: TextStyle(color: Colors.black, fontSize: 20),
                                  onChanged: (value){
                                    _stateSelected = value;
                                  },
                                  validator: (value){
                                    return Validador().add(Validar.OBRIGATORIO, msg: AppStrings.requiredField).valido(value);
                                  },
                              ),
                            )
                        ),
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: DropdownButtonFormField(
                                  items: _listCategory,
                                  hint: const Text(AppStrings.categoryDropDown),
                                  style: const TextStyle(color: Colors.black, fontSize: 20),
                                  onChanged: (value){_categorySelected = value;},
                                validator: (value){
                                    return Validador().add(Validar.OBRIGATORIO, msg: AppStrings.requiredField).valido(value);
                                },
                              ),
                            )
                        )
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 15),
                      child: CustomTextField(
                          labelText: AppStrings.productsName,
                          controller: _productNameController,
                          icon: const Icon(Icons.label_important),
                        validator: (value){
                          return Validador().add(Validar.OBRIGATORIO, msg: AppStrings.requiredField).valido(value);
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
                          validator: (value){
                            return Validador().add(Validar.OBRIGATORIO, msg: AppStrings.requiredField).valido(value);
                          }
                      ),
                    ),
                    CustomTextField(
                        labelText: AppStrings.phoneTextInput,
                        controller: _phoneController,
                        icon: const Icon(Icons.phone),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter()
                        ],
                        validator: (value){
                          return Validador().add(Validar.OBRIGATORIO, msg: AppStrings.requiredField).valido(value);
                        }
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: CustomTextField(
                          labelText: AppStrings.productDescription,
                          controller: _productDescriptionController,
                          icon: const Icon(Icons.info),
                          keyboardType: TextInputType.text,
                          maxLines: null,
                          validator: (value){
                            return Validador()
                                .add(Validar.OBRIGATORIO, msg: AppStrings.requiredField)
                            .maxLength(500, msg: AppStrings.maxCharacters)
                                .valido(value);
                          }
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: CustomButton(
                          text: "Salvar", textColor: Colors.white,
                          onPressed: (){
                            if( _formKey.currentState!.validate()){
                            }
                          })
                    )
                  ],
                ),
              ),
            ),
      )
    );
  }

  Future _getProductImage() async {
    File? image = await GetImage.fromGallery();
    if(image != null){
      _listImage.add(image);
    }
  }
}
