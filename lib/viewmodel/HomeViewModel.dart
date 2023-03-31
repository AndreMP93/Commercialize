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
  String stateSelected = AppStrings.filterDefault;
  @observable
  String categorySelected = AppStrings.filterDefault;
  @observable
  String errorMessage = "";
  @observable
  bool isLoadingAds = true;

  @action
  Future<void> getAllAds([String? state, String? category]) async {
    isLoadingAds = true;
    try{
      allAds.clear();
      List<Ad> result = await _db.getAdsWithFilterApplied(state, category);
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
    await getAllAds(state, category);
  }


}