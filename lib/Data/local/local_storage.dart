import 'package:weather_pro/Data/Model/location.dart';

abstract  class LocalStorage{
  void addLocation(LocationModel locationModel) ;
  LocationModel getLocation();
  void updateLocation(LocationModel locationModel);
  void deleteLocation() ;

  Future<void> setPreferredCity(String cityName);
  Future<String?> getPreferredCity();
  Future<void> deletePreferedCity();

void updateSwitchUnit(bool value);
  bool getSwitchUnit();

void updateSwitchTheme(bool value);
bool getSwitchTheme();

void updateAlert(bool value);
bool getAlert();
}