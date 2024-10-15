import 'package:flutter/material.dart';

class NextForecast extends StatelessWidget {
  final List<Map<String, String>> forecastData;

  NextForecast({required this.forecastData});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Next Forecast',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 10),
          ...forecastData.map((data) {
            return _buildForecastItem(context, data['day']!, data['icon']!, data['high']!, data['low']!);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildForecastItem(BuildContext context, String day, String icon, String high, String low) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Row(
            children: [
              Icon(
                Icons.cloud, // You can use different icons based on the weather condition
                size: 24.0,
                color: Theme.of(context).iconTheme.color,
              ),
              SizedBox(width: 10),
              Text(
                '$high° / $low°',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
