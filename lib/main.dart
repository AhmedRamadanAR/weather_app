import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:weather_pro/Data/Model/location.dart';
import 'package:weather_pro/Data/local/database_service.dart';
import 'package:weather_pro/Presentation/providers/notifications_provider.dart';
import 'package:weather_pro/Presentation/providers/unit_provider.dart';

import 'package:weather_pro/Presentation/screens/splash_screen.dart';

import 'Data/Repositories/WeatherRepository.dart';
import 'Data/Services/ApiService.dart';
import 'Data/Services/location_service.dart';
import 'Data/Services/notifications_service.dart';
import 'Presentation/cubit/current_weather_cubit.dart';
import 'Presentation/theme/theme_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  var path = await getApplicationDocumentsDirectory();
  Hive.init(path.path);
  final NotificationService notificationService = NotificationService();
  Hive.registerAdapter(LocationModelAdapter());
 await Hive.openBox("isCelsius");
  await Hive.openBox('location');
  await Hive.openBox("isDarkMode");
  await Hive.openBox("sendAlert");
  await Hive.openBox<LocationModel>('location_model');

  final localStorage=DatabaseService();
  final locationService=LocationService();
  final apiService=WeatherApiService();
final weatherRepo=WeatherRepository(notificationService:notificationService,locationService: locationService, localStorage: localStorage, apiService: apiService);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider(weatherRepository: weatherRepo)),
        BlocProvider(
          create: (context) => WeatherCubit(
            weatherRepo: weatherRepo),
            ),
        ChangeNotifierProvider(create:(context)=>UnitProvider(weatherRepository: weatherRepo)),
        ChangeNotifierProvider(create: (context)=>NotificationsProvider(weatherRepository: weatherRepo)),



      ],
      child: const MyApp(),
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
      home: const SplashScreen(),
    );
  }
}
