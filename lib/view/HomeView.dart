import 'package:commercialize/helper/ScreenRoutes.dart';
import 'package:commercialize/res/app_strings.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  List<String> _menuItems = <String>[];


  @override
  Widget build(BuildContext context) {
    _checkLoggedUser();
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        actions: [
          PopupMenuButton<String>(
              onSelected: _selectedMenuItem,
              itemBuilder: (context){
                return _menuItems.map((String item){
                  return PopupMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList();
              }
          )
        ],
      ),
      body: Container(),
    );
  }

  _selectedMenuItem(String selectedItem) async {
    switch (selectedItem) {
      case AppStrings.profileMenuItem:
        //Navigator.pushNamed(context, ScreenRoutes.USER_PROFILE_ROUTE, arguments: _currentUser);
        break;
      case AppStrings.logoutMenuItem:
        // await _authViewModel.logout();
        // Navigator.pushReplacementNamed(context, ScreenRoutes.LOGIN_ROUTE);
        break;

      case AppStrings.advertsMenuItem:
        Navigator.pushNamed(context, ScreenRoutes.MY_ADS_ROUTE);
        break;

      case AppStrings.loginMenuItem:
        Navigator.pushReplacementNamed(context, ScreenRoutes.LOGIN_ROUTE);
    }
  }

  Future _checkLoggedUser() async{
    var checked = true;
    if(checked){
      _menuItems = [AppStrings.advertsMenuItem, AppStrings.profileMenuItem, AppStrings.logoutMenuItem];
    }else{
      _menuItems = [AppStrings.loginMenuItem];
    }
  }
}
