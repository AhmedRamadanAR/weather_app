import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Data/Model/current_weather.dart';
import '../../Data/Model/five_days_weather.dart';
import '../../Data/Repositories/WeatherRepository.dart';
import 'current_weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit({required this.weatherRepo})
      : super(WeatherInitial()){
   getWeatherData();
  }
  final WeatherRepository weatherRepo;
  late CurrentWeather? myCurrentWeather;
  late FiveDaysWeather? myFiveDaysWeather;

  Future<void> getWeatherData() async {
    emit(WeatherLoading());
    try {
      myCurrentWeather = await weatherRepo.getCurrentWeatherByLatLon();
      myFiveDaysWeather = await weatherRepo.getFiveDaysWeather();
      emit(WeatherLoaded(
          currentWeather: myCurrentWeather,
          fiveDaysWeather: myFiveDaysWeather));
    } catch (errorMessage) {
      print(errorMessage.toString());
      emit(WeatherError(message: errorMessage.toString()));
    }
  }


  Future<CurrentWeather?> getCurrentWeatherByCity() async {
    try {
      emit(WeatherLoading());

     myCurrentWeather= await weatherRepo
          .getCurrentWeatherByCity()
          .then((currentWeather) {
        myCurrentWeather = currentWeather;
        emit(WeatherLoaded(currentWeather: currentWeather));
      });
      return myCurrentWeather!;
    } catch (errorMessage) {
      myCurrentWeather = null;

      emit(WeatherError(message: errorMessage.toString()));
    }

    return myCurrentWeather;
  }



}
