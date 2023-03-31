import 'dart:io';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:commercialize/helper/GetImage.dart';
import 'package:commercialize/helper/ProductCategories.dart';
import 'package:commercialize/helper/ScreenRoutes.dart';
import 'package:commercialize/model/Ad.dart';
import 'package:commercialize/res/app_colors.dart';
import 'package:commercialize/res/app_strings.dart';
import 'package:commercialize/viewmodel/MyAdsViewModel.dart';
import 'package:commercialize/widget/CustomAlertDialogEditData.dart';
import 'package:commercialize/widget/CustomInputTextDialog.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class DetailsMyAds extends StatefulWidget {
  final Ad ad;
  const DetailsMyAds({required this.ad, Key? key}) : super(key: key);

  @override
  State<DetailsMyAds> createState() => _DetailsMyAdsState();
}

class _DetailsMyAdsState extends State<DetailsMyAds> {
  late Ad _ad;
  late Widget _addPhotoButton;
  late List<Widget> _itensCarousel;
  late MyAdsViewModel _myAdsViewModel;

  final List<DropdownMenuItem> _listStates = [];
  final List<DropdownMenuItem> _listCategory = [];


  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  
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

    _ad = widget.ad;

    _addPhotoButton = Container(
      padding: const EdgeInsets.all(8),
      width: 200,
      decoration: const BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.all(Radius.circular(20))),
      child: GestureDetector(
        onTap: (){_getProductImage();},
        child: const Center(
          child: Icon(Icons.add_a_photo,size: 150, color: Colors.white),
        ),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _myAdsViewModel.getAd(_ad);
      if(_myAdsViewModel.ad != null){
        _ad.copy(_myAdsViewModel.ad!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    _titleController.text = _ad.title;
    _priceController.text = _ad.price;
    _phoneController.text = _ad.phone;
    _descriptionController.text = _ad.description;
    _myAdsViewModel = Provider.of<MyAdsViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.adDetails),),
      body: Observer(builder: (_){
        return (_myAdsViewModel.ad == null)?Container(child: Center(child: CircularProgressIndicator(),),)
            :Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 15),
                    child: GestureDetector(
                      onTap: (){_editTitle(context);},
                      child: Text(
                        _myAdsViewModel.ad!.title,
                        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,),
                    )
                ),


                CarouselSlider(
                    items: _getItensCarousel(_myAdsViewModel.ad!.photos),
                    options: CarouselOptions(height: 200,)
                ),

                SizedBox(height: 20,),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: DropdownButtonFormField(
                            items: _listStates,
                            value: _myAdsViewModel.ad!.state,
                            hint: const Text(AppStrings.stateDropDown),
                            style: const TextStyle(color: Colors.black, fontSize: 18),
                            onChanged: (value) async {
                              _ad.state = value;
                              await _myAdsViewModel.updateAd(_ad);
                            },
                          ),
                        )),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: DropdownButtonFormField(
                            items: _listCategory,
                            value: _myAdsViewModel.ad!.category,
                            hint: const Text(AppStrings.categoryDropDown),
                            style: const TextStyle(color: Colors.black, fontSize: 18),
                            onChanged: (value) async {
                              _ad.category = value;
                              await _myAdsViewModel.updateAd(_ad);
                            },
                          ),
                        )),
                  ],
                ),
                const SizedBox(height: 8,),
                Row(
                  children: [
                    const Icon(Icons.attach_money, color: AppColors.primaryColor, size: 32),
                    const SizedBox(width: 8,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${AppStrings.productPrice}:", style: TextStyle(color: Colors.grey[700],fontSize: 16),),
                        const SizedBox(height: 5,),
                        Text(_myAdsViewModel.ad!.price, style: const TextStyle(fontSize: 20),),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                        onTap: (){_editPrice(context);},
                        child: const Icon(Icons.edit, color: AppColors.primaryColor, size: 32))
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    const Icon(Icons.phone, color: AppColors.primaryColor, size: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${AppStrings.phoneText}:", style: TextStyle(color: Colors.grey[700],fontSize: 16),),
                          const SizedBox(height: 5,),
                          Text(_myAdsViewModel.ad!.phone, style: const TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(onTap: (){
                      _editPhone(context);
                    }, child: const Icon(Icons.edit, color: AppColors.primaryColor, size: 32))
                  ],
                ),
                const Divider(),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 5), child: Icon(Icons.info, color: AppColors.primaryColor, size: 32),),
                    const SizedBox(width: 8,),
                    Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${AppStrings.productDescription}:", style: TextStyle(color: Colors.grey[700],fontSize: 16),),
                            const SizedBox(height: 5,),
                            Text(_myAdsViewModel.ad!.description, style: const TextStyle(fontSize: 20),)
                          ],
                        )
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: GestureDetector(onTap: (){
                        _editDescription(context);
                      }, child: const Icon(Icons.edit, color: AppColors.primaryColor, size: 32)),)
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  List<Widget> _getItensCarousel(List<dynamic> urlPhotos) {
    _itensCarousel = urlPhotos.map((item) => Container(
      padding: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.height * 0.7,
      child: GestureDetector(
        child: Center(
          child: Image.network(item, fit: BoxFit.cover, height: 400.0,),
        ),
        onTap: ()async{
          Navigator.pushNamed(context, ScreenRoutes.SELECTED_IMAGE_ROUTE, arguments: {"ad": _ad, "urlPhoto": item});
        },
      ),
    )).toList();
    _itensCarousel.add(_addPhotoButton);
    return _itensCarousel;
  }
  Future _getProductImage() async {
    File? image = await GetImage.fromGallery();
    if (image != null) {
      await _myAdsViewModel.addPhoto(image, _ad);
    }
  }

  Future<void> _editTitle(BuildContext context)async{
    final formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (BuildContext contexto){
          return CustomAlertDialogEditData(
              title: const Text(AppStrings.editTitle),
              formKey: formKey,
              controller: _titleController,
              inputTextWidget: CustomInputTextDialog(formKey: formKey, controller: _titleController),
              updateAdFunction: ()async{
                _ad.title = _titleController.text;
                await _myAdsViewModel.updateAd(_ad);
              }
          );
        }
    );
  }



  Future<void> _editPrice(BuildContext context)async{
    final formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (BuildContext contexto){
          return CustomAlertDialogEditData(
              title: const Text(AppStrings.productPrice),
              formKey: formKey,
              controller: _priceController,
              inputTextWidget: CustomInputTextDialog(
                  formKey: formKey,
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, RealInputFormatter(moeda: true)]
              ),
              updateAdFunction: ()async{
                _ad.price = _priceController.text;
                await _myAdsViewModel.updateAd(_ad);
                print("TESTE: ${_ad.title}");
              }
          );
        }
    );
  }

  Future<void> _editPhone(BuildContext context)async{
    final formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (BuildContext contexto){
          return CustomAlertDialogEditData(
              title: const Text(AppStrings.editPhone),
              formKey: formKey,
              controller: _phoneController,
              inputTextWidget: CustomInputTextDialog(
                  formKey: formKey,
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, TelefoneInputFormatter()]
              ),
              updateAdFunction: ()async{
                _ad.phone = _phoneController.text;
                await _myAdsViewModel.updateAd(_ad);
              }
          );
        }
    );
  }

  Future<void> _editDescription(BuildContext context)async{
    final formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (BuildContext contexto){
          return CustomAlertDialogEditData(
              title: const Text(AppStrings.editDescription),
              formKey: formKey,
              controller: _descriptionController,
              inputTextWidget: CustomInputTextDialog( formKey: formKey,  controller: _descriptionController),
              updateAdFunction: ()async{
                _ad.description = _descriptionController.text;
                await _myAdsViewModel.updateAd(_ad);
              }
          );
        }
    );
  }

}
