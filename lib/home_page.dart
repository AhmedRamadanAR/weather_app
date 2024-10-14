import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WeatherPro Home'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Text('Welcome to WeatherPro App!'), // Placeholder home page
      ),
    );
  }
}
