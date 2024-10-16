import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Data/Model/current_weather.dart';
import '../../Data/Model/five_days_weather.dart';
import '../../Data/Model/location.dart';
import '../../Data/Repositories/WeatherRepository.dart';
import '../../Data/const.dart';
import 'current_weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit({required this.weatherRepo}) : super(WeatherInitial()) {
    initializeWeatherData();
  }

  final WeatherRepository weatherRepo;
  late CurrentWeather? myCurrentWeather;
  late FiveDaysWeather? myFiveDaysWeather;

  Future<void> initializeWeatherData() async {
    String? preferredCity = await weatherRepo.getPreferredCity();
    print("preferred city: " + preferredCity.toString());

    final isCelsius = weatherRepo.getSwitchUnit();

    if (preferredCity != null) {
      getCurrent_FiveDaysWeatherByCity(preferredCity, unit:   isCelsius ? WeatherUnit.metric.name : WeatherUnit.imperial.name);
    } else {
      getWeatherData( unit :isCelsius ? WeatherUnit.metric.name : WeatherUnit.imperial.name);
    }
  }
  void getLocation(){
    weatherRepo.getLocation();
  }

  void addCity(String cityName) {
    weatherRepo.setPreferredCity(cityName);
  }

  Future<void> getWeatherData({String unit = 'metric'}) async {
    emit(WeatherLoading());
    try {
      myCurrentWeather = await weatherRepo.getCurrentWeatherByLatLon(unit);
      myFiveDaysWeather = await weatherRepo.getFiveDaysWeather(unit);
      emit(WeatherLoaded(
          currentWeather: myCurrentWeather,
          fiveDaysWeather: myFiveDaysWeather));
    } catch (errorMessage) {
      print(errorMessage.toString());
      emit(WeatherError(message: errorMessage.toString()));
    }
  }

  void getCurrent_FiveDaysWeatherByCity(String cityName, {String unit = 'metric'}) async {
    emit(WeatherLoading());

    try {
      myCurrentWeather = await weatherRepo.getCurrentWeatherByCity(cityName,unit);
       myFiveDaysWeather=await weatherRepo.getFiveDaysWeatherByCity(cityName, unit);
      emit(WeatherLoaded(
          currentWeather: myCurrentWeather,fiveDaysWeather: myFiveDaysWeather
      ));
    } catch (errorMessage) {
      print(errorMessage);
      myCurrentWeather = null;

      emit(WeatherError(message: errorMessage.toString()));
    }

  }
  void updateUnit(bool isCelsius){
    weatherRepo.updateUnit(isCelsius);
  }
  bool getUnit(){
    return weatherRepo.getSwitchUnit();
  }
  void updatLocation(LocationModel locationModel) {
    weatherRepo.updatLocation(locationModel);
  }
}
