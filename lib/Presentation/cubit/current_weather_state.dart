import 'package:flutter/cupertino.dart';

import '../../Data/Model/current_weather.dart';
import '../../Data/Model/five_days_weather.dart';


@immutable
abstract class WeatherState  {
const WeatherState();


}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final CurrentWeather? currentWeather;
  final FiveDaysWeather? fiveDaysWeather;

  const WeatherLoaded({this.currentWeather, this.fiveDaysWeather});


}

class WeatherError extends WeatherState {
  final String message;

  const WeatherError({required this.message});


}