import 'package:flutter/material.dart';
import 'package:weather_pro/Onboboarding/onboarding_view.dart';
import 'package:weather_pro/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'splash_screen.dart'; // Import the splash screen file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  SplashScreen(), // Show SplashScreen as the initial screen
    );
  }
}
