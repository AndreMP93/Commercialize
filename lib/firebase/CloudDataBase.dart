import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commercialize/model/Ad.dart';
import 'package:commercialize/model/AppUser.dart';
import 'package:commercialize/res/app_strings.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CloudDataBase {
  static final CloudDataBase _dataSourceSingleton = CloudDataBase._internal();
  final _fireStore = FirebaseFirestore.instance;
  final FirebaseStorage _storageInstance = FirebaseStorage.instance;
  final String _userCollection = "users";
  final String _adsCollection = "ads";
  final String _profilePicturePath = "profile";
  final String _productPhotosPath = "my-ads";


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
        AppUser appUser = AppUser.map(map);
        appUser.uId = uId;
        return appUser;
      }
      return null;
    }catch(error){
      print("ERROR: $error");
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
      return "${AppStrings.registerUserError}: $onError";
    }
  }

  Future<String> registerAd(Ad ad) async{
    try{
      ad.id = _fireStore.collection(_adsCollection).doc().id;
      await _fireStore.collection(_adsCollection).doc(ad.id).set(ad.toMap());
      return "";
    }catch(error){
      return "${AppStrings.registerAdError}: $error";
    }
  }

  Future<String> updateAd(Ad ad) async {
    try{
      await _fireStore.collection(_adsCollection).doc(ad.id).update(ad.toMap());
      return "";
    }catch(error){
      return "${AppStrings.registerAdError} $error";
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

  Future<String> uploadProductPhoto(File imagem, Ad ad) async {
    try{
      final namePhoto = DateTime.now().microsecondsSinceEpoch.toString();
      final pastaRaiz = _storageInstance.ref();
      final arquivo = pastaRaiz
          .child(_productPhotosPath)
          .child(ad.id)
          .child(namePhoto);
      final TaskSnapshot snapshot = await arquivo.putFile(imagem).whenComplete(() => null);
      String urlPhoto = await snapshot.ref.getDownloadURL();
      ad.photos.add(urlPhoto);
      return "";
    }catch (e){
      return e.toString();
    }
  }

}