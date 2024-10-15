import 'package:flutter/material.dart';
import 'WeatherDetails.dart';

class WeatherHourlyForecast extends StatelessWidget {
  final String temperature;
  final String location;
  final String maxTemp;
  final String minTemp;
  final String humidity;
  final String precipitation;
  final String windSpeed;
  final List<Map<String, String>> forecastData;

  const WeatherHourlyForecast({
    Key? key,
    required this.temperature,
    required this.location,
    required this.maxTemp,
    required this.minTemp,
    required this.humidity,
    required this.precipitation,
    required this.windSpeed,
    required this.forecastData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current Temperature and Location
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$temperature°',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    location,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    'Max: $maxTemp | Min: $minTemp',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              // Weather Icon
              Icon(Icons.wb_sunny, size: 40), // Use appropriate weather icon
            ],
          ),
          SizedBox(height: 20),

          // Weather Details
          WeatherDetails(
            humidity: humidity,
            precipitation: precipitation,
            windSpeed: windSpeed,
          ),
          SizedBox(height: 20),

          // Today's Forecast
          Text(
            'Today\'s Forecast',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: forecastData.map((data) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.cloud, // Replace with your icon logic
                        size: 30,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      SizedBox(height: 5),
                      Text(
                        data['time']!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: 5),
                      Text(
                        data['temp']!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
