import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:weather_pro/Presentation/providers/notifications_provider.dart';

import '../../Data/local/const.dart';
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
    return Switch(
      activeColor: const Color.fromARGB(255, 12, 66, 172),
      value: value,
      onChanged: (newValue) async {
        onChanged(newValue);

        switch (switchType) {
          case SwitchType.unit:
            final weatherCubit = context.read<WeatherCubit>();
            weatherCubit.updateUnit(newValue);

            final currentLocation = weatherCubit.weatherRepo.getLocation();

            final updatedLocation = currentLocation.copyWith(
              unit: newValue
                  ? WeatherUnit.metric.name
                  : WeatherUnit.imperial.name,
              cityName: currentLocation.cityName,
            );

            weatherCubit.updatLocation(updatedLocation);

            weatherCubit.initializeWeatherData();
            break;
          case SwitchType.theme:
            final themeProvider =
                Provider.of<ThemeProvider>(context, listen: false);
            themeProvider.changeSwitchState();
            break;
          case SwitchType.alerts:
            final notificationProvider =
                Provider.of<NotificationsProvider>(context, listen: false);
            notificationProvider.changeSwitchState();
            if (newValue) {
              if (await Permission.notification.isGranted) {
                final weatherCubit = context.read<WeatherCubit>();
                if (weatherCubit.weatherRepo.getAlert()) {
                  weatherCubit
                      .sendAlerts(weatherCubit.myCurrentWeather!.main!.temp!);
                }
              } else {
                _requestNotificationPermissions(context).then((isGranted) {
                  if (isGranted) {
                    final weatherCubit = context.read<WeatherCubit>();
                    if (weatherCubit.weatherRepo.getAlert()) {
                      weatherCubit.sendAlerts(
                          weatherCubit.myCurrentWeather!.main!.temp!);
                    }
                  } else {
                    onChanged(false);
                    notificationProvider.changeSwitchState();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'Notification permission denied. Please enable it in settings.')),
                    );
                  }
                });
              }
            }
            break;
        }
      },
    );
  }

  Future<bool> _requestNotificationPermissions(BuildContext context) async {
    final status = await Permission.notification.request();
    if (status.isGranted) {
      print('Notification permission granted');
      return true;
    } else if (status.isDenied || status.isPermanentlyDenied) {
      await openAppSettings();
      print('Notification permission denied');
      return false;
    } else {
      return false;
    }
  }
}
