import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_pro/Presentation/providers/unit_provider.dart';

import '../../Data/const.dart';
import '../cubit/current_weather_cubit.dart';

class SearchBarWidget extends StatelessWidget {
  final textEditingController;
  final VoidCallback onSearchClicked;
 final UnitProvider unitProvider;
  const SearchBarWidget(
      {super.key,
      required this.textEditingController,
      required this.onSearchClicked, required this.unitProvider});


  @override
  Widget build(BuildContext context) {
    return SearchBar(
        onSubmitted: (value) {
          final cityName = textEditingController.text;
          if (cityName.isNotEmpty || cityName.length != 0) {
            onSearchClicked();
            FocusScope.of(context).unfocus();

          } else{
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please enter a city name'),
              ),
            );
          }
        },
        controller: textEditingController,
        onChanged: (value) => textEditingController.text = value,
        leading: const Padding(
            padding: EdgeInsets.all(10), child: Icon(Icons.search)),
        trailing: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              child: const Icon(Icons.gps_fixed),
              onTap: () {
                var position = context.read<WeatherCubit>().determinePosition();
                if (position != null) {
                  var lat = position.latitude.toDouble();
                  var lon = position.longitude.toDouble();
                     context.read<WeatherCubit>().getCityNameFromLatLon(lat, lon, unitProvider).then((value){
                    context.read<WeatherCubit>().getWeatherData(unit: unitProvider.isCelsius ? WeatherUnit.metric.name : WeatherUnit.imperial.name);
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Could not determine your location. Please enable GPS'),
                    ),);
                }
              },
            ),
          ),
        ]);
  }
}
