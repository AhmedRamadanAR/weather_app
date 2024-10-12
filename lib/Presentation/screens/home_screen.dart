


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Data/const.dart';
import '../cubit/current_weather_cubit.dart';
import '../cubit/current_weather_state.dart';
import '../cubit/five_days_weather_cubit.dart';
import '../cubit/five_days_weather_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var currentWeatherCubit = context.read<CurrentWeatherCubit>();
    var fiveDaysWeatherCubit=context.read<FiveDaysWeatherCubit>();
    print("inside build method");
    return Scaffold(
        appBar: AppBar(
          title: Text('Current Weather'),),
        body: Column(children: [BlocBuilder<CurrentWeatherCubit, CurrentWeatherState>(
          builder: (context, state) {
            print("inside builder1");
            currentWeatherCubit.getCurrentWeatherByLatLon(31.2001,29.9187, WeatherUnit.imperial.name);
            print("State 1"+state.toString());
            if (state is CurrentWeatherLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CurrentWeatherLoaded) {
              return Text(state.currentWeather.weather![0].description.toString());
            } else if (state is CurrentWeatherError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text('No weather data available'));
            }
          },
        ),
          BlocBuilder<FiveDaysWeatherCubit,FiveDaysWeatherState>(builder: (context,state){
            fiveDaysWeatherCubit.getFiveDaysWeatherData(31.2001, 29.9187, WeatherUnit.imperial.name);
            print("inside builder2");

            if (state is FiveDaysWeatherLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FiveDaysWeatherLoaded) {
              return Text(state.fiveDaysWeather.list!.length.toString());
            } else if (state is FiveDaysWeatherError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text('No weather data available'));
            }
          })
        ],)

    );
  }
}

