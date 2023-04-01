import 'package:carousel_slider/carousel_slider.dart';
import 'package:commercialize/res/app_colors.dart';
import 'package:commercialize/res/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:commercialize/model/Ad.dart';

class AdDestails extends StatelessWidget {
  final Ad ad;
  const AdDestails({required this.ad, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.adDetails),
        ),
        body:
            Container(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                        items: ad.photos
                            .map((item) => Container(
                                  padding: const EdgeInsets.all(5),
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  child: GestureDetector(
                                    child: Center(
                                      child:
                                      Image.network(item, fit: BoxFit.cover),
                                    ),
                                    onTap: () {},
                                  ),
                                ))
                            .toList(),
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height * 0.33,
                        )),
                    const Divider(),
                    Text(
                      ad.price,
                      style: const TextStyle(
                          fontSize: 36, color: AppColors.primaryColor, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      ad.title,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      "${AppStrings.productDescription}:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(ad.description),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      "${AppStrings.phoneText}:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(ad.phone),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      "${AppStrings.categoryText}:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(ad.category),
                    const SizedBox(height: 16),
                    const Text(
                      "${AppStrings.stateText}:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(ad.state),
                  ],
                ),
              ),
            ),


    );
  }
}
