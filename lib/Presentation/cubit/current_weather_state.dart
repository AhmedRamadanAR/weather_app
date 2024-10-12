import 'package:flutter/cupertino.dart';

import '../../Model/current_weather.dart';

@immutable
abstract class CurrentWeatherState{}
class CurrentWeatherInitial extends CurrentWeatherState {

}

class CurrentWeatherLoading extends CurrentWeatherState {

}

class CurrentWeatherLoaded extends CurrentWeatherState {
  final CurrentWeather currentWeather;

  CurrentWeatherLoaded({required this.currentWeather});


}

class CurrentWeatherError extends CurrentWeatherState {
  final String message;

  CurrentWeatherError({required this.message});

}