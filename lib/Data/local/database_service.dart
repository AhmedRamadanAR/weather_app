import 'package:hive/hive.dart';
import 'package:weather_pro/Data/Model/location.dart';
import 'package:weather_pro/Data/local/local_storage.dart';

class DatabaseService implements LocalStorage {
  final _locationBox = Hive.box<LocationModel>('location_model');
  final showLocationScreenBox = Hive.box('location');
  final isCelsius = Hive.box("isCelsius");
  final isDarkMode = Hive.box("isDarkMode");
  final sendAlert = Hive.box("sendAlert");

  @override
  void addLocation(LocationModel locationModel) {
    final box = Hive.box<LocationModel>('location_model');

    if (box.isEmpty) {
      box.add(locationModel);
    } else {
      box.putAt(0, locationModel);
    }
  }

  @override
  void deleteLocation() async {
    await _locationBox.deleteAt(0);
  }

  @override
  LocationModel getLocation() {

    return _locationBox.values.first;
  }

  @override
  void updateLocation(LocationModel locationModel) async {
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
  Future<void> deletePreferedCity() async {
    return showLocationScreenBox.delete('preferredCity') ;
  }

  @override
  bool getSwitchUnit() {
    return isCelsius.get('isCelsius', defaultValue: true);
  }

  @override
  void updateSwitchUnit(bool value) async {
    await isCelsius.put('isCelsius', value);
  }

  @override
  bool getSwitchTheme() {
    return isDarkMode.get('isDarkMode', defaultValue: false);
  }

  @override
  void updateSwitchTheme(bool value) async {
    await isDarkMode.put('isDarkMode', value);
  }

  @override
  bool getAlert() {
    return sendAlert.get('sendAlert', defaultValue: true);
  }

  @override
  void updateAlert(bool value) async {
    await sendAlert.put('sendAlert', value);
  }
}
