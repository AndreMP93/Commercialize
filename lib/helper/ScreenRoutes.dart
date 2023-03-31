// ignore_for_file: constant_identifier_names

import 'package:commercialize/model/Ad.dart';
import 'package:commercialize/view/AdDestails.dart';
import 'package:commercialize/view/DetailsMyAds.dart';
import 'package:commercialize/view/NewAdView.dart';
import 'package:commercialize/view/HomeView.dart';
import 'package:commercialize/view/LoginView.dart';
import 'package:commercialize/view/MyAds.dart';
import 'package:commercialize/view/RegisterUserView.dart';
import 'package:commercialize/view/SelectedImageView.dart';
import 'package:flutter/material.dart';

class ScreenRoutes{
  static const String LOGIN_ROUTE = "/login";
  static const String REGISTER_ROUTE = "/register";
  static const String HOME_ROUTE = "/home";
  static const String MY_ADS_ROUTE = "/my-ads";
  static const String CREATE_AD_ROUTE = "/create-ad";
  static const String DETAILS_MY_ADS_ROUTE = "/details-my-ads";
  static const String SELECTED_IMAGE_ROUTE = "/selected-image";
  static const String AD_DETAILS_ROUTE = "/ad-details";

  static Route<dynamic> generateRoutes(RouteSettings setting) {
    switch (setting.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const HomeView());

      case LOGIN_ROUTE:
        return MaterialPageRoute(builder: (_) => const LoginView());

      case REGISTER_ROUTE:
        return MaterialPageRoute(builder: (_) => const RegisterUserView());

      case HOME_ROUTE:
        return MaterialPageRoute(builder: (_) => const HomeView());

      case MY_ADS_ROUTE:
        return MaterialPageRoute(builder: (_) => MyAds());

      case CREATE_AD_ROUTE:
        return MaterialPageRoute(builder: (_) => const NewAdView());
        
      case DETAILS_MY_ADS_ROUTE:
        final Object? args = setting.arguments;
        final parametro = args as Ad;
        return MaterialPageRoute(builder: (_) => DetailsMyAds(ad: parametro,));

      case SELECTED_IMAGE_ROUTE:
        final Object? args = setting.arguments;
        final parametro = args as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => SelectedImageView(ad: parametro["ad"], urlPhoto: parametro["urlPhoto"]));

      case AD_DETAILS_ROUTE:
        final Object? args = setting.arguments;
        final parametro = args as Ad;
        return MaterialPageRoute(builder: (_) => AdDestails(ad: parametro,));
      default:
        return _erroRota();
    }
  }

  static Route<dynamic> _erroRota(){
    return MaterialPageRoute(builder: (_)=>Scaffold(
      appBar: AppBar(
        title: const Text("Tela Não Encontrada!"),
      ),
      body: const Center(
        child: Text("Tela Não Encontrada!"),
      ),
    ));

  }

}