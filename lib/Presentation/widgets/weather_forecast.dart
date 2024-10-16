
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Data/Model/five_days_weather.dart';
import '../providers/unit_provider.dart';
import 'WeatherDetails.dart';


class WeatherHourlyForecast extends StatefulWidget {
  final String temperature;
  final String location;
  final String maxTemp;
  final String minTemp;
  final String humidity;
  final int date;
  final String feelsLike;
  final String clouds;
  final String windSpeed;
  final String imageUrl;
  final String weatherDescription;
  final List<FiveDaysWeatherData> forecastData;

  const WeatherHourlyForecast({
    Key? key,
    required this.feelsLike,
    required this.temperature,
    required this.location,
    required this.maxTemp,
    required this.minTemp,
    required this.humidity,
    required this.clouds,
    required this.windSpeed,
    required this.forecastData,
    required this.imageUrl,
    required this.date,
    required this.weatherDescription,
  }) : super(key: key);

  @override
  _WeatherHourlyForecastState createState() => _WeatherHourlyForecastState();
}

class _WeatherHourlyForecastState extends State<WeatherHourlyForecast> {
  final ScrollController _scrollController = ScrollController();
  String forecastText = 'Today\'s Forecast';
  final Map<int, GlobalKey> itemKeys = {};


  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.forecastData.length; i++) {
      itemKeys[i] = GlobalObjectKey(i);
    }
    _scrollController.addListener(_updateForecastText);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateForecastText);
    _scrollController.dispose();
    super.dispose();
  }

  void _updateForecastText() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final firstVisibleIndex = _getFirstVisibleIndex();
      if (firstVisibleIndex != null &&
          firstVisibleIndex < widget.forecastData.length) {
        final data = widget.forecastData[firstVisibleIndex];
        setState(() {
          forecastText = _getForecastTitle(data);
        });
      }
    });
  }

  int? _getFirstVisibleIndex() {
    for (int i = 0; i < widget.forecastData.length; i++) {
      final key = itemKeys[i];
      final context = key?.currentContext;
      if (context != null) {
        final renderBox = context.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero).dx;
        if (position >= 0) {
          return i;
        }
      }
    }
    return null;
  }

  String _getForecastTitle(FiveDaysWeatherData forecastData) {
    final currentDay = DateTime.now().weekday;
    final forecastDay = DateTime.fromMillisecondsSinceEpoch(
      forecastData.dt! * 1000,
      isUtc: true,
    ).toLocal().weekday;

    if (forecastDay == currentDay) {
      return 'Today\'s Forecast';
    } else if (forecastDay == (currentDay + 1) % 7) {
      return 'Tomorrow\'s Forecast';
    } else {
      return DateFormat('EEEE').format(
        DateTime.fromMillisecondsSinceEpoch(forecastData.dt! * 1000, isUtc: true).toLocal(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var unitProvider = Provider.of<UnitProvider>(context);

    var isCelsius=unitProvider.isCelsius;
    DateTime localDateTime =
    DateTime.fromMillisecondsSinceEpoch(widget.date * 1000, isUtc: true)
        .toLocal();
    String formattedDate =
    DateFormat('dd MMMM EEEE,\n hh:mm a').format(localDateTime);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              formattedDate,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.temperature,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    widget.location,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    'Max: ${widget.maxTemp} | Min: ${widget.minTemp}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 40),
                      Text(
                        "Feels: ${widget.feelsLike}",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Icon(Icons.device_thermostat_rounded),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Image.network(widget.imageUrl, scale: 0.6),
                  Text(widget.weatherDescription),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          WeatherDetails(
            humidity: widget.humidity,
            precipitation: widget.clouds,
            windSpeed: widget.windSpeed,
          ),
          const SizedBox(height: 20),
          Text(
            forecastText,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.forecastData.length,
              itemBuilder: (context, index) {
                final data = widget.forecastData[index];
                final localDateTime = DateTime.fromMillisecondsSinceEpoch(
                  data.dt! * 1000,
                  isUtc: true,
                ).toLocal();
                String formattedTime =
                DateFormat('EEEE,\n hh:mm a').format(localDateTime);

                return Container(
                  key: itemKeys[index], // Assign the GlobalKey to each item.
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 8.0),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(4, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.cloud, size: 30),
                      const SizedBox(height: 5),
                      Text(
                        '${data.main?.temp}${isCelsius ? "°C" : "°F"} ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        formattedTime,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

