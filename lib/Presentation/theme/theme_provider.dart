import 'package:flutter/material.dart';

import '../../Data/Repositories/WeatherRepository.dart';
import 'dark_theme.dart';
import 'light_theme.dart';


class ThemeProvider with ChangeNotifier{
  bool isDarkMode = false;
  final WeatherRepository weatherRepository;
  ThemeProvider({required this.weatherRepository}) {
    _initialize();
  }
  ThemeData get currentTheme => isDarkMode ? darkTheme : lightTheme;
  void changeSwitchState(){
    isDarkMode= !isDarkMode;
    notifyListeners();
    weatherRepository.updateSwitchTheme(isDarkMode);

  }
  void _initialize(){
    isDarkMode=   weatherRepository.getSwitchTheme();
    notifyListeners();
  }
}