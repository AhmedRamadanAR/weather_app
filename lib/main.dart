import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_pro/Presentation/cubit/five_days_weather_cubit.dart';
import 'package:weather_pro/Presentation/screens/splash_screen.dart';

import 'Data/Repositories/WeatherRepository.dart';
import 'Presentation/cubit/current_weather_cubit.dart';
import 'Presentation/theme/theme_provider.dart';
import 'Services/ApiService.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        BlocProvider(
          create: (context) => CurrentWeatherCubit(
            currentWeatherRepo:
                WeatherRepository(apiService: WeatherApiService()),
          ),
        ),
        BlocProvider(
            create: (context) =>
                FiveDaysWeatherCubit(weatherRepo: WeatherRepository(apiService: WeatherApiService())))
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context).currentTheme,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
