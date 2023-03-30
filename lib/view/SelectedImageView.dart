import 'package:commercialize/model/Ad.dart';
import 'package:commercialize/res/theme.dart';
import 'package:commercialize/viewmodel/MyAdsViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectedImageView extends StatelessWidget {
  final Ad ad;
  final String urlPhoto;
  const SelectedImageView({required this.ad, required this.urlPhoto, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyAdsViewModel viewModel = Provider.of<MyAdsViewModel>(context);
    return Theme(
        data: CustomTheme.whiteTheme,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            actions: (ad.photos.length <2)?[] : [
              IconButton(
                  onPressed: ()async{
                    await viewModel.removePhoto(urlPhoto);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.delete, color: Colors.red,))
            ],
          ),
          
          body: Center(
            child: Image.network(urlPhoto),
          ),
        )
    );
  }
}
