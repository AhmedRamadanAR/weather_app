import 'package:hive/hive.dart';
import 'package:weather_pro/Data/Model/location.dart';
import 'package:weather_pro/Data/local/local_storage.dart';

class DatabaseService implements LocalStorage{
  final _locationBox = Hive.box<LocationModel>('location_model');
  final showLocationScreenBox = Hive.box('location');
final isCelsius=Hive.box("isCelsius");
final isDarkMode=Hive.box("isDarkMode");
  @override
  void addLocation(LocationModel locationModel)async {

    await _locationBox.add( locationModel);
  }

  @override
  void deleteLocation() async{
    await _locationBox.deleteAt(0);
  }

  @override
  LocationModel getLocation() {
  print("here");
  print(_locationBox.values.first.lat);
  print(_locationBox.values.first.lon);
    return  _locationBox.values.first;

  }

  @override
  void updateLocation(LocationModel locationModel)async {
    await _locationBox.putAt(0, locationModel);
  }



  @override
  Future<String?> getPreferredCity() async {
    return showLocationScreenBox.get('preferredCity') as String?;
  }


  @override
  Future<void> setPreferredCity(String cityName) async {
    await showLocationScreenBox.put('preferredCity', cityName);
  }

  @override
  bool getSwitchUnit() {
   return  isCelsius.get('isCelsius',defaultValue: true);
  }

  @override
  void updateSwitchUnit(bool value) async{
    await isCelsius.put('isCelsius', value);
  }

  @override
  bool getSwitchTheme() {
    return  isDarkMode.get('isDarkMode',defaultValue: false);

  }

  @override
  void updateSwitchTheme(bool value) async{
    await isDarkMode.put('isDarkMode', value);
  }

}