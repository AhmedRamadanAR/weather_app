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
  final SwitchType switchType;
  const ReusableSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.switchType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(activeColor: Color.fromARGB(255, 12, 66, 172),
      value: value,
      onChanged: (newValue) {
        onChanged(newValue);

        switch (switchType) {
          case SwitchType.unit:
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
            final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
            themeProvider.changeSwitchState();
            break;
        }
      },
    );
  }
}

enum SwitchType { unit, theme }