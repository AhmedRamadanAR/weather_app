
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../Model/current_weather.dart';
import '../Model/five_days_weather.dart';


class WeatherApiService {

  String baseUrl = "https://api.openweathermap.org/";
  String apiKey = dotenv.env['API_KEY']!;
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
        rethrow;
      }
    }

  }
