import 'package:commercialize/firebase/AuthUser.dart';
import 'package:commercialize/helper/FieldValidation.dart';
import 'package:commercialize/model/AppUser.dart';
import 'package:mobx/mobx.dart';
part 'AuthenticationViewModel.g.dart';
class AuthenticationViewModel = _AuthenticationViewModelBase with _$AuthenticationViewModel;
abstract class _AuthenticationViewModelBase with Store{
  final AuthUser _auth = AuthUser();

  @observable
  bool isLoading = true;
  @observable
  bool signingUp = false;
  @observable
  AppUser? userLogged;
  @observable
  String messageError = "";

  @action
  Future<void> login(AppUser user) async{
    try{
      messageError = "";
      String message = FieldValidation.validationLoginFields(user);
      if(message.isNotEmpty){
        String result = await _auth.login(user);
        if (result.isNotEmpty) {
          messageError = result;
        }else{
          await checkLoggedUser();
        }
      }else {
        messageError = message;
      }
    }catch(error){
      messageError = error.toString();
    }
  }

  @action
  Future<void> checkLoggedUser() async {
    try{
      userLogged = await _auth.userLogged;
      if(userLogged != null){
        isLoading = true;
      }else{
        isLoading = false;
      }
    }catch(error){
      messageError = error.toString();
    }
  }

  @action
  Future<void> logout() async {
    _teste();
    String result = await _auth.signOut();
    if(result.isEmpty){
      isLoading = false;
      await checkLoggedUser();
    }else{
      messageError = result;
    }
  }

  @action
  Future<void> registerUser(AppUser user) async {
    messageError = "";
    signingUp = true;
    String resultValidation = FieldValidation.validationRegistrationFields(user);
    if(resultValidation.isEmpty){
      String result = await _auth.registerUser(user);
      if(result.isEmpty){
        isLoading = true;
        await checkLoggedUser();
      }
    }else{
      messageError = resultValidation;
      isLoading = false;
    }
    signingUp = false;
  }

  @action
  _teste(){
    if(isLoading){
      print("object");
    }
  }
}