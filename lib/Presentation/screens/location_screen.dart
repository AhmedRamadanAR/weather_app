import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:weather_pro/Data/Model/location.dart';
import 'package:weather_pro/Data/Repositories/WeatherRepository.dart';
import 'package:weather_pro/Data/const.dart';
import 'package:weather_pro/Data/local/database_service.dart';
import 'package:weather_pro/Data/local/local_storage.dart';
import 'package:weather_pro/Presentation/screens/home_screen.dart';
import 'package:weather_pro/Services/ApiService.dart';

import '../../Services/location_service.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});


  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var box = Hive.box('location');
var repo = WeatherRepository(localStorage:DatabaseService(),apiService: WeatherApiService(), locationService: LocationService(DatabaseService()));
  double? _latitude;
  double? _longitude;
  String? _cityName;
  bool _isLoading = false;
  final LocationService _locationService = LocationService(DatabaseService());


  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  // Fetch location and city name
  void _getLocation() async {
    setState(() {
      _isLoading = true;
    });

    Position? position = await _locationService.determinePosition();
    if (position != null) {
      setState(()async {
        _latitude = position.latitude;
        _longitude = position.longitude;
      var getCityName=  await _getCityName(_latitude!, _longitude!);
        repo.addLocation(LocationModel(lat: _latitude, lon: _longitude, cityName: getCityName,unit: WeatherUnit.imperial.name));

      });
    } else {
      setState(() {
        _isLoading = false;
      });
      print('Location permissions are not granted');
    }
  }

  // Reverse geocoding to get the city name from lat and long
  Future<String?> _getCityName(double latitude, double longitude) async {
    String? cityName = await _locationService.getCityName(latitude, longitude);
    setState(() {
      _cityName = cityName;
      _isLoading = false;
    });
    return cityName.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test"),
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton(onPressed: () {
              setState(() {
                box.put('status', 'true');

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              });
            }, child: Text("move to home screen"),style:ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                  vertical: 15, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor:
              Theme
                  .of(context)
                  .colorScheme
                  .primary,
              foregroundColor: Colors.white,
            ),),
            const Text(
              'Your Current City',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? Center(
              child: CircularProgressIndicator(
                color: Theme
                    .of(context)
                    .colorScheme
                    .primary,
              ),
            )
                : _cityName != null
                ? Column(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(Icons.location_city,
                            color: Colors.blueAccent, size: 30),
                        const SizedBox(width: 10),
                        Text(
                          'City: $_cityName',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _getLocation,
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  label: const Text("Refresh Location"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor:
                    Theme
                        .of(context)
                        .colorScheme
                        .primary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            )
                : const Center(
              child: Text(
                'City name not available.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _getLocation,
              icon: const Icon(Icons.gps_fixed, color: Colors.white),
              label: const Text("Get Current City"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 15, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Theme
                    .of(context)
                    .colorScheme
                    .primary,
                foregroundColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}