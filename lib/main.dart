import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';  // Import geocoding package

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPS Location Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'GPS Location Tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double? _latitude;
  double? _longitude;
  String? _cityName;  // Variable to store city name
  bool _isLoading = false;

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

    Position? position = await _determinePosition();
    if (position != null) {
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
        _getCityName(_latitude!, _longitude!);  // Get city name from lat and long
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      print('Location permissions are not granted');
    }
  }

  // Reverse geocoding to get the city name from lat and long
  Future<void> _getCityName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];

      setState(() {
        _cityName = place.locality;  // Get the city name
        _isLoading = false;
      });
    } catch (e) {
      print("Error retrieving city name: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<Position?> _determinePosition() async {
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

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
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
              onPressed: _getLocation,
              icon: const Icon(Icons.gps_fixed, color: Colors.white),
              label: const Text("Get Current City"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,  // Ensures button text color is white
              ),
            )
          ],
        ),
      ),
    );
  }
}
