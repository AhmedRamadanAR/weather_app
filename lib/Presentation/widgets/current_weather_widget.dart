import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_pro/Data/Model/current_weather.dart';

import '../providers/unit_provider.dart';

class CurrentWeatherWidget extends StatelessWidget {
  CurrentWeatherWidget({required this.currentWeather});

  CurrentWeather currentWeather;
  @override
  Widget build(BuildContext context) {
    var unitProvider = Provider.of<UnitProvider>(context);

    print(currentWeather!.main!.temp.toString() + "°");

    return Column(mainAxisSize: MainAxisSize.min,
      children: [

        Text("city : "+currentWeather.name.toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.black),),
        Text(
          currentWeather!.main!.temp.toString() + "°",
          style: TextStyle(color: Colors.white, fontSize: 42),
        ),
        Row( mainAxisSize: MainAxisSize.max,children: [

          Text(
            'max / ${currentWeather.main!.temp_max}${unitProvider.isCelsius ? "°C" : "°F"} '
                'min / ${currentWeather.main!.temp_min}${unitProvider.isCelsius ? "°C" : "°F"}',
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),SizedBox(width: 20,),Text(currentWeather.main!.feels_like.toString()+ "°")],),

        SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
          //  children: [Icon(Icons.)],
          ),
        )
      ],
    );
  }
}
