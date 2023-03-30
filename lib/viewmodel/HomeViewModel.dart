import 'package:commercialize/firebase/CloudDataBase.dart';
import 'package:mobx/mobx.dart';
import 'package:commercialize/model/Ad.dart';
part 'HomeViewModel.g.dart';

class HomeViewModel = _HomeViewModel with _$HomeViewModel;
abstract class _HomeViewModel with Store{
  final CloudDataBase _db = CloudDataBase();
  ObservableList<Ad> allAds = ObservableList();
  @observable
  String errorMessage = "";
  @observable
  bool isLoadingAds = true;

  @action
  Future<void> getAllAds() async {
    isLoadingAds = true;
    try{
      print("TESTE 1 $allAds");
      allAds.clear();
      List<Ad> result = await _db.getAllAds();
      print("TESTE 2");
      allAds.addAll(result);
      print("TESTE 3 ${allAds}");
    }catch(error){
      errorMessage = error.toString();
    }
    isLoadingAds = false;
  }
}