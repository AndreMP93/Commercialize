import 'package:commercialize/helper/ScreenRoutes.dart';
import 'package:commercialize/model/Ad.dart';
import 'package:commercialize/res/app_strings.dart';
import 'package:commercialize/viewmodel/HomeViewModel.dart';
import 'package:commercialize/widget/DropdownFilter.dart';
import 'package:commercialize/widget/HomeAdItemGridView.dart';
import 'package:commercialize/widget/SearchTextField.dart';
import 'package:flutter/material.dart';
import 'package:commercialize/viewmodel/AuthenticationViewModel.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {

  late AuthenticationViewModel _authViewModel;
  late HomeViewModel _homeViewModel;
  final List<String> _menuItensUserLogged = [
    AppStrings.advertsMenuItem,
    AppStrings.profileMenuItem,
    AppStrings.logoutMenuItem
  ];
  final List<String> _menuItensUserNotLogged = [AppStrings.loginMenuItem];
  final TextEditingController _searchContoller = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _authViewModel.checkLoggedUser();
      await _homeViewModel.getAllAds();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _authViewModel = Provider.of<AuthenticationViewModel>(context);
    _homeViewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Icon(Icons.store),//const Text(AppStrings.appName),
          actions: [
            (_isSearching) ? SearchTextField(contoller: _searchContoller, startSearch: _searchProduct, cancelSearch: _stopSearch,) : Container(),
            (_isSearching )? Container() : IconButton(
                onPressed: () {
                  setState(() {
                    _isSearching = true;
                  });
                  _animationController.forward();
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                )),
            PopupMenuButton<String>(
                onSelected: _selectedMenuItem,
                itemBuilder: (context) {
                  return (_authViewModel.userLogged == null)
                      ? _menuItensUserNotLogged.map((String item) {
                          return PopupMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList()
                      : _menuItensUserLogged.map((String item) {
                          return PopupMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList();
                })
          ],
        ),
        body: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                DropdownFilter(
                  onChangedState: _onChangedStateDropdown,
                  onChangedCategory: _onChangedCategoryDropdown,
                  isForFiltering: true,
                ),
                const SizedBox(
                  height: 5,
                ),
                Observer(builder: (_) {
                  return (_homeViewModel.isLoadingAds)
                      ? const Expanded(
                          child: Center(
                          child: CircularProgressIndicator(),
                        ))
                      : Expanded(
                          child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
                              itemCount: _homeViewModel.allAds.length,
                              itemBuilder: (BuildContext context, int index) {
                                Ad ad = _homeViewModel.allAds[index];
                                return HomeAdItemGridView(ad: ad, showDetails: () {
                                  Navigator.pushNamed(context, ScreenRoutes.AD_DETAILS_ROUTE, arguments: ad);
                                });
                              }));
                })
              ],
            ))
        //})
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

  Future _onChangedStateDropdown(String stateSelected) async {
    _homeViewModel.stateSelected = stateSelected;
    await _homeViewModel.applyFilter();
  }

  Future _onChangedCategoryDropdown(String categorySelected) async {
    _homeViewModel.categorySelected = categorySelected;
    await _homeViewModel.applyFilter();
  }

  void _stopSearch() async {
    _animationController.reverse().then((value) {
      setState(() {
        _isSearching = false;
        _searchContoller.clear();
        _homeViewModel.keyword = null;
      });
    });
    await _homeViewModel.applyFilter();
  }

  Future _searchProduct() async {
    _homeViewModel.keyword = _searchContoller.text;
    await _homeViewModel.applyFilter();
  }
}
