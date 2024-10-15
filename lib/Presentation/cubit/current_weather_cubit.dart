import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Data/Model/current_weather.dart';
import '../../Data/Model/five_days_weather.dart';
import '../../Data/Repositories/WeatherRepository.dart';
import 'current_weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit({required this.weatherRepo})
      : super(WeatherInitial()){
    _initializeWeatherData();
  }
  final WeatherRepository weatherRepo;
  late CurrentWeather? myCurrentWeather;
  late FiveDaysWeather? myFiveDaysWeather;
  Future<void> _initializeWeatherData() async {
    String? preferredCity = await weatherRepo.localStorage.getPreferredCity(); // Use LocalStorage
    print("prefered city "+preferredCity.toString());
    if (preferredCity != null) {
      getCurrentWeatherByCity(preferredCity);
    } else {
      getWeatherData();
    }
  }
  void addCity(String cityName){
   weatherRepo.localStorage.setPreferredCity(cityName) ;
  }
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

  Future<CurrentWeather?> getCurrentWeatherByCity(String cityName) async {
    emit(WeatherLoading());

    try {
      myCurrentWeather = await weatherRepo.getCurrentWeatherByCity(cityName);

      emit(WeatherLoaded(currentWeather: myCurrentWeather)); // Use existing myFiveDaysWeather
      return myCurrentWeather!;
    } catch (errorMessage) {print(errorMessage);
    myCurrentWeather = null;

    emit(WeatherError(message: errorMessage.toString()));
    }

    return myCurrentWeather;
  }



}
