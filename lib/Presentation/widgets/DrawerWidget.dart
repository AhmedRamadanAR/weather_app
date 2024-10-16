import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_pro/Presentation/providers/unit_provider.dart';
import 'package:weather_pro/Presentation/theme/dark_theme.dart';
import 'package:weather_pro/Presentation/theme/light_theme.dart';
import 'package:weather_pro/Presentation/theme/theme_provider.dart';
import 'package:weather_pro/Presentation/widgets/switch_widget.dart';

import 'ReusableSwitch.dart';

class DrawerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DrawerState();
}

class _DrawerState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    var unitProvider = Provider.of<UnitProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Drawer(
      elevation: 1,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image(
                image: AssetImage('assets/images/blue_settings.png'),
                width: 200,
                height: 180),
            Divider(
              color: Colors.grey[500],
            ),
            ListTile(
              leading: Text(
                unitProvider.isCelsius ? "Celsius °C " : "Fahrenheit °F",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
              trailing: ReusableSwitch(
                value: unitProvider.isCelsius,
                onChanged: (newValue) {
                  unitProvider.changeSwitchState();
                },
                switchType: SwitchType.unit, // Specify switch type
              ),
            ),
            ListTile(
              leading: Text(
                themeProvider.isDarkMode ? "Dark Mode" : "Light Mode",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
              trailing: ReusableSwitch(
                value: themeProvider.isDarkMode,
                onChanged: (newValue) {
                  // No need to call changeSwitchState here, it's handled in ReusableSwitch
                },
                switchType: SwitchType.theme, // Specify switch type
              ),
            ),
          ],
        ),
      ),
    );
  }
}
