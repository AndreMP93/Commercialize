import 'package:commercialize/model/AppUser.dart';
import 'package:commercialize/res/app_colors.dart';
import 'package:commercialize/res/app_strings.dart';
import 'package:commercialize/viewmodel/AuthenticationViewModel.dart';
import 'package:commercialize/widget/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../helper/ScreenRoutes.dart';
import 'package:mobx/mobx.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // late final AuthenticationViewModel _authViewModel;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticationViewModel _authViewModel = Provider.of<AuthenticationViewModel>(context);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.store,
                  size: MediaQuery.of(context).size.width * 0.2,
                  color: AppColors.primaryColor,
                ),
                const Text(
                  AppStrings.appName,
                  style: TextStyle(
                      fontSize: 22,
                      color: AppColors.primaryColor
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: CustomTextField(
                      labelText: AppStrings.emailLabel,
                      controller: _emailController,
                      icon: const Icon(Icons.email),
                      keyboardType: TextInputType.emailAddress,
                    )
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: CustomTextField(
                      labelText: AppStrings.passwordLabel,
                      controller: _passwordController,
                      icon: const Icon(Icons.lock),
                      isPassword: true,
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: Observer(
                    builder: (_) => TextButton(
                      onPressed: ()async{
                        AppUser user = AppUser(email: _emailController.text, password: _passwordController.text);
                        await _authViewModel.login([user]);
                        if(_authViewModel.isLoading){
                          Navigator.pushReplacementNamed(context, ScreenRoutes.HOME_ROUTE);
                        }
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: const EdgeInsets.fromLTRB(
                              32, 16, 32, 16),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(32))
                      ),
                      child: Text(
                        AppStrings.loginButton.toUpperCase(),
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(
                        context, ScreenRoutes.REGISTER_ROUTE);
                  },
                  child: const Text(
                    AppStrings.createAnAccountLabel,
                    style: TextStyle(
                        fontSize: 18,
                        color: AppColors.primaryColor
                    ),
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }

  Future _login() async{

  }
}
