import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_pro/presentation/cubit/current_weather_cubit.dart';
import 'package:weather_pro/presentation/cubit/current_weather_state.dart';
Widget currentWeatherWidget(BuildContext context) {

  return BlocBuilder<CurrentWeatherCubit, CurrentWeatherState>(
    builder: (context, state) {
      if (state is CurrentWeatherLoading) {
        return const Center(
          child: CircularProgressIndicator(
            color: Color(0xFFE23E3E),
          ),
        );
      } else if (state is CurrentWeatherLoaded) {
        print("current" + state.currentWeather.name.toString());
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center, // Added for centering
          children: [
            Text('City: ${state.currentWeather.name}'),
            Text('Temperature: ${state.currentWeather.main?.temp}°C'),
            Text('Weather: ${state.currentWeather.weather?.first.description}'),
          ],
        );
      } else if (state is CurrentWeatherError) {
        return const Center(child: Text("try again later"));
      } else {
        return const Center(child: Text("no data found"));
      }
    },
  );
}
