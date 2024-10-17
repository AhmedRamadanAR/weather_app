import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';
import 'location_screen.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  void _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('onboarding') ?? true;
    bool isLocationSet = prefs.getBool('location') ?? true;

    if (isFirstTime) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const onboarding_screen()),
      );
    } else if (isLocationSet) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LocationScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }



  @override
  void initState() {
    super.initState();

    // Initialize AnimationController and Animation here
    _controller = AnimationController(
      duration: const Duration(seconds:5),
      vsync: this,
    )..forward();

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    // Check SharedPreferences and navigate after animation completes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _checkFirstTime();
      }
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
      backgroundColor:                     const Color.fromARGB(255, 12, 66, 172)
      , // Background color
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
                  // Half of the size for full rounding
                  image: const DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                    // Your logo path
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20), // Space between logo and app name
              const Text(
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
