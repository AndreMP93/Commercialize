import 'package:commercialize/firebase/CloudDataBase.dart';
import 'package:commercialize/res/app_strings.dart';
import 'package:mobx/mobx.dart';
import 'package:commercialize/model/Ad.dart';
part 'HomeViewModel.g.dart';

class HomeViewModel = _HomeViewModel with _$HomeViewModel;
abstract class _HomeViewModel with Store{
  final CloudDataBase _db = CloudDataBase();
  ObservableList<Ad> allAds = ObservableList();
  @observable
  String? keyword;
  @observable
  String stateSelected = AppStrings.filterDefault;
  @observable
  String categorySelected = AppStrings.filterDefault;
  @observable
  String errorMessage = "";
  @observable
  bool isLoadingAds = true;

  @action
  Future<void> getAllAds([String? state, String? category, String? keyword]) async {
    isLoadingAds = true;
    try{
      allAds.clear();
      List<Ad> result = await _db.getAdsWithFilterApplied(state, category, keyword);
      allAds.addAll(result);
    }catch(error){
      errorMessage = error.toString();
    }
    isLoadingAds = false;
  }

  @action
  Future<void> applyFilter() async {
    String? state;
    String? category;
    if(stateSelected != AppStrings.filterDefault){
      state = stateSelected;
    }
    if(categorySelected != AppStrings.filterDefault){
      category = categorySelected;
    }
    if(keyword != null){
      await getAllAds(state, category, keyword);
    }else{
      await getAllAds(state, category, null);
    }

  }


}