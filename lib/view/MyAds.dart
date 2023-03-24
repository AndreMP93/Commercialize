import 'package:commercialize/helper/ScreenRoutes.dart';
import 'package:commercialize/res/app_strings.dart';
import 'package:flutter/material.dart';

class MyAds extends StatelessWidget {
  const MyAds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.myAdsTitle),
      ),

      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: (){
          Navigator.pushNamed(context, ScreenRoutes.CREATE_AD_ROUTE);
        },
      ),
    );
  }
}
