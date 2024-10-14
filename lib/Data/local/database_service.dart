import 'package:hive/hive.dart';
import 'package:weather_pro/Data/Model/location.dart';
import 'package:weather_pro/Data/local/local_storage.dart';

class DatabaseService implements LocalStorage{
  final _locationBox = Hive.box<LocationModel>('location_model');
  final showLocationScreenBox = Hive.box('location');

void changeLocationScreenState () async{
  await showLocationScreenBox.put('status', 'true');

}
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
    return  _locationBox.values.first;

  }

  @override
  void updateLocation(LocationModel locationModel)async {
    await _locationBox.putAt(0, locationModel);
  }

  @override
  void updateLocationScreenState() {

    showLocationScreenBox.put('status', 'true');

     }

}