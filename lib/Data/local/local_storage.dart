import 'package:weather_pro/Data/Model/location.dart';

abstract  class LocalStorage{
  void addLocation(LocationModel locationModel) ;
  LocationModel getLocation();
  void updateLocation(LocationModel locationModel);
  void deleteLocation() ;

  Future<void> setPreferredCity(String cityName);
  Future<String?> getPreferredCity();

void updateSwitchUnit(bool value);
  bool getSwitchUnit();

void updateSwitchTheme(bool value);
bool getSwitchTheme();
}