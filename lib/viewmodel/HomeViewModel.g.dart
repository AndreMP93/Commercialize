// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HomeViewModel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewModel on _HomeViewModel, Store {
  late final _$stateSelectedAtom =
      Atom(name: '_HomeViewModel.stateSelected', context: context);

  @override
  String get stateSelected {
    _$stateSelectedAtom.reportRead();
    return super.stateSelected;
  }

  @override
  set stateSelected(String value) {
    _$stateSelectedAtom.reportWrite(value, super.stateSelected, () {
      super.stateSelected = value;
    });
  }

  late final _$categorySelectedAtom =
      Atom(name: '_HomeViewModel.categorySelected', context: context);

  @override
  String get categorySelected {
    _$categorySelectedAtom.reportRead();
    return super.categorySelected;
  }

  @override
  set categorySelected(String value) {
    _$categorySelectedAtom.reportWrite(value, super.categorySelected, () {
      super.categorySelected = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_HomeViewModel.errorMessage', context: context);

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

  late final _$isLoadingAdsAtom =
      Atom(name: '_HomeViewModel.isLoadingAds', context: context);

  @override
  bool get isLoadingAds {
    _$isLoadingAdsAtom.reportRead();
    return super.isLoadingAds;
  }

  @override
  set isLoadingAds(bool value) {
    _$isLoadingAdsAtom.reportWrite(value, super.isLoadingAds, () {
      super.isLoadingAds = value;
    });
  }

  late final _$getAllAdsAsyncAction =
      AsyncAction('_HomeViewModel.getAllAds', context: context);

  @override
  Future<void> getAllAds([String? state, String? category]) {
    return _$getAllAdsAsyncAction.run(() => super.getAllAds(state, category));
  }

  late final _$applyFilterAsyncAction =
      AsyncAction('_HomeViewModel.applyFilter', context: context);

  @override
  Future<void> applyFilter() {
    return _$applyFilterAsyncAction.run(() => super.applyFilter());
  }

  @override
  String toString() {
    return '''
stateSelected: ${stateSelected},
categorySelected: ${categorySelected},
errorMessage: ${errorMessage},
isLoadingAds: ${isLoadingAds}
    ''';
  }
}
