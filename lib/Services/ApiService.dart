import 'dart:convert';

import 'package:dio/dio.dart';

import '../Data/Model/current_weather.dart';
import '../Data/Model/five_days_weather.dart';

class WeatherApiService {
  //https://api.openweathermap.org/data/2.5/weather?lat=30.0444&lon=31.2357&units=metric&appid=9192d671013cdea2946b1d68fc9c6f25
  // https://api.openweathermap.org/data/2.5/forecast?lat=30.0444&lon=31.2357&units=metric&appid=9192d671013cdea2946b1d68fc9c6f25
  //http://api.openweathermap.org/geo/1.0/direct?q=London&limit=5&appid={API key}
  //http://api.openweathermap.org/geo/1.0/direct?q=London&limit=5&appid=9853aca6055d1f5c122be191411d006b
  //https://api.openweathermap.org/data/2.5/forecast?q=cairo&appid=9192d671013cdea2946b1d68fc9c6f25
  String baseUrl = "https://api.openweathermap.org/";
  String apiKey = "9853aca6055d1f5c122be191411d006b";
  final Dio _dio = Dio();

  WeatherApiService() {
    _dio.options.baseUrl = baseUrl;
  }

  Future<FiveDaysWeather> getFiveDaysWeatherByCity(String cityName,
      String unit) async {
    final reponse = await _getFiveDayasWeather({
      'q': cityName,
      'appid': apiKey,
      'units':unit
    });
    return reponse;
  }


  Future<FiveDaysWeather> getFiveDaysWeatherByLatLon(double lat, double lon,
      String unit) async {
    final response = await _getFiveDayasWeather({
      'lat': lat,
      'lon': lon,
      'appid': apiKey,
      'units': unit,
    });

    return response;
  }

  Future<FiveDaysWeather> _getFiveDayasWeather(
      Map<String, dynamic>queryParameter) async {
      final response = await _dio.get(
          'data/2.5/forecast', queryParameters: queryParameter);
      Map<String, dynamic> jsonData = response.data;
      return FiveDaysWeather.fromJson(jsonData);

  }

    Future<CurrentWeather> _getCurrentWeather(
        Map<String, dynamic> queryParameter) async {
      final response = await _dio.get(
          'data/2.5/weather', queryParameters: queryParameter);
      Map<String, dynamic> jsonData = response.data;
      return CurrentWeather.fromJson(jsonData);
    }

    Future<CurrentWeather> getCurrentWeatherByLatLon(double lat, double lon,
        String unit) async {
      final response = await _getCurrentWeather({
        'lat': lat,
        'lon': lon,
        'appid': apiKey,
        'units': unit,
      });

      return response;
    }

    Future<CurrentWeather> getCurrentWeatherByCity(String city,
        String unit) async {
      try {
        final response = await _getCurrentWeather({
          'q': city,
          'appid': apiKey,
          'units': unit,
        });

        return response;
      } catch (errorMessage) {
        throw errorMessage;
      }
    }

// Future<CurrentWeather> getForecast(double lat, double lon,String unit) async {
//   final response = await _dio.get(
//     'forecast',
//     queryParameters: {
//       'lat': lat,
//       'lon': lon,
//       'appid': apiKey,
//       'units': unit, // or 'imperial' for Fahrenheit
//     },
//   );
//   return response;
// }
  }
