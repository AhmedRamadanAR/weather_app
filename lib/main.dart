import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_pro/Presentation/cubit/current_weather_cubit.dart';
import 'package:weather_pro/Services/ApiService.dart';
import 'package:weather_pro/presentation/Screens/splash_screen.dart';
import 'package:weather_pro/presentation/theme/theme_provider.dart';

import 'Data/Repositories/WeatherRepository.dart';
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        BlocProvider(
          create: (context) => CurrentWeatherCubit(
            currentWeatherRepo: WeatherRepository(apiService: WeatherApiService()),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context).currentTheme,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}


