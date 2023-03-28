// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MyAdsViewModel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MyAdsViewModel on _MyAdsViewModel, Store {
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

  late final _$updateAdAsyncAction =
      AsyncAction('_MyAdsViewModel.updateAd', context: context);

  @override
  Future<dynamic> updateAd(Ad ad) {
    return _$updateAdAsyncAction.run(() => super.updateAd(ad));
  }

  @override
  String toString() {
    return '''
loadingAds: ${loadingAds},
errorMessage: ${errorMessage}
    ''';
  }
}
