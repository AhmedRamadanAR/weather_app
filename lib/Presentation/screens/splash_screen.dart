import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:weather_pro/Presentation/screens/home_screen.dart';
import 'package:weather_pro/Presentation/screens/location_screen.dart';


class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  var box = Hive.box('location');

  void open() async {
    await Hive.openBox('location');
  }


  // Function to Navigate to the on-boarding screen
  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LocationScreen()));
  }

  // Function to Navigate to the main screen
  elseroute() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }


  @override
  void initState() {
    super.initState();
    open(); // Open the Hive box


    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )
      ..forward();

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    Timer(Duration(seconds: 3), () {
      (box.get('status') == 'true' ? elseroute : route)();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent, // Background color
      body: FadeTransition(
        opacity: _animation, // Apply the fade-in animation
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Rounded logo container
              Container(
                width: 150, // Adjust the size
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(75),
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20), // Space between logo and app name
              Text(
                'WeatherPro', // App name or tagline
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}