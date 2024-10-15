import 'package:flutter/material.dart';
import 'package:weather_pro/Onboboarding/onboarding_view.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Animation controller for 2 seconds
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();  // Start the animation

    // Fade-in effect animation
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    // Navigate to HomePage after the animation completes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) =>  const OnboardingView()),
        );
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
      backgroundColor: Colors.deepPurple,  // Background color
      body: FadeTransition(
        opacity: _animation,  // Apply the fade-in animation
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Rounded logo container
              Container(
                width: 150,  // Adjust the size
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(75),  // Half of the size for full rounding
                  image: const DecorationImage(
                    image: AssetImage('assets/logo.png'),  // Your logo path
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),  // Space between logo and app name
              const Text(
                'WeatherPro',  // App name or tagline
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
