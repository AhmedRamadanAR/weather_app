import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Data/const.dart';
import '../cubit/current_weather_cubit.dart';
import '../providers/unit_provider.dart';

class SwitchWidget extends StatelessWidget{
  const SwitchWidget({super.key});


  @override
  Widget build(BuildContext context) {
    var unitProvider = Provider.of<UnitProvider>(context);

    return  Switch(
  value: unitProvider.isCelsius,

        onChanged: (newValue) {
      unitProvider.changeSwitchState();

      final weatherCubit = context.read<WeatherCubit>();
      weatherCubit.updateUnit(newValue);

      final currentLocation = weatherCubit.weatherRepo.getLocation();

      final updatedLocation = currentLocation.copyWith(
        unit: newValue ? WeatherUnit.metric.name : WeatherUnit.imperial.name,
        cityName: currentLocation.cityName,
      );

      weatherCubit.updatLocation(updatedLocation);

      weatherCubit.initializeWeatherData();
    }
    );
  }
}