import 'package:weather_pro/Model/current_weather.dart';
import 'package:weather_pro/Services/ApiService.dart';

class WeatherRepository{
  WeatherRepository({required this.apiService});
  final WeatherApiService apiService;

  Future<CurrentWeather> getCurrentWeatherByCity(String city,String unit) async{
   return  await apiService.getCurrentWeatherByCity(city, unit);

  }
  Future<CurrentWeather> getCurrentWeatherByLatLon(double lat,double lon,String unit) async{
    return  await apiService.getCurrentWeatherByLatLon(lat,lon,unit);

  }
}