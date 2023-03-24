import 'package:commercialize/view/NewAdView.dart';
import 'package:commercialize/view/HomeView.dart';
import 'package:commercialize/view/LoginView.dart';
import 'package:commercialize/view/MyAds.dart';
import 'package:commercialize/view/RegisterUserView.dart';
import 'package:flutter/material.dart';

class ScreenRoutes{
  static const String LOGIN_ROUTE = "/login";
  static const String REGISTER_ROUTE = "/register";
  static const String HOME_ROUTE = "/home";
  static const String MY_ADS_ROUTE = "/my-ads";
  static const String CREATE_AD_ROUTE = "/create-ad";

  static Route<dynamic> generateRoutes(RouteSettings setting) {
    switch (setting.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => HomeView());

      case LOGIN_ROUTE:
        return MaterialPageRoute(builder: (_) => LoginView());

      case REGISTER_ROUTE:
        return MaterialPageRoute(builder: (_) => RegisterUserView());

      case HOME_ROUTE:
        return MaterialPageRoute(builder: (_) => HomeView());

      case MY_ADS_ROUTE:
        return MaterialPageRoute(builder: (_) => MyAds());

      case CREATE_AD_ROUTE:
        return MaterialPageRoute(builder: (_) => NewAdView());

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