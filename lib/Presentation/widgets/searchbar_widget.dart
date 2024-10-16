import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget{
  final textEditingController;
  final VoidCallback onSearchClicked;
  SearchBarWidget({super.key,required this.textEditingController,required this.onSearchClicked});
  @override
  Widget build(BuildContext context) {
  return SearchBar(
      controller: textEditingController,
      onChanged: (value) =>
      textEditingController.text = value,
      leading: Padding(
          padding: EdgeInsets.all(10),
          child: Icon(Icons.search)),
      trailing: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: GestureDetector(
            child: Icon(Icons.gps_fixed),
            onTap: () {
              final cityName = textEditingController.text;
              if(cityName.isNotEmpty||cityName.length!=0){
                onSearchClicked();
              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please enter a city name'),
                  ),
                );
              }

            },
          ),
        ),
      ]);
  }

}