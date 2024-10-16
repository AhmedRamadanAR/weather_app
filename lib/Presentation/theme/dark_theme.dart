import 'package:flutter/material.dart';
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  colorScheme: ColorScheme.dark(
    primary: Colors.black,
    onPrimary: Colors.black,
    surface: Colors.black54,
    onSurface: Colors.white,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white, // Text color in AppBar
  ),
);