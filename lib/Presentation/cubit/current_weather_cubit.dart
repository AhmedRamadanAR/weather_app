import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_pro/Presentation/providers/unit_provider.dart';
import '../../Data/Model/current_weather.dart';
import '../../Data/Model/five_days_weather.dart';
import '../../Data/Model/location.dart';
import '../../Data/Repositories/WeatherRepository.dart';
import '../../Data/const.dart';
import 'current_weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit({required this.weatherRepo}) : super(WeatherInitial()) {
    initializeWeatherData();
    getCurrentPosition();

  }

  final WeatherRepository weatherRepo;
  late CurrentWeather? myCurrentWeather;
  late FiveDaysWeather? myFiveDaysWeather;
  Position? _currentPosition; // Store the current position

  Future<void> initializeWeatherData() async {
    String? preferredCity = await weatherRepo.getPreferredCity();
    print("preferred city: $preferredCity");

    final isCelsius = weatherRepo.getSwitchUnit();

    if (preferredCity != null) {
      getCurrent_FiveDaysWeatherByCity(preferredCity);
    } else {
      getWeatherData(
          unit:
              isCelsius ? WeatherUnit.metric.name : WeatherUnit.imperial.name);
    }
  }

  void getLocation() {
    weatherRepo.getLocation();
  }

  void addCity(String cityName) {
    weatherRepo.setPreferredCity(cityName);
  }

  Future<void> getWeatherData({required String unit}) async {
    print("unitt" + unit);
    emit(WeatherLoading());
    try {
      myCurrentWeather = await weatherRepo.getCurrentWeatherByLatLon(unit);
      myFiveDaysWeather = await weatherRepo.getFiveDaysWeather(unit);
      print("show notification1 " + myCurrentWeather!.main!.temp!.toString());
      sendAlerts(myCurrentWeather!.main!.temp!);
      emit(WeatherLoaded(
          currentWeather: myCurrentWeather,
          fiveDaysWeather: myFiveDaysWeather));
    } catch (errorMessage) {
      print(errorMessage.toString());
      emit(WeatherError(message: errorMessage.toString()));
    }
  }

  void sendAlerts(double temperature) {
   weatherRepo.sendAlerts(temperature);
  }

  void getCurrent_FiveDaysWeatherByCity(String cityName) async {
    emit(WeatherLoading());
    final isCelsius = weatherRepo.getSwitchUnit();

    try {
      myCurrentWeather = await weatherRepo.getCurrentWeatherByCity(cityName,
          isCelsius ? WeatherUnit.metric.name : WeatherUnit.imperial.name);
      ;
      myFiveDaysWeather = await weatherRepo.getFiveDaysWeatherByCity(cityName,
          isCelsius ? WeatherUnit.metric.name : WeatherUnit.imperial.name);
      sendAlerts(myCurrentWeather!.main!.temp!);

      emit(WeatherLoaded(
          currentWeather: myCurrentWeather,
          fiveDaysWeather: myFiveDaysWeather));
    } catch (errorMessage) {
      print(errorMessage);
      myCurrentWeather = null;

      emit(WeatherError(message: errorMessage.toString()));
    }
  }

  void updateUnit(bool isCelsius) {
    weatherRepo.updateUnit(isCelsius);
  }

  bool getUnit() {
    return weatherRepo.getSwitchUnit();
  }

  void updatLocation(LocationModel locationModel) {
    weatherRepo.updatLocation(locationModel);
  }
  Future<void> getCurrentPosition() async {
    _currentPosition = await weatherRepo.determinePosition();
  }
  Position? determinePosition() {
    return _currentPosition;
  }
  Future<void> getCityNameFromLatLon(
      double latitude, double longitude, UnitProvider unitProvider) async {
    // Call getCityName from the repository and await its completion
    await weatherRepo.getCityName(latitude, longitude, unitProvider);
    weatherRepo.deletePreferredCity();

  }
}
