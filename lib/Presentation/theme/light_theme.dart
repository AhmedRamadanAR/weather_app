import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  colorScheme: ColorScheme.light(
    primary: Colors.blue,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color.fromARGB(255, 8, 39, 85),
    foregroundColor: Colors.white,
  ),
);