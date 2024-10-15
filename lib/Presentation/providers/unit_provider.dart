import 'package:flutter/cupertino.dart';

class UnitProvider with ChangeNotifier{
  bool isCelsius = false;
  void changeSwitchState(){
    isCelsius= !isCelsius;
    notifyListeners();
  }
}