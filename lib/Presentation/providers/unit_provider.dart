import 'package:flutter/cupertino.dart';

class UnitProvider with ChangeNotifier{
  bool isCelsius = true;
  void changeSwitchState(){
    isCelsius= !isCelsius;
    notifyListeners();
  }
}