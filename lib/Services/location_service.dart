import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_pro/Data/Model/location.dart';
import 'package:weather_pro/Data/const.dart';
import 'package:weather_pro/Data/local/local_storage.dart';

class LocationService {
  final LocalStorage _localStorage;

  LocationService(this._localStorage);

  Future<Position?> determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }


    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    final position = await Geolocator.getCurrentPosition();
    final city= await getCityName(position.latitude, position.longitude);
      _localStorage.addLocation(LocationModel(lat: position.latitude, lon: position.longitude, cityName:city,unit: WeatherUnit.metric.name));
    return position ;
  }

  Future<String?> getCityName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      return place.locality;
    } catch (e) {
      print("Error retrieving city name: $e");
      return null;
    }
  }
}