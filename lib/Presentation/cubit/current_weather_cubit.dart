
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Data/Repositories/WeatherRepository.dart';
import '../../Model/current_weather.dart';
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
        myCurrentWeather = currentWeather;
        emit(CurrentWeatherLoaded(currentWeather: currentWeather));
      });
      return myCurrentWeather!;
    } catch (errorMessage) {
      myCurrentWeather = null;

      emit(CurrentWeatherError(message: errorMessage.toString()));
    }

    return myCurrentWeather;
  }

  Future<CurrentWeather?> getCurrentWeatherByLatLon(
      double lat, double lon, String unit) async {
    try {
      await currentWeatherRepo
          .getCurrentWeatherByLatLon(lat, lon, unit)
          .then((currentWeather) {
        myCurrentWeather = currentWeather;

        emit(CurrentWeatherLoaded(currentWeather: currentWeather));
      });
    } catch (errorMessage) {
      myCurrentWeather = null;

      emit(CurrentWeatherError(message: errorMessage.toString()));
    }

    return myCurrentWeather;
  }
}
