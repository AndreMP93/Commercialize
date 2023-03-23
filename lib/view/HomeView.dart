import 'package:commercialize/res/app_strings.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final List<String> _menuItems = <String>[AppStrings.profileMenuItem, AppStrings.logoutMenuItem];
  
  @override
  Widget build(BuildContext context) {
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
    }
  }
}
