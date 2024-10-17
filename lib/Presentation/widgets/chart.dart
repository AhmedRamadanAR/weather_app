import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather_pro/Data/Model/five_days_weather.dart';
import 'package:weather_pro/Presentation/theme/theme_provider.dart';

class MyChart extends StatelessWidget {
  final List<FiveDaysWeatherData> fiveDaysData;

  const MyChart({Key? key, required this.fiveDaysData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 240,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(
              labelStyle: TextStyle(
                  color: themeProvider.isDarkMode
                      ? Colors.white
                      : Color.fromARGB(255, 12, 66, 172),
                  fontSize: 10,
                  fontWeight: FontWeight.w500)),
          series: <ChartSeries<FiveDaysWeatherData, String>>[
            SplineSeries<FiveDaysWeatherData, String>(
              dataSource: fiveDaysData,
              xValueMapper: (FiveDaysWeatherData data, _) {
                final dateTime = DateTime.fromMillisecondsSinceEpoch(
                  data.dt! * 1000,
                  isUtc: true,
                ).toLocal();
                return DateFormat('EEE, hh:mm a').format(dateTime);
              },
              yValueMapper: (FiveDaysWeatherData data, _) => data.main?.temp,
            ),
          ],
        ),
      ),
    );
  }
}
