import 'package:geolocator/geolocator.dart';
import 'package:weather_pro/Data/Model/location.dart';
import 'package:weather_pro/Data/local/database_service.dart';
import 'package:weather_pro/Presentation/providers/unit_provider.dart';
import 'package:weather_pro/Services/ApiService.dart';
import 'package:weather_pro/Services/location_service.dart';

import '../../Services/notifications_service.dart';
import '../Model/current_weather.dart';
import '../Model/five_days_weather.dart';
import '../const.dart';

class WeatherRepository {
  WeatherRepository(
      {this.notificationService,
      required this.locationService,
      required this.localStorage,
      required this.apiService});

  final WeatherApiService apiService;
  final DatabaseService localStorage;
  final LocationService locationService;
  final NotificationService? notificationService;
  late LocationModel _location;

  Future<Position?> determinePosition() {
    return locationService.determinePosition();
  }

  Future<void> getCityName(
      double latitude, double longitude, UnitProvider unit) async {
    final cityName = await locationService.getCityName(latitude, longitude);

    addLocation(LocationModel(
      lat: latitude,
      lon: longitude,
      cityName: cityName,
      unit: unit.isCelsius ? WeatherUnit.metric.name : WeatherUnit.imperial.name,
    ));
    print("test " + cityName.toString());
  }

  Future<void> _fetchLocation() async {
    _location = localStorage.getLocation();
  }

  void addLocation(LocationModel locationModel) {
    localStorage.addLocation(locationModel);
  }

  LocationModel getLocation() {
    return localStorage.getLocation();
  }

  void updateUnit(bool isCelsius) {
    localStorage.updateSwitchUnit(isCelsius);
  }

  bool getSwitchUnit() {
    return localStorage.getSwitchUnit();
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
  Future<void> deletePreferredCity()async{
await    localStorage.deletePreferedCity();
  }

  Future<void> setPreferredCity(String cityName) async {
    await localStorage.setPreferredCity(cityName);
  }

  Future<CurrentWeather> getCurrentWeatherByCity(
      String? cityName, String unit) async {
    _fetchLocation();
    print(cityName);

    localStorage.updateLocation(LocationModel(
        lat: 1.0,
        lon: 1.0,
        cityName: cityName,
        unit: _location.unit.toString()));
    return await apiService.getCurrentWeatherByCity(
        cityName ?? _location.cityName.toString(), unit);
  }

  void setUpNotifcations() async {
    await notificationService?.initNotifications();
  }

  void sendAlerts(double temperature) async {
    await notificationService?.initNotifications();
    final isCelsius = getSwitchUnit();
    final sendAlert = getAlert();
    if (!isCelsius) {
      temperature = (temperature - 32) * 5 / 9;
    }
    if (temperature < 30 && sendAlert) {
      notificationService?.showNotification(
        0,
        'Temperature Alert',
        'The current temperature is below 30 degrees!',
      );
    }
  }

  Future<CurrentWeather> getCurrentWeatherByLatLon(String unit) async {
    await _fetchLocation();
    return await apiService.getCurrentWeatherByLatLon(
        _location.lat!.toDouble(), _location.lon!.toDouble(), unit);
  }

  Future<FiveDaysWeather> getFiveDaysWeather(String unit) async {
    await _fetchLocation();
    return await apiService.getFiveDaysWeatherByLatLon(
        _location.lat!.toDouble(), _location.lon!.toDouble(), unit);
  }

  Future<FiveDaysWeather> getFiveDaysWeatherByCity(
      String city, String unit) async {
    await _fetchLocation();
    localStorage.updateLocation(LocationModel(
        lat: 1.0, lon: 1.0, cityName: city, unit: _location.unit.toString()));
    return await apiService.getFiveDaysWeatherByCity(city, unit);
  }

  void updateSwitchTheme(bool isDarkMode) {
    localStorage.updateSwitchTheme(isDarkMode);
  }

  bool getSwitchTheme() {
    return localStorage.getSwitchTheme();
  }

  void updateAlert(bool value) {
    localStorage.updateAlert(value);
  }

  bool getAlert() {
    return localStorage.getAlert();
  }
}
