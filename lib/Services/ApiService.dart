import 'package:dio/dio.dart';
import 'package:weather_pro/Model/current_weather.dart';

class WeatherApiService {
  //https://api.openweathermap.org/data/2.5/weather?lat=30.0444&lon=31.2357&units=metric&appid=9192d671013cdea2946b1d68fc9c6f25
  String baseUrl = "https://api.openweathermap.org/data/2.5/";
  String apiKey = "9192d671013cdea2946b1d68fc9c6f25";
  final Dio _dio = Dio();

  WeatherApiService() {
    _dio.options.baseUrl = baseUrl;
  }

  Future<CurrentWeather> _getWeather(
      Map<String, dynamic> queryParameter) async {
    final response = await _dio.get('weather', queryParameters: queryParameter);
    Map<String, dynamic> jsonData = response.data;
    return CurrentWeather.fromJson(jsonData);
  }

  Future<CurrentWeather> getCurrentWeatherByLatLon(
      double lat, double lon, String unit) async {
    final response =  await _getWeather({
      'lat': lat,
      'lon': lon,
      'appid': apiKey,
      'units': unit,
    });

    return response;
  }

  Future<CurrentWeather> getCurrentWeatherByCity(
      String city, String unit) async {
    final response =  await _getWeather({
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
