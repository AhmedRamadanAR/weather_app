import 'package:flutter/material.dart';
import 'themes/light_theme.dart';
import 'themes/dark_theme.dart';
import 'widgets/weather_forecast.dart';
import 'widgets/next_forecast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather App'),
          actions: [
            IconButton(
              icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nights_stay),
              onPressed: toggleTheme,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: WeatherHourlyForecast(
                  temperature: "28°C",
                  location: "Fortaleza",
                  maxTemp: "31°C",
                  minTemp: "25°C",
                  humidity: "6%",
                  precipitation: "90%",
                  windSpeed: "19 km/h",
                  forecastData: [
                    {"temp": "29°C", "time": "15:00"},
                    {"temp": "26°C", "time": "16:00"},
                    {"temp": "24°C", "time": "17:00"},
                    {"temp": "23°C", "time": "18:00"},
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: NextForecast(
                  forecastData: [
                    {"day": "Monday", "icon": "cloud", "high": "13", "low": "10"},
                    {"day": "Tuesday", "icon": "cloud", "high": "17", "low": "12"},
                    {"day": "Wednesday", "icon": "sunny", "high": "20", "low": "14"},
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

