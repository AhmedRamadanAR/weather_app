import 'package:flutter/cupertino.dart';
import 'package:weather_pro/Data/Repositories/WeatherRepository.dart';

class NotificationsProvider with ChangeNotifier {
  final WeatherRepository weatherRepository;
  bool sendAlert = true;

  NotificationsProvider({required this.weatherRepository}) {
    _initialize();
  }


  void _initialize(){

    sendAlert= weatherRepository.getAlert();

    notifyListeners();
  }
  void changeSwitchState() async {
    sendAlert = !sendAlert;
    notifyListeners();

    weatherRepository.updateAlert(sendAlert);
  }
}