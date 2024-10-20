import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_pro/Presentation/widgets/searchbar_widget.dart';

import '../cubit/current_weather_cubit.dart';
import '../cubit/current_weather_state.dart';
import '../providers/unit_provider.dart';
import '../widgets/DrawerWidget.dart';
import '../widgets/chart.dart';
import '../widgets/weather_forecast.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var unitProvider = Provider.of<UnitProvider>(context);
    var isCelsius = unitProvider.isCelsius;
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        elevation: 5,
        title: const Text(
          "Weather Pro",
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          print(state.toString());
          if (state is WeatherLoaded) {
            print(
                "https://openweathermap.org/img/wn/${state.currentWeather?.weather?[0].icon}.png");
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: const BoxDecoration(
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
                        padding: const EdgeInsets.all(40),
                        child: SearchBarWidget(unitProvider: unitProvider,
                            textEditingController: textEditingController,
                            onSearchClicked: () {
                              context
                                  .read<WeatherCubit>()
                                  .addCity(textEditingController.text);

                              context
                                  .read<WeatherCubit>()
                                  .getCurrent_FiveDaysWeatherByCity(
                                      textEditingController.text);
                            })),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: WeatherHourlyForecast(
                        date: state.currentWeather!.dt!,
                        feelsLike:
                            '${state.currentWeather?.main?.feels_like.toString()}${isCelsius ? "°C" : "°F"}',
                        temperature:
                            '${state.currentWeather?.main?.temp}${isCelsius ? "°C" : "°F"} ',
                        location: "${state.currentWeather?.name.toString()}",
                        maxTemp:
                            '${state.currentWeather?.main?.temp_max}${isCelsius ? "°C" : "°F"}',
                        minTemp:
                            '${state.currentWeather?.main?.temp_min}${isCelsius ? "°C" : "°F"}',
                        imageUrl:
                            "https://openweathermap.org/img/wn/${state.currentWeather?.weather?[0].icon}.png",
                        weatherDescription: state
                            .currentWeather!.weather![0].description
                            .toString(),
                        humidity: "${state.currentWeather?.main?.humidity}%",
                        clouds: "${state.currentWeather?.clouds?.all}%",
                        windSpeed:
                            "${isCelsius ? "${state.currentWeather!.wind!.speed} m/sec" : "${state.currentWeather!.wind!.speed} miles/hr"} ",
                        forecastData: state.fiveDaysWeather!.list!,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child:
                          MyChart(fiveDaysData: state.fiveDaysWeather!.list!),
                    ),
                  ],
                )),
              ),
            );
          }
          if (state is WeatherLoading) {
            return Center(
                child: Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(color: Colors.blue, width: 2.0),
              ),
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                strokeWidth: 5.0,
              ),
            ));
          }
          if (state is WeatherError) {
            return Center(
                child: SearchBarWidget(unitProvider: unitProvider,
                    textEditingController: textEditingController,
                    onSearchClicked: () {
                      context
                          .read<WeatherCubit>()
                          .addCity(textEditingController.text);

                      context
                          .read<WeatherCubit>()
                          .getCurrent_FiveDaysWeatherByCity(
                              textEditingController.text);
                    }));
          } else {
            return const Center();
          }
        },
      ),
    );
  }
}
