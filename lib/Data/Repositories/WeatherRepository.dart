import 'package:geolocator/geolocator.dart';
import 'package:weather_pro/Data/Model/location.dart';
import 'package:weather_pro/Data/local/database_service.dart';
import 'package:weather_pro/Services/ApiService.dart';
import 'package:weather_pro/Services/location_service.dart';

import '../Model/current_weather.dart';
import '../Model/five_days_weather.dart';

class WeatherRepository {
  WeatherRepository(
      { required this.locationService, required this.localStorage, required this.apiService});

  final WeatherApiService apiService;
  final DatabaseService localStorage;
  final LocationService locationService;
  late LocationModel _location;

  Future<Position?> determinePosition() {
    return locationService.determinePosition();
  }

  Future<String?> getCityName(double latitude, double longitude) {
    return locationService.getCityName(latitude, longitude);
  }



  Future<void> _fetchLocation() async {
    _location = localStorage.getLocation();
  }

  void addLocation(LocationModel locationModel) {
    localStorage.addLocation(locationModel);
  }

  LocationModel getLocation() {
    print("lat :" + localStorage
        .getLocation()
        .lat
        .toString() + "long" + localStorage
        .getLocation()
        .lon
        .toString() + 'unit' + localStorage
        .getLocation()
        .unit
        .toString());
    print("city "+ _location.cityName.toString());
    return localStorage.getLocation();
  }
  void updateUnit(bool isCelsius){
    localStorage.updateSwitch(isCelsius);
  }
  bool getUnit(){
  return   localStorage.getSwitch();
  }

  void updatLocation(LocationModel locationModel) {
    localStorage.updateLocation(locationModel);
  }
  Future<void> updatePreferredCity(String cityName) async {
    await localStorage.setPreferredCity(cityName);
  }


  Future<String?> getPreferredCity() async {
    return await localStorage.getPreferredCity();
  }
  Future<void> setPreferredCity(String cityName) async {
    await localStorage.setPreferredCity(cityName);
  }
  Future<CurrentWeather> getCurrentWeatherByCity(String? cityName, String unit) async {
    _fetchLocation();
    print(cityName);
    localStorage.updateLocation(
        LocationModel(lat: 1.0, lon: 1.0, cityName: cityName, unit: _location.unit.toString()));
    return await apiService.getCurrentWeatherByCity(
        cityName??_location.cityName.toString(), unit);
  }

  Future<CurrentWeather> getCurrentWeatherByLatLon(String unit) async {
    await _fetchLocation();
    return await apiService.getCurrentWeatherByLatLon(
        _location.lat!.toDouble(), _location.lon!.toDouble(),
       unit);
  }

  Future<FiveDaysWeather> getFiveDaysWeather(String unit) async {
    await _fetchLocation();
    return await apiService.getFiveDaysWeatherByLatLon(
        _location.lat!.toDouble(), _location.lon!.toDouble(),
        unit);
  }


}

