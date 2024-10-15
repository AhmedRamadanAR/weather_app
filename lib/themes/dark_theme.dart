import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  colorScheme: ColorScheme.dark(
    primary: Colors.black,
    secondary: Colors.red, // Accent color
    background: Colors.black54,
    onBackground: Colors.white,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white, // Text color in AppBar
  ),
);