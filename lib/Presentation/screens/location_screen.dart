import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_pro/Data/Model/location.dart';
import 'package:weather_pro/Data/Repositories/WeatherRepository.dart';
import 'package:weather_pro/Data/const.dart';
import 'package:weather_pro/Data/local/database_service.dart';
import 'package:weather_pro/Presentation/providers/unit_provider.dart';
import 'package:weather_pro/Presentation/screens/home_screen.dart';
import 'package:weather_pro/Presentation/widgets/switch_widget.dart';
import 'package:weather_pro/Services/ApiService.dart';

import '../../Services/location_service.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  // var unit = Hive.box<LocationModel>('location_model');

  var repo = WeatherRepository(
      localStorage: DatabaseService(),
      apiService: WeatherApiService(),
      locationService: LocationService());
  double? _latitude;
  double? _longitude;
  String? _cityName;
  bool _isLoading = false;
  bool _isButtonEnabled = false;
  final LocationService _locationService = LocationService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // var unitProvider = Provider.of<UnitProvider>(context);
    // _getLocation(unitProvider);
  }

  void _getLocation(UnitProvider unitProvider) async {


    Position? position = await repo.determinePosition();
    if (position != null) {
      _latitude = position.latitude;
      _longitude = position.longitude;
      var getCityName = await _getCityName(_latitude!, _longitude!);
      setState(() {
        _isLoading = true;
        _cityName = getCityName; // Update city name
        _isButtonEnabled = _cityName != null;
      });
      print("testo1");
      repo.addLocation(LocationModel(
        lat: _latitude,
        lon: _longitude,
        cityName: getCityName,
        unit: unitProvider.isCelsius
            ? WeatherUnit.metric.name
            : WeatherUnit.imperial.name,
      ));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('location', false);
      // Update state after asynchronous work is complete
      setState(() {
        _isLoading = false; // Update loading state
        _cityName = getCityName; // Update city name
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
        _cityName = cityName;_isLoading = false;
      });

    return cityName.toString();
  }

  @override
  Widget build(BuildContext context) {
    var unitProvider = Provider.of<UnitProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("test"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset('assets/images/location.png',width: 120,height: 180,),
              ListTile(
                leading: Text(
                  unitProvider.isCelsius ? "Celsius °C " : "Fahrenheit °F",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
                trailing: SwitchWidget(),
              ),
              ElevatedButton(
                onPressed: _isButtonEnabled
                    ? () {
                  setState(() {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                  });
                }
                    : null,
                child: Text("Next"),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
              ),
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
                        color: Theme.of(context).colorScheme.primary,
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
                              onPressed: () {
                                _getLocation(unitProvider);
                              },
                              icon:
                                  const Icon(Icons.refresh, color: Colors.white),
                              label: const Text("Refresh Location"),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
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
                onPressed: () {
                  _getLocation(unitProvider);
                },
                icon: const Icon(Icons.gps_fixed, color: Colors.white),
                label: const Text("Get Current City"),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
