import 'package:flutter/material.dart';

class WeatherDetails extends StatelessWidget {
  final String humidity;
  final String precipitation;
  final String windSpeed;

  WeatherDetails({
    required this.humidity,
    required this.precipitation,
    required this.windSpeed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildDetailColumn(context, Icons.opacity, humidity, "Humidity"),
          _buildDetailColumn(context, Icons.cloud, precipitation, "Clouds"),
          _buildDetailColumn(context, Icons.air, windSpeed, "Wind"),
        ],
      ),
    );
  }

  // Pass BuildContext as a parameter to the method
  Column _buildDetailColumn(BuildContext context, IconData icon, String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 24.0, color: Theme.of(context).iconTheme.color),
        SizedBox(height: 5),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).textTheme.bodyMedium!.color?.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}
