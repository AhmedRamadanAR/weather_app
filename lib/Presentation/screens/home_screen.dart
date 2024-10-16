import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../cubit/current_weather_cubit.dart';
import '../cubit/current_weather_state.dart';
import '../providers/unit_provider.dart';
import '../widgets/DrawerWidget.dart';
import '../widgets/current_weather_widget.dart';
import '../widgets/next_forecast.dart';
import '../widgets/weather_forecast.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var unitProvider = Provider.of<UnitProvider>(context);
var isCelsius=unitProvider.isCelsius;
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
elevation: 5,
        title: Text(
          "Weather Pro",
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          print(state.toString());
          if (state is WeatherLoaded ) {
            print(
                "https://openweathermap.org/img/wn/${state.currentWeather?.weather?[0].icon}.png");
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                    Colors.white54,
                    Color.fromARGB(255, 12, 66, 172)
                  ],
                      begin: AlignmentDirectional.bottomEnd,
                      end: AlignmentDirectional.topStart)),
              child: SafeArea(
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(40),
                        child: SearchBar(
                            controller: textEditingController,
                            onChanged: (value) =>
                                textEditingController.text = value,
                            leading: Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(Icons.search)),
                            trailing: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: GestureDetector(
                                  child: Icon(Icons.gps_fixed),
                                  onTap: () {
                                    final cityName = textEditingController.text;
                                    context
                                        .read<WeatherCubit>()
                                        .addCity(cityName);

                                    context
                                        .read<WeatherCubit>()
                                        .getCurrent_FiveDaysWeatherByCity(cityName);
                                  },
                                ),
                              ),
                            ])),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: WeatherHourlyForecast(
                        date: state.currentWeather!.dt!,
                        feelsLike: '${state.currentWeather?.main?.feels_like.toString()}${isCelsius ? "°C" : "°F"}',
                        temperature: '${state.currentWeather?.main?.temp}${isCelsius ? "°C" : "°F"} ',
                        location: "${state.currentWeather?.name.toString()}",
                        maxTemp: '${state.currentWeather?.main?.temp_max }${isCelsius ? "°C" : "°F"}',
                        minTemp: '${state.currentWeather?.main?.temp_min }${isCelsius ? "°C" : "°F"}',
                        imageUrl:  "https://openweathermap.org/img/wn/${state.currentWeather?.weather?[0].icon}.png",
                        weatherDescription:state.currentWeather!.weather![0]!.description.toString() ,
                        humidity:"${state.currentWeather?.main?.humidity}%",
                        clouds: "${state.currentWeather?.clouds?.all}%",
                        windSpeed: "${isCelsius ? "${state.currentWeather!.wind!.speed} m/sec" : "${state.currentWeather!.wind!.speed} miles/hr"} ",
                        forecastData: state.fiveDaysWeather!.list!,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: NextForecast(
                        forecastData: [
                          {"day": "Monday", "icon": "cloud", "high": "13", "low": "10"},
                          {"day": "Tuesday", "icon": "cloud", "high": "17", "low": "12"},
                          {"day": "Wednesday", "icon": "sunny", "high": "20", "low": "14"},
                        ],
                      ),
                    ),

                   // CurrentWeatherWidget(currentWeather: state.currentWeather!)
                  ],
                )),
              ),
            );
          } else if (state is WeatherLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Text('No weather data available'));
          }
        },
      ),
    );
  }
}

//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//
//
//     print("inside build method");
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Current Weather'),),
//         body: Column(children: [BlocBuilder<WeatherCubit, WeatherState>(
//           builder: (context, state) {
//
//             print("inside builder1");
//             print("State 1"+state.toString());
//             if (state is WeatherLoading) {
//               return Center(child: CircularProgressIndicator());
//             } else if (state is WeatherLoaded) {
//               return Text(state.currentWeather!.weather![0].description.toString() + state.fiveDaysWeather!.cnt.toString());
//             } else if (state is WeatherError) {
//               return Center(child: Text(state.message));
//             } else {
//               return Center(child: Text('No weather data available'));
//             }
//           },
//         ),
//           // BlocBuilder<FiveDaysWeatherCubit,FiveDaysWeatherState>(builder: (context,state){
//           //   print("inside builder2");
//           //
//           //   if (state is FiveDaysWeatherLoading) {
//           //     return Center(child: CircularProgressIndicator());
//           //   } else if (state is FiveDaysWeatherLoaded) {
//           //     return Text(state.fiveDaysWeather.list!.length.toString());
//           //   } else if (state is FiveDaysWeatherError) {
//           //     return Center(child: Text(state.message));
//           //   } else {
//           //     return Center(child: Text('No weather data available'));
//           //   }
//           // })
//         ],)
//
//     );
//   }
//
// }
//
