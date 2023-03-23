import 'package:commercialize/firebase/AuthUser.dart';
import 'package:commercialize/model/AppUser.dart';
import 'package:mobx/mobx.dart';
part 'generated/';
class UserViewModel = _AuthenticationViewModelBase with _$AuthenticationViewModel;
abstract class _AuthenticationViewModelBase with Store{
  final AuthUser _auth = AuthUser();

  @observable
  bool isLoading = true;
  @observable
  bool signingUp = false;
  @observable
  AppUser? userLogged;
  @observable
  String mensagemErro = "";


  @action
  Future<void> login(AppUser user) async{
    mensagemErro = "";
    String message = ""; //FieldValidation.validationLoginFields(user);
    if(message.isNotEmpty){
      String result = await _auth.login(user);
      if (result.isNotEmpty) {
        mensagemErro = result;
      }else{
        await checkLoggedUser();
      }
    }else {
      mensagemErro = message;
    }
  }

  @action
  Future<void> checkLoggedUser() async {
    userLogged = await _auth.userLogged;
    if(userLogged != null){
      isLoading = true;
    }else{
      isLoading = false;
    }
  }

  @action
  Future<void> logout() async {
    String result = await _auth.signOut();
    if(result.isEmpty){
      isLoading = false;
      await checkLoggedUser();
    }else{
      mensagemErro = result;
    }
  }

  @action
  Future<void> registerUser(AppUser user) async {
    mensagemErro = "";
    signingUp = true;
    String resultValidation = ""; //FieldValidation.validationRegistrationFields(user);
    if(resultValidation.isEmpty){
      String result = await _auth.registerUser(user);
      if(result.isEmpty){
        isLoading = true;
        await checkLoggedUser();
      }
    }else{
      mensagemErro = resultValidation;
      isLoading = false;
    }
    signingUp = false;
  }

}