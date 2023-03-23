import 'package:commercialize/view/HomeView.dart';
import 'package:commercialize/view/LoginView.dart';
import 'package:commercialize/view/RegisterUserView.dart';
import 'package:flutter/material.dart';

class ScreenRoutes{
  static const String LOGIN_ROUTE = "/login";
  static const String REGISTER_ROUTE = "/register";
  static const String HOME_ROUTE = "/home";

  static Route<dynamic> generateRoutes(RouteSettings setting) {
    switch (setting.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => LoginView());

      case LOGIN_ROUTE:
        return MaterialPageRoute(builder: (_) => LoginView());

      case REGISTER_ROUTE:
        return MaterialPageRoute(builder: (_) => RegisterUserView());

      case HOME_ROUTE:
        return MaterialPageRoute(builder: (_) => HomeView());

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