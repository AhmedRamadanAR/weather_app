
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



    print("inside build method");
    return Scaffold(
        appBar: AppBar(
          title: Text('Current Weather'),),
        body: Column(children: [BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            print("inside builder1");
            print("State 1"+state.toString());
            if (state is WeatherLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is WeatherLoaded) {
              return Text(state.currentWeather!.weather![0].description.toString() + state.fiveDaysWeather!.cnt.toString());
            } else if (state is WeatherError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text('No weather data available'));
            }
          },
        ),
          // BlocBuilder<FiveDaysWeatherCubit,FiveDaysWeatherState>(builder: (context,state){
          //   print("inside builder2");
          //
          //   if (state is FiveDaysWeatherLoading) {
          //     return Center(child: CircularProgressIndicator());
          //   } else if (state is FiveDaysWeatherLoaded) {
          //     return Text(state.fiveDaysWeather.list!.length.toString());
          //   } else if (state is FiveDaysWeatherError) {
          //     return Center(child: Text(state.message));
          //   } else {
          //     return Center(child: Text('No weather data available'));
          //   }
          // })
        ],)

    );
  }

}

