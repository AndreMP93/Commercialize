import 'package:commercialize/helper/ScreenRoutes.dart';
import 'package:commercialize/model/Ad.dart';
import 'package:commercialize/model/AppUser.dart';
import 'package:commercialize/res/app_strings.dart';
import 'package:commercialize/viewmodel/AuthenticationViewModel.dart';
import 'package:commercialize/viewmodel/MyAdsViewModel.dart';
import 'package:commercialize/widget/AdItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class MyAds extends StatefulWidget {
  const MyAds({Key? key}) : super(key: key);

  @override
  State<MyAds> createState() => _MyAdsState();
}

class _MyAdsState extends State<MyAds> {
  late MyAdsViewModel myAdsViewModel;
  late AuthenticationViewModel authViewModel;
  late ObservableList<Ad> _myAds;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await authViewModel.checkLoggedUser();
      AppUser? user = authViewModel.userLogged;
      if(user!=null){
        await myAdsViewModel.getMyAds(user);
        _myAds = myAdsViewModel.myAds;
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    myAdsViewModel = Provider.of<MyAdsViewModel>(context);
    authViewModel = Provider.of<AuthenticationViewModel>(context);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.myAdsTitle),
        ),

        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.white,
          child: const Icon(Icons.add),
          onPressed: (){
            Navigator.pushNamed(context, ScreenRoutes.CREATE_AD_ROUTE);
          },
        ),

        body: Observer(builder: (_){
            return (myAdsViewModel.loadingAds)
                ? Container(child: const Center(child: CircularProgressIndicator(),),)
                :   ListView.builder(
                itemCount: myAdsViewModel.myAds.length,
                itemBuilder: (BuildContext context, int index){
                  final Ad ad = myAdsViewModel.myAds[index];
                  return AdItem(
                      title: Text(ad.title, style: const TextStyle( fontSize: 18, fontWeight: FontWeight.bold )),
                      price: Text(ad.price),
                      urlProductPhoto: ad.photos[0],
                      showAdDetails: (){Navigator.pushNamed(context, ScreenRoutes.AD_DETAILS_ROUTE, arguments: ad);},
                      deleteAd: (){}
                  );
                }
            );
        })
    );
  }
}

