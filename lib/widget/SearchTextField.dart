import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({required this.contoller, required this.cancelSearch, required this.startSearch, Key? key}) : super(key: key);

  final TextEditingController contoller;
  final Function() cancelSearch;
  final Function() startSearch;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              autofocus: true,
              controller: contoller,
              onSubmitted: (value){startSearch();},
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                hintText: "Pesquisar",
                prefixIcon: IconButton(onPressed: cancelSearch, icon: Icon(Icons.arrow_forward_ios_rounded)),
                suffixIcon: IconButton(onPressed: startSearch, icon: Icon(Icons.search),),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32)),
              ),
            )
          ],
        ),
    );
  }
}
