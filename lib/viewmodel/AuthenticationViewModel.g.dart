// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AuthenticationViewModel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthenticationViewModel on _AuthenticationViewModelBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_AuthenticationViewModelBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$signingUpAtom =
      Atom(name: '_AuthenticationViewModelBase.signingUp', context: context);

  @override
  bool get signingUp {
    _$signingUpAtom.reportRead();
    return super.signingUp;
  }

  @override
  set signingUp(bool value) {
    _$signingUpAtom.reportWrite(value, super.signingUp, () {
      super.signingUp = value;
    });
  }

  late final _$userLoggedAtom =
      Atom(name: '_AuthenticationViewModelBase.userLogged', context: context);

  @override
  AppUser? get userLogged {
    _$userLoggedAtom.reportRead();
    return super.userLogged;
  }

  @override
  set userLogged(AppUser? value) {
    _$userLoggedAtom.reportWrite(value, super.userLogged, () {
      super.userLogged = value;
    });
  }

  late final _$messageErrorAtom =
      Atom(name: '_AuthenticationViewModelBase.messageError', context: context);

  @override
  String get messageError {
    _$messageErrorAtom.reportRead();
    return super.messageError;
  }

  @override
  set messageError(String value) {
    _$messageErrorAtom.reportWrite(value, super.messageError, () {
      super.messageError = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('_AuthenticationViewModelBase.login', context: context);

  @override
  Future<void> login(AppUser user) {
    return _$loginAsyncAction.run(() => super.login(user));
  }

  late final _$checkLoggedUserAsyncAction = AsyncAction(
      '_AuthenticationViewModelBase.checkLoggedUser',
      context: context);

  @override
  Future<void> checkLoggedUser() {
    return _$checkLoggedUserAsyncAction.run(() => super.checkLoggedUser());
  }

  late final _$logoutAsyncAction =
      AsyncAction('_AuthenticationViewModelBase.logout', context: context);

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$registerUserAsyncAction = AsyncAction(
      '_AuthenticationViewModelBase.registerUser',
      context: context);

  @override
  Future<void> registerUser(AppUser user) {
    return _$registerUserAsyncAction.run(() => super.registerUser(user));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
signingUp: ${signingUp},
userLogged: ${userLogged},
messageError: ${messageError}
    ''';
  }
}
