// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NewAdViewModel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NewAdViewModel on _NewAdViewModel, Store {
  late final _$errorMessageAtom =
      Atom(name: '_NewAdViewModel.errorMessage', context: context);

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
      Atom(name: '_NewAdViewModel.isRegisteringAd', context: context);

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

  late final _$registerAdAsyncAction =
      AsyncAction('_NewAdViewModel.registerAd', context: context);

  @override
  Future<dynamic> registerAd(Ad ad, List<File> photos, AppUser user) {
    return _$registerAdAsyncAction
        .run(() => super.registerAd(ad, photos, user));
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
isRegisteringAd: ${isRegisteringAd}
    ''';
  }
}
