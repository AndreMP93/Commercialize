import 'package:commercialize/res/app_strings.dart';
import 'package:commercialize/viewmodel/AuthenticationViewModel.dart';
import 'package:commercialize/viewmodel/NewAdViewModel.dart';
import 'package:commercialize/viewmodel/RegisterUserViewModel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:commercialize/res/theme.dart';
import 'package:provider/provider.dart';
import 'helper/ScreenRoutes.dart';
//flutter packages pub run build_runner build
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthenticationViewModel>(create: (_) => AuthenticationViewModel()),
          Provider<RegisterUserViewModel>(create: (_)=> RegisterUserViewModel(),),
          Provider<NewAdViewModel>(create: (_) => NewAdViewModel())
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        theme: CustomTheme.lightTheme,
        initialRoute: "/",
        onGenerateRoute: ScreenRoutes.generateRoutes,
      ),
    );
  }
}
