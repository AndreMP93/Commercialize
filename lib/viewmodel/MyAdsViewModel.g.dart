// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MyAdsViewModel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MyAdsViewModel on _MyAdsViewModel, Store {
  late final _$userDataAtom =
      Atom(name: '_MyAdsViewModel.userData', context: context);

  @override
  AppUser get userData {
    _$userDataAtom.reportRead();
    return super.userData;
  }

  @override
  set userData(AppUser value) {
    _$userDataAtom.reportWrite(value, super.userData, () {
      super.userData = value;
    });
  }

  late final _$adAtom = Atom(name: '_MyAdsViewModel.ad', context: context);

  @override
  Ad? get ad {
    _$adAtom.reportRead();
    return super.ad;
  }

  @override
  set ad(Ad? value) {
    _$adAtom.reportWrite(value, super.ad, () {
      super.ad = value;
    });
  }

  late final _$loadingAdsAtom =
      Atom(name: '_MyAdsViewModel.loadingAds', context: context);

  @override
  bool get loadingAds {
    _$loadingAdsAtom.reportRead();
    return super.loadingAds;
  }

  @override
  set loadingAds(bool value) {
    _$loadingAdsAtom.reportWrite(value, super.loadingAds, () {
      super.loadingAds = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_MyAdsViewModel.errorMessage', context: context);

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$isRegisteringAdAtom =
      Atom(name: '_MyAdsViewModel.isRegisteringAd', context: context);

  @override
  bool get isRegisteringAd {
    _$isRegisteringAdAtom.reportRead();
    return super.isRegisteringAd;
  }

  @override
  set isRegisteringAd(bool value) {
    _$isRegisteringAdAtom.reportWrite(value, super.isRegisteringAd, () {
      super.isRegisteringAd = value;
    });
  }

  late final _$getUserDataAsyncAction =
      AsyncAction('_MyAdsViewModel.getUserData', context: context);

  @override
  Future<dynamic> getUserData(String userID) {
    return _$getUserDataAsyncAction.run(() => super.getUserData(userID));
  }

  late final _$getMyAdsAsyncAction =
      AsyncAction('_MyAdsViewModel.getMyAds', context: context);

  @override
  Future<dynamic> getMyAds(AppUser user) {
    return _$getMyAdsAsyncAction.run(() => super.getMyAds(user));
  }

  late final _$deleteAdAsyncAction =
      AsyncAction('_MyAdsViewModel.deleteAd', context: context);

  @override
  Future<dynamic> deleteAd(Ad ad) {
    return _$deleteAdAsyncAction.run(() => super.deleteAd(ad));
  }

  late final _$getAdAsyncAction =
      AsyncAction('_MyAdsViewModel.getAd', context: context);

  @override
  Future<dynamic> getAd(Ad adData) {
    return _$getAdAsyncAction.run(() => super.getAd(adData));
  }

  late final _$updateAdAsyncAction =
      AsyncAction('_MyAdsViewModel.updateAd', context: context);

  @override
  Future<dynamic> updateAd(Ad ad) {
    return _$updateAdAsyncAction.run(() => super.updateAd(ad));
  }

  late final _$addPhotoAsyncAction =
      AsyncAction('_MyAdsViewModel.addPhoto', context: context);

  @override
  Future<dynamic> addPhoto(File photo, Ad ad) {
    return _$addPhotoAsyncAction.run(() => super.addPhoto(photo, ad));
  }

  late final _$removePhotoAsyncAction =
      AsyncAction('_MyAdsViewModel.removePhoto', context: context);

  @override
  Future<dynamic> removePhoto(String urlPhoto) {
    return _$removePhotoAsyncAction.run(() => super.removePhoto(urlPhoto));
  }

  late final _$registerAdAsyncAction =
      AsyncAction('_MyAdsViewModel.registerAd', context: context);

  @override
  Future<dynamic> registerAd(Ad ad, List<File> photos) {
    return _$registerAdAsyncAction.run(() => super.registerAd(ad, photos));
  }

  @override
  String toString() {
    return '''
userData: ${userData},
ad: ${ad},
loadingAds: ${loadingAds},
errorMessage: ${errorMessage},
isRegisteringAd: ${isRegisteringAd}
    ''';
  }
}
