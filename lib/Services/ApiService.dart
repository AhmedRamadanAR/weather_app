import 'package:dio/dio.dart';
import 'package:weather_pro/Model/current_weather.dart';

import '../Model/five_days_weather.dart';

class WeatherApiService {
  //https://api.openweathermap.org/data/2.5/weather?lat=30.0444&lon=31.2357&units=metric&appid=9192d671013cdea2946b1d68fc9c6f25
  // https://api.openweathermap.org/data/2.5/forecast?lat=30.0444&lon=31.2357&units=metric&appid=9192d671013cdea2946b1d68fc9c6f25
  //http://api.openweathermap.org/geo/1.0/direct?q=London&limit=5&appid={API key}
  //http://api.openweathermap.org/geo/1.0/direct?q=London&limit=5&appid=9853aca6055d1f5c122be191411d006b
  String baseUrl = "https://api.openweathermap.org/";
  String apiKey = "9853aca6055d1f5c122be191411d006b";
  final Dio _dio = Dio();

  WeatherApiService() {
    _dio.options.baseUrl = baseUrl;
  }
  //
  // Future <Location> getLatLonFromCity() async {
  //   try {
  //     final response=await _dio.get('path')
  //   }
  //   catch {}
  // }

  Future<FiveDaysWeather> getFiveDaysWeatherByLatLon(double lat, double lon,
      String unit) async {
    try {
      final response = await _dio.get('data/2.5/forecast', queryParameters: {
        'lat': lat,
        'lon': lon,
        'appid': apiKey,
        'units': unit,
      });
      Map<String, dynamic> jsonData = response.data;
      return FiveDaysWeather.fromJson(jsonData);
    } catch (error) {
      // Handle the error, e.g., log it or throw a custom exception
      print('Error fetching five days weather: $error');
      throw error; // Re-throw the error to be caught by the Cubit
    }
  }

  Future<CurrentWeather> _getWeather(
      Map<String, dynamic> queryParameter) async {
    final response = await _dio.get('data/2.5/weather', queryParameters: queryParameter);
    Map<String, dynamic> jsonData = response.data;
    return CurrentWeather.fromJson(jsonData);
  }

  Future<CurrentWeather> getCurrentWeatherByLatLon(double lat, double lon,
      String unit) async {
    final response = await _getWeather({
      'lat': lat,
      'lon': lon,
      'appid': apiKey,
      'units': unit,
    });

    return response;
  }

  Future<CurrentWeather> getCurrentWeatherByCity(String city,
      String unit) async {
    final response = await _getWeather({
      'q': city,
      'appid': apiKey,
      'units': unit,
    });

    return response;
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
