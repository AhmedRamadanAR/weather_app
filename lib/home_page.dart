import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WeatherPro Home'),
        backgroundColor: Colors.deepPurple,
      ),
      body: const Center(
        child: Text('Welcome to WeatherPro App!'), // Placeholder home page
      ),
    );
  }
}
