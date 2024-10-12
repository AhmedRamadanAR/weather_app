import 'package:flutter/material.dart';

import 'dark_theme.dart';
import 'light_theme.dart';


class ThemeProvider with ChangeNotifier{
  bool isDarkMode = false;
  ThemeData get currentTheme => isDarkMode ? lightTheme : darkTheme;
  void changeSwitchState(){
    isDarkMode= !isDarkMode;
    notifyListeners();
  }
}