import 'dart:io';

import 'package:commercialize/firebase/CloudDataBase.dart';
import 'package:commercialize/model/Ad.dart';
import 'package:commercialize/model/AppUser.dart';
import 'package:commercialize/res/app_strings.dart';
import 'package:mobx/mobx.dart';
part 'MyAdsViewModel.g.dart';

class MyAdsViewModel = _MyAdsViewModel with _$MyAdsViewModel;

abstract class _MyAdsViewModel with Store{
  final CloudDataBase _db = CloudDataBase();
  @observable
  AppUser userData = AppUser(name: "SEM NOME");
  ObservableList<Ad> myAds = ObservableList();
  @observable
  Ad? ad;
  @observable
  bool loadingAds = true;
  @observable
  String errorMessage = "";

  @observable
  bool isRegisteringAd = false;

  @action
  Future getUserData(String userID) async {
    AppUser? result = await _db.getUserData(userID);
    if(result != null){
      userData = result;
    }else{
      errorMessage = AppStrings.errorGettingUserData;
    }
  }

  @action
  Future getMyAds(AppUser user) async {
    loadingAds = true;
    myAds.clear();
    AppUser? result = await _db.getUserData(user.uId!);
    if(result != null){
      userData = result;
      List<Ad> adList = await _db.getAllUserAds(userData);
      for (var ad in adList){
        myAds.add(ad);
      }
    }else{
      errorMessage = AppStrings.errorGettingUserData;
    }
    loadingAds = false;
  }

  @action
  Future deleteAd(Ad ad) async {
    String result = await _db.deleteAd(ad);
    if(result.isNotEmpty){
      errorMessage = result;
    }else{
      myAds.removeWhere((a) => a.id == ad.id);
      userData.myAds.removeWhere((element) => element == ad.id);
      final result = await _db.updateUserData(userData);
      if(result.isNotEmpty){
        errorMessage = result;
      }
    }
  }

  @action
  Future getAd(Ad adData) async {
    Ad? result = await _db.getAd(adData);
    if(result!=null){
      ad = result;
    }else{
      errorMessage = AppStrings.errorGettingAdData;
    }
  }

  @action
  Future updateAd(Ad ad) async {
    loadingAds = true;
    String result = await _db.updateAd(ad);
    if(result.isNotEmpty){
      errorMessage = result;
    }else{
      await getAd(ad);
    }
    loadingAds = false;
  }

  @action
  Future addPhoto(File photo, Ad ad) async {
    String result = await _db.uploadProductPhoto(photo, ad);
    if(result.isNotEmpty){
      errorMessage = result;
    }else{
      updateAd(ad);
    }
  }

  @action
  Future removePhoto(String urlPhoto) async {
    await _db.deleteProductPhoto(urlPhoto);
    ad!.photos.removeWhere((element) => element == urlPhoto);
    await updateAd(ad!);
  }


  @action
  Future registerAd(Ad ad, List<File> photos) async {
    isRegisteringAd = true;
    String resut = await _db.registerAd(ad);
    await _updadeUserAds(userData, ad.id);
    if(resut.isNotEmpty){
      errorMessage = resut;
    }else{
      for(var photo in photos){
        await _db.uploadProductPhoto(photo, ad);
      }
      resut = await _db.updateAd(ad);
      if(resut.isNotEmpty){
        errorMessage = resut;
      }else{
        await getMyAds(userData);
      }
    }
    isRegisteringAd = false;
  }


  Future _updadeUserAds(AppUser user, String adId) async {
    user.myAds.add(adId);
      String result = await _db.updateUserData(user);
      if(result.isNotEmpty){
        errorMessage = result;
      }
  }

}