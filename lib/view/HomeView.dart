import 'package:commercialize/helper/ScreenRoutes.dart';
import 'package:commercialize/model/Ad.dart';
import 'package:commercialize/res/app_strings.dart';
import 'package:commercialize/viewmodel/HomeViewModel.dart';
import 'package:commercialize/widget/DropdownFilter.dart';
import 'package:commercialize/widget/HomeAdItemGridView.dart';
import 'package:flutter/material.dart';
import 'package:commercialize/viewmodel/AuthenticationViewModel.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  late AuthenticationViewModel _authViewModel;
  late HomeViewModel _homeViewModel;
  final List<String> _menuItensUserLogged = [
    AppStrings.advertsMenuItem,
    AppStrings.profileMenuItem,
    AppStrings.logoutMenuItem
  ];
  final List<String> _menuItensUserNotLogged = [AppStrings.loginMenuItem];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _authViewModel.checkLoggedUser();
      await _homeViewModel.getAllAds();
    });
  }

  @override
  Widget build(BuildContext context) {
    _authViewModel = Provider.of<AuthenticationViewModel>(context);
    _homeViewModel = Provider.of<HomeViewModel>(context);
    return
      Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.appName),
          actions: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.search, color: Colors.white,)),
            PopupMenuButton<String>(
                onSelected: _selectedMenuItem,
                itemBuilder: (context){
                  return (_authViewModel.userLogged==null)
                      ? _menuItensUserNotLogged.map((String item){
                    return PopupMenuItem(value: item, child: Text(item),);
                  }).toList()
                      : _menuItensUserLogged.map((String item){
                    return PopupMenuItem(value: item, child: Text(item),);
                  }).toList();
                }
            )
          ],
        ),
        body: Observer(builder: (_){
          return Container(
              padding: const EdgeInsets.all(16),
              child: (_homeViewModel.isLoadingAds)
                  ? const Center(child: CircularProgressIndicator(),)
                  :
              Column(
                children: [
                  DropdownFilter(),
                  SizedBox(height: 5,),
                  Expanded(child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8
                      ),
                      itemCount: _homeViewModel.allAds.length,
                      itemBuilder: (BuildContext context, int index){
                        Ad ad = _homeViewModel.allAds[index];
                        return HomeAdItemGridView(ad: ad, showDetails: (){});
                      }
                  ))
                ],
              )

          );
        })
      );
  }

  _selectedMenuItem(String selectedItem) async {
    switch (selectedItem) {
      case AppStrings.profileMenuItem:
        //Navigator.pushNamed(context, ScreenRoutes.USER_PROFILE_ROUTE, arguments: _currentUser);
        break;
      case AppStrings.logoutMenuItem:
        // await _authViewModel.logout();
        Navigator.pushReplacementNamed(context, ScreenRoutes.LOGIN_ROUTE);
        break;

      case AppStrings.advertsMenuItem:
        Navigator.pushNamed(context, ScreenRoutes.MY_ADS_ROUTE);
        break;

      case AppStrings.loginMenuItem:
        Navigator.pushReplacementNamed(context, ScreenRoutes.LOGIN_ROUTE);
    }
  }

}
