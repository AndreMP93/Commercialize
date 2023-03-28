import 'package:commercialize/firebase/CloudDataBase.dart';
import 'package:commercialize/model/Ad.dart';
import 'package:commercialize/model/AppUser.dart';
import 'package:mobx/mobx.dart';
part 'MyAdsViewModel.g.dart';

class MyAdsViewModel = _MyAdsViewModel with _$MyAdsViewModel;

abstract class _MyAdsViewModel with Store{
  final CloudDataBase _db = CloudDataBase();

  ObservableList<Ad> myAds = ObservableList();

  @observable
  bool loadingAds = true;
  @observable
  String errorMessage = "";

  @action
  Future getMyAds(AppUser user) async {
    loadingAds = true;
    myAds.clear();
    AppUser? userData = await _db.getUserData(user.uId!);
    List<Ad> adList = await _db.getAllUserAds(userData!);
    for (var ad in adList){
      myAds.add(ad);
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
    }
  }

  @action
  Future updateAd(Ad ad) async {
    loadingAds = true;
    String result = await _db.updateAd(ad);
    if(result.isNotEmpty){
      errorMessage = result;
    }
    loadingAds = false;
  }
}