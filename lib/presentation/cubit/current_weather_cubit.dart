import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_pro/Model/current_weather.dart';


import '../../Data/Repositories/WeatherRepository.dart';
import 'current_weather_state.dart';


class CurrentWeatherCubit extends Cubit<CurrentWeatherState> {
  CurrentWeatherCubit({required this.currentWeatherRepo})
      : super(CurrentWeatherInitial());
  final WeatherRepository currentWeatherRepo;
  late CurrentWeather? myCurrentWeather;

  Future<CurrentWeather?> getCurrentWeatherByCity(
      String city, String unit) async {
    try {
      await currentWeatherRepo
          .getCurrentWeatherByCity(city, unit)
          .then((currentWeather) {
        emit(CurrentWeatherLoaded(currentWeather: currentWeather));
      });
      return myCurrentWeather!;
    } catch (errorMessage) {
      emit(CurrentWeatherError(message: errorMessage.toString()));
      myCurrentWeather = null;
    }

    return myCurrentWeather;
  }

  Future<CurrentWeather?> getCurrentWeatherByLatLon(
      double lat, double lon, String unit) async {
    await currentWeatherRepo
        .getCurrentWeatherByLatLon(lat, lon, unit)
        .then((currentWeather) {
      try {
        emit(CurrentWeatherLoaded(currentWeather: currentWeather));
        myCurrentWeather = currentWeather;
      } catch (errorMessage) {
        emit(CurrentWeatherError(message: errorMessage.toString()));
        myCurrentWeather = null;

      }

    });
    return myCurrentWeather;
  }
}
