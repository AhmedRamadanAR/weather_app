import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  colorScheme: ColorScheme.light(
    primary: Colors.blue,
    secondary: Colors.yellow, // Accent color
  ),
  appBarTheme: AppBarTheme(
    backgroundColor:    Color.fromARGB(255, 8, 39, 85),
    foregroundColor: Colors.white, // Text color in AppBar

  ),
);