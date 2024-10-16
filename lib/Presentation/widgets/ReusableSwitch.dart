import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../Data/const.dart';
import '../cubit/current_weather_cubit.dart';
import '../theme/theme_provider.dart';

class ReusableSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final SwitchType switchType; // Enum to define switch type

  const ReusableSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.switchType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: (newValue) {
        onChanged(newValue);

        switch (switchType) {
          case SwitchType.unit:
          // Unit change logic
            final weatherCubit = context.read<WeatherCubit>();
            weatherCubit.updateUnit(newValue);

            final currentLocation= weatherCubit.weatherRepo.getLocation();

            final updatedLocation = currentLocation.copyWith(
              unit: newValue ? WeatherUnit.metric.name : WeatherUnit.imperial.name,
              cityName: currentLocation.cityName,
            );

            weatherCubit.updatLocation(updatedLocation);

            weatherCubit.initializeWeatherData();
            break;
          case SwitchType.theme:
          // Theme change logic
            final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
            themeProvider.changeSwitchState();
            break;
        }
      },
    );
  }
}

// Enum for switch type
enum SwitchType { unit, theme }