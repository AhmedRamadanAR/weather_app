import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:weather_pro/Data/Model/location.dart';
import 'package:weather_pro/Data/local/database_service.dart';
import 'package:weather_pro/Presentation/providers/unit_provider.dart';

import 'package:weather_pro/Presentation/screens/splash_screen.dart';
import 'package:weather_pro/Services/location_service.dart';

import 'Data/Repositories/WeatherRepository.dart';
import 'Presentation/cubit/current_weather_cubit.dart';
import 'Presentation/theme/theme_provider.dart';
import 'Services/ApiService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // get path of the app
  var path = await getApplicationDocumentsDirectory();
  // initialize hive with the app directory
  Hive.init(path.path);
  Hive.registerAdapter(LocationModelAdapter());
 await Hive.openBox("isCelsius");
  await Hive.openBox('location');
  await Hive.openBox("isDarkMode");

  await Hive.openBox<LocationModel>('location_model');
  final localStorage=DatabaseService();

  final locationService=LocationService();
  final apiService=WeatherApiService();
final weatherRepo=WeatherRepository(locationService: locationService, localStorage: localStorage, apiService: apiService);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider(weatherRepository: weatherRepo)),
        BlocProvider(
          create: (context) => WeatherCubit(
            weatherRepo: weatherRepo),
            ),
        ChangeNotifierProvider(create:(context)=>UnitProvider(weatherRepository: weatherRepo))

        //BlocProvider(create: (context)=>LocationCubit(weatherRepo: weatherRepo))

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
