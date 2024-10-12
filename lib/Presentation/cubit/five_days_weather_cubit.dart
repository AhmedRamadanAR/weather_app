
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Data/Repositories/WeatherRepository.dart';
import '../../Model/five_days_weather.dart';
import 'five_days_weather_state.dart';

class FiveDaysWeatherCubit extends Cubit<FiveDaysWeatherState> {
  FiveDaysWeatherCubit({required this.weatherRepo})
      : super(FiveDaysWeatherInitial());
  final WeatherRepository weatherRepo;
  late FiveDaysWeather? myFiveDaysWeather;

  Future<FiveDaysWeather?> getFiveDaysWeatherData(
      double lat, double lon, String unit) async {
    emit(FiveDaysWeatherLoading());

    try {
      await weatherRepo.getFiveDaysWeather(lat, lon, unit).then((state) {
        myFiveDaysWeather = state;
        emit(FiveDaysWeatherLoaded(fiveDaysWeather: state));
      });
      return myFiveDaysWeather;
    } catch (errorMessage) {
      myFiveDaysWeather = null;
      emit(FiveDaysWeatherError(message: errorMessage.toString()));
    }
    return myFiveDaysWeather;
  }
}
