import 'package:flutter/material.dart';
import 'package:commercialize/model/Ad.dart';

class HomeAdItemGridView extends StatelessWidget {
  final Ad ad;
  final Function() showDetails;
  const HomeAdItemGridView({required this.ad, required this.showDetails, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showDetails,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey)
        ),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Image.network(ad.photos[0], fit: BoxFit.contain,),
            ),
            const SizedBox(height: 5,),
            Text(ad.title, maxLines: 2, textAlign: TextAlign.center,),
            const SizedBox(height: 5,),
            Text(ad.price, maxLines: 1, textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}
