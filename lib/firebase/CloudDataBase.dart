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
      print("\n\nERROR: getUserData() $error \n");
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
      print("ERROR: updateUserData() -> ${AppStrings.updateDataUserError} $error");
      return "${AppStrings.updateDataUserError}:: $error";
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
      print("ERROR: registerUserData() -> ${AppStrings.registerUserError}: $onError");
      return "${AppStrings.registerUserError}: $onError";
    }
  }

  Future<String> registerAd(Ad ad) async{
    try{
      ad.id = _fireStore.collection(_adsCollection).doc().id;
      final result = await _fireStore.collection(_adsCollection).doc(ad.id).set(ad.toMap());
      return "";
    }catch(error){
      print("ERROR: registerAd() -> ${AppStrings.registerAdError}: $error");
      return "${AppStrings.registerAdError}: $error";
    }
  }

  Future<String> updateAd(Ad ad) async {
    try{
      await _fireStore.collection(_adsCollection).doc(ad.id).update(ad.toMap());
      return "";
    }catch(error){
      print("ERROr: -> updateAd() ${AppStrings.registerAdError} $error");
      return "${AppStrings.registerAdError} $error";
    }
  }

  Future<List<Ad>> getAllUserAds(AppUser user) async {
    try{
      List<Ad> listAds = [];
      for(var adId in user.myAds){
        final result = await _fireStore.collection(_adsCollection).doc(adId).get();
        if(result.data()!=null){
          listAds.add(Ad.map(result.data()!));
        }
      }
      return listAds;
    }catch(error){
      print("\n.\n ERRO: getAllUserAds() -> $error \n.");
      return [];
    }
  }

  Future<List<Ad>> getAllAds() async {
    List<Ad> ads = [];
    try{
      final QuerySnapshot result = await _fireStore.collection(_adsCollection).get();
      for (var document in result.docs) {
        Ad ad = Ad.map(document.data() as Map<String, dynamic>);
        ads.add(ad);
      }
      return ads;
    }catch(error){
      print("ERROR: getAllAds() -> $error");
      return ads;
    }
  }

  Future<List<Ad>> getAdsWithFilterApplied(String? state, String? category, String? keyword) async {
    List<Ad> ads = [];
    try{
      Query query = _fireStore.collection(_adsCollection);
      if(keyword != null){
        query = query.where("title", isGreaterThanOrEqualTo: keyword)
            .where("title", isLessThan: '${keyword}z')
            .orderBy("title");
      }
      if(state!=null){
        query = query.where("state", isEqualTo: state);
      }
      if(category != null){
        query = query.where("category", isEqualTo: category);
      }
      final QuerySnapshot result = await query.get();
      for (var document in result.docs) {
        Ad ad = Ad.map(document.data() as Map<String, dynamic>);
        ads.add(ad);
      }
      return ads;
    }catch(error){
      print("ERROR: getAdsWithFilterApplied($state, $category) -> $error");
      return ads;
    }
  }

  Future<Ad?> getAd(Ad ad) async{
    try{
      final result = await _fireStore.collection(_adsCollection).doc(ad.id).get();
      if(result.data()!=null){
        return Ad.map(result.data()!);
      }
    }catch(error){
      print("Error: getAd-> $error");
    }
    return null;
  }

  Future<String> deleteAd(Ad ad) async{
    try{
      final pastaRaiz = _storageInstance.ref();
      final adPath = pastaRaiz.child(_productPhotosPath).child(ad.id);
      final ListResult result = await adPath.listAll();
      final List<Future<void>> futures = [];
      result.items.forEach((Reference ref) {
        futures.add(ref.delete());
      });
      // Esperar a exclusão de todos os objetos
      await Future.wait(futures);
      await _fireStore.collection(_adsCollection).doc(ad.id).delete();
      return "";
    }catch(error){
      print("ERROR: deleteAd() -> $error");
      return "Error: -> $error";
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
      print("ERROR: uploadProductPhoto -> $uploadProductPhoto()");
      return e.toString();
    }
  }

  Future<void> deleteProductPhoto(String urlPhoto) async {
    try {
      final fileRef = _storageInstance.refFromURL(urlPhoto);
      await fileRef.delete();
    } catch (e) {
      print("Erro ao deletar imagem: $e");
    }
  }
}