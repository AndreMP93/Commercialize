import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commercialize/model/AppUser.dart';
import 'package:commercialize/res/app_strings.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CloudDataBase {
  static final CloudDataBase _dataSourceSingleton = CloudDataBase._internal();
  final _fireStore = FirebaseFirestore.instance;
  final FirebaseStorage _storageInstance = FirebaseStorage.instance;
  final String _userCollection = "users";
  final String _profilePicturePath = "profile";


  factory CloudDataBase(){
    return _dataSourceSingleton;
  }

  CloudDataBase._internal();

  Future<AppUser?> getUserData(String uId) async {
    try{
      final result = await _fireStore
          .collection(_userCollection)
          .doc(uId)
          .get();
      if(result.data()!=null){
        Map<String, dynamic> map = result.data()!;
        AppUser appUser= AppUser.map(map);
        appUser.uId = uId;
        return appUser;
      }
      return null;
    }catch(error){
      return null;
    }
  }

  Future<String> updateUserData(AppUser user) async {
    try{
      String? uId = user.uId;
      if (uId != null){
        await _fireStore
            .collection(_userCollection)
            .doc(uId)
            .update(user.toMap());
        return "";
      }
      return AppStrings.updateDataUserError;
    }catch(error){
      return "${AppStrings.updateDataUserError} $error";
    }
  }

  Future<String> registerUserData(AppUser user) async {
    try{
      String? uId = user.uId;
      if(uId!= null){
        await _fireStore
            .collection(_userCollection)
            .doc(uId)
            .set(user.toMap());
        return "";
      }
      return AppStrings.registerUserError;
    }catch(onError){
      return "${AppStrings.registerUserError} $onError";
    }
  }

  Future<UploadTask?> uploadProfilePicture(File imagem, String userID) async {
    try{
      final pastaRaiz = _storageInstance.ref();
      final arquivo = pastaRaiz.child(_profilePicturePath).child("$userID.jpg");
      return arquivo.putFile(imagem);
    }catch (e){
      return null;
    }
  }

}