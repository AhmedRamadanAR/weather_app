import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:weather_pro/Data/Repositories/WeatherRepository.dart';

class UnitProvider with ChangeNotifier {
  final WeatherRepository weatherRepository;
  bool isCelsius = true; // Default value

  UnitProvider({required this.weatherRepository}) {
    _initialize();
  }


 void _initialize(){
 isCelsius=   weatherRepository.getUnit();
 notifyListeners();
 }
  void changeSwitchState() async {
    isCelsius = !isCelsius;
    notifyListeners();
     weatherRepository.updateUnit(isCelsius);
  }
}
