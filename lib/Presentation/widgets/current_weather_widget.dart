import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_pro/Data/Model/current_weather.dart';

class CurrentWeatherWidget extends StatelessWidget {
  CurrentWeatherWidget({required this.currentWeather});

  CurrentWeather currentWeather;
  @override
  Widget build(BuildContext context) {
    print(currentWeather!.main!.temp.toString() + "°");

    return Column(mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          currentWeather!.main!.temp.toString() + "°",
          style: TextStyle(color: Colors.white, fontSize: 42),
        ),
        Row( mainAxisSize: MainAxisSize.max,children: [ Text(
          'max / ' +
              currentWeather.main!.temp_max.toString() +
              "°" +
              ' min /' +
              currentWeather.main!.temp_min.toString() +
              "°",
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
