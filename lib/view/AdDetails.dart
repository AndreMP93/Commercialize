import 'package:brasil_fields/brasil_fields.dart';
import 'package:commercialize/model/Ad.dart';
import 'package:commercialize/res/app_colors.dart';
import 'package:commercialize/res/app_strings.dart';
import 'package:commercialize/viewmodel/MyAdsViewModel.dart';
import 'package:commercialize/widget/CustomInputTextDialog.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:validadores/Validador.dart';
class AdDetails extends StatefulWidget {
  final Ad ad;
  const AdDetails({required this.ad, Key? key}) : super(key: key);

  @override
  State<AdDetails> createState() => _AdDetailsState();
}

class _AdDetailsState extends State<AdDetails> {
  late Ad _ad;
  late MyAdsViewModel _myAdsViewModel;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ad = widget.ad;
  }
  @override
  Widget build(BuildContext context) {

    _titleController.text = _ad.title;
    _priceController.text = _ad.price;
    _phoneController.text = _ad.phone;
    _descriptionController.text = _ad.description;
    _myAdsViewModel = Provider.of<MyAdsViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Detalhes"),),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 25, bottom: 15),
                  child: GestureDetector(
                    onTap: (){_editTitle(context);},
                    child: Text(
                      _titleController.text,
                      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,),
                  )
              ),


              CarouselSlider(
                  items: _ad.photos.map((item) => Container(
                    child: Center(
                      child: Image.network(item, fit: BoxFit.cover, height: 400.0,),
                    ),
                  )).toList(),
                  options: CarouselOptions(height: 200)
              ),

              const SizedBox(height: 20,),

              Row(
                children: [
                  const Icon(Icons.attach_money, color: AppColors.primaryColor, size: 32),
                  const SizedBox(width: 8,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Preço:", style: TextStyle(color: Colors.grey[700],fontSize: 16),),
                      const SizedBox(height: 5,),
                      Text(_priceController.text, style: TextStyle(fontSize: 20),),
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
                        Text("Telefone:", style: TextStyle(color: Colors.grey[700],fontSize: 16),),
                        const SizedBox(height: 5,),
                        Text(_ad.phone, style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                  Spacer(),
                  GestureDetector(onTap: (){}, child: Icon(Icons.edit, color: AppColors.primaryColor, size: 32))
                ],
              ),
              Divider(),

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
                          Text("Detalhes:", style: TextStyle(color: Colors.grey[700],fontSize: 16),),
                          const SizedBox(height: 5,),
                          Text(_ad.description, style: const TextStyle(fontSize: 20),)
                        ],
                      )
                  ),
                  Spacer(),
                  Padding(padding: EdgeInsets.only(top: 5), child: GestureDetector(onTap: (){}, child: const Icon(Icons.edit, color: AppColors.primaryColor, size: 32)),)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> _editTitle(BuildContext context)async{
    final formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (BuildContext contexto){
          return AlertDialog(
            title: const Text(AppStrings.editTitle),
            content: CustomInputTextDialog(formKey: formKey, controller: _titleController),
            actions: [
              TextButton(
                  onPressed: (){Navigator.of(context).pop();},
                  child: const Text(AppStrings.cancelButton)
              ),
              TextButton(
                  onPressed: ()async{
                    if(formKey.currentState!.validate()){
                      _ad.title = _titleController.text;
                      await _myAdsViewModel.updateAd(_ad);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text(AppStrings.saveButton)
              )
            ],
          );
        }
    );
  }

  Future<void> _editPrice(BuildContext context)async{
    final formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (BuildContext contexto){
          return AlertDialog(
            title: const Text(AppStrings.editTitle),
            content: CustomInputTextDialog(
              formKey: formKey,
              controller: _priceController,
              keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly, RealInputFormatter(moeda: true)]
            ),
            actions: [
              TextButton(
                  onPressed: (){Navigator.of(context).pop();},
                  child: const Text(AppStrings.cancelButton)
              ),
              TextButton(
                  onPressed: ()async{
                    if(formKey.currentState!.validate()){
                      _ad.price = _priceController.text;
                      await _myAdsViewModel.updateAd(_ad);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text(AppStrings.saveButton)
              )
            ],
          );
        }
    );
  }

  Future<void> _editPhone(BuildContext context)async{
    final formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (BuildContext contexto){
          return AlertDialog(
            title: const Text(AppStrings.editTitle),
            content: CustomInputTextDialog(
                formKey: formKey,
                controller: _phoneController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly, TelefoneInputFormatter()]
            ),
            actions: [
              TextButton(
                  onPressed: (){Navigator.of(context).pop();},
                  child: const Text(AppStrings.cancelButton)
              ),
              TextButton(
                  onPressed: ()async{
                    if(formKey.currentState!.validate()){
                      _ad.phone = _phoneController.text;
                      await _myAdsViewModel.updateAd(_ad);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text(AppStrings.saveButton)
              )
            ],
          );
        }
    );
  }

  Future<void> _editDescription(BuildContext context)async{
    final formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (BuildContext contexto){
          return AlertDialog(
            title: const Text(AppStrings.editTitle),
            content: CustomInputTextDialog(formKey: formKey, controller: _descriptionController),
            actions: [
              TextButton(
                  onPressed: (){Navigator.of(context).pop();},
                  child: const Text(AppStrings.cancelButton)
              ),
              TextButton(
                  onPressed: ()async{
                    if(formKey.currentState!.validate()){
                      _ad.description = _descriptionController.text;
                      await _myAdsViewModel.updateAd(_ad);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text(AppStrings.saveButton)
              )
            ],
          );
        }
    );
  }
}
