import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_pro/Data/Model/current_weather.dart';

class CurrentWeatherWidget extends StatelessWidget {
  CurrentWeatherWidget({required this.currentWeather});

  CurrentWeather? currentWeather;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          currentWeather!.main!.temp.toString() + "°",
          style: TextStyle(color: Colors.white, fontSize: 42),
        ),
        Row(children: [ Text(
          'max / ' +
              currentWeather!.main!.temp_max!.toString() +
              "°" +
              ' min /' +
              currentWeather!.main!.temp.toString() +
              "°",
          style: TextStyle(color: Colors.white, fontSize: 42),
        ),SizedBox(width: 20,),Text(currentWeather!.main!.feelsLike!.toString()+ "°")],),

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
