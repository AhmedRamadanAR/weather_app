import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../cubit/current_weather_cubit.dart';
import '../cubit/current_weather_state.dart';
import '../theme/theme_provider.dart';
import '../widgets/widgets.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('WeatherPro Home'),
        actions: [
          Switch(
            value: themeProvider.isDarkMode,
            onChanged: (newValue) {
              themeProvider.changeSwitchState();
            },
            activeColor: Colors.green,
            activeTrackColor: Colors.white,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(child: currentWeatherWidget(context)),
      ),
    );
  }

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
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('City: ${state.currentWeather.name}'),
              Text('Temperature: ${state.currentWeather.main?.temp}°C'),
              Text('Weather: ${state.currentWeather.weather?.first.description}'),
            ],
          );
        } else if (state is CurrentWeatherError) {
          return const Center(child: Text("Try again later"));
        } else {
          return const Center(child: Text("No data found"));
        }
      },
    );
  }
}

// FutureBuilder<CurrentWeather>(
// future: repo.getCurrentWeatherByCity("cairo", 'metric'),
// builder: (context, snapshot) {
// if (snapshot.connectionState == ConnectionState.waiting) {
// return CircularProgressIndicator(); // Show loading indicator while waiting
// } else if (snapshot.hasError) {
// print('Error: ${snapshot.error}');
// return Text(
// 'Error: ${snapshot.error}'); // Show error message if there's an error
// } else if (snapshot.hasData) {
// final weather = snapshot.data!;
// return Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Text('City: ${weather.name}'),
// Text('Temperature: ${weather.main?.temp}°C'),
// Text('Weather: ${weather.weather?.first.description}'),
// ],
// );
// } else {
// return Text(
// 'No data available'); // Show a default message if there's no data
// }
// },
// ),