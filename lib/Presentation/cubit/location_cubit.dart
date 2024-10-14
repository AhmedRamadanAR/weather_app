import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_pro/Data/Repositories/WeatherRepository.dart';
import 'package:weather_pro/Presentation/cubit/location_state.dart';

// class LocationCubit extends Cubit<LocationState> {
//   LocationCubit({required this.weatherRepo}) : super(LocationInitial()) {
//     var lat= weatherRepo.localStorage.getLocation().lat;
//     var long=weatherRepo.localStorage.getLocation().lon;
//     getLocationData(lat, long);
//   }
//   final WeatherRepository weatherRepo;
//
//   Future<void> getLocationData(latitude, longitude) async {
//     emit(LocationLoading());
//     try {
//     final position=  await weatherRepo.determinePosition();
//      final city= await weatherRepo.getCityName(latitude, longitude);
//       emit(LocationLoaded(position: position,city: city));
//     } catch (errorMessage) {
//       emit(LocationError(message: errorMessage.toString()));
//     }
//   }
// }
