
import 'dart:io';

import 'package:commercialize/firebase/CloudDataBase.dart';
import 'package:commercialize/model/Ad.dart';
import 'package:commercialize/model/AppUser.dart';
import 'package:mobx/mobx.dart';
part 'NewAdViewModel.g.dart';

class NewAdViewModel = _NewAdViewModel with _$NewAdViewModel;

abstract class _NewAdViewModel with Store{
  final CloudDataBase _db = CloudDataBase();
  @observable
  String errorMessage = "";
  @observable
  bool isRegisteringAd = false;

  @action
  Future registerAd(Ad ad, List<File> photos, AppUser user) async {
    isRegisteringAd = true;
    String resut = await _db.registerAd(ad);
    await _updadeUserAds(user, ad.id);
    if(resut.isNotEmpty){
      errorMessage = resut;
    }else{
      for(var photo in photos){
        await _db.uploadProductPhoto(photo, ad);
      }
      resut = await _db.updateAd(ad);
      if(resut.isNotEmpty){
        errorMessage = resut;
      }
    }
    isRegisteringAd = false;
  }

  Future _updadeUserAds(AppUser user, String adId) async {
    AppUser? userData = await _db.getUserData(user.uId!);
    if(userData != null){
      userData.myAds.add(adId);
      await _db.updateUserData(userData);
    }
  }
}