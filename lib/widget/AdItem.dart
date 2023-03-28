import 'package:flutter/material.dart';

class AdItem extends StatelessWidget {
  final Text title;
  final Text price;
  final String urlProductPhoto;
  final Function() showAdDetails;
  final Function deleteAd;
  const AdItem({
    required this.title,
    required this.price,
    required this.urlProductPhoto,
    required this.showAdDetails,
    required this.deleteAd,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showAdDetails,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: Image.network(urlProductPhoto, width: 120, height: 120,),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title,
                      price,
                    ],),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.all(10),
                ),
                onPressed: deleteAd(),
                child: Icon(Icons.delete, color: Colors.white,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
