import 'dart:io';
import 'package:commercialize/firebase/CloudDataBase.dart';
import 'package:commercialize/model/AppUser.dart';
import 'package:commercialize/res/app_strings.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobx/mobx.dart';
part 'RegisterUserViewModel.g.dart';

class RegisterUserViewModel = _RegisterUserViewModel with _$RegisterUserViewModel;

abstract class _RegisterUserViewModel with Store{
  final CloudDataBase _db = CloudDataBase();
  @observable
  String errorMessage = "";
  @observable
  bool isRegisteringUser = false;

  @action
  Future registerUser(AppUser user, File? image) async {
    isRegisteringUser = true;
    try{
      if (image != null && user.uId != null) {
        UploadTask? uploadTask = await _db.uploadProfilePicture(image, user.uId!);
        if (uploadTask != null) {
          final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
          user.urlProfilePicture = await snapshot.ref.getDownloadURL();
        }
      }
      String result = await _db.registerUserData(user);
      if (result.isNotEmpty) {
        errorMessage = result;
      }
    }catch(e){
      errorMessage = "${AppStrings.registerUserError} $e";
    }
    isRegisteringUser = false;
  }
}
