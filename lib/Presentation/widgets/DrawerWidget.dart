import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_pro/Presentation/providers/unit_provider.dart';
import 'package:weather_pro/Presentation/theme/theme_provider.dart';

import '../../Data/local/const.dart';
import '../providers/notifications_provider.dart';
import 'ReusableSwitch.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<StatefulWidget> createState() => _DrawerState();
}

class _DrawerState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    var unitProvider = Provider.of<UnitProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
     var notificationsProvider = Provider.of<NotificationsProvider>(context);
    return Container(margin: EdgeInsets.all(3),
      child: Drawer(shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
        topRight: Radius.circular(50),
        bottomRight: Radius.circular(50),
      ),),
        elevation: 1,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(

              children: [
                const Image(
                    image: AssetImage('assets/images/blue_settings.png'),
                    width: 140,
                    height: 140),
                Divider(
                  color: Colors.grey[500],
                ),
                ListTile(
                  leading: Text(
                    unitProvider.isCelsius ? "Celsius °C " : "Fahrenheit °F",
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  trailing: ReusableSwitch(
                    value: unitProvider.isCelsius,
                    onChanged: (newValue) {
                      unitProvider.changeSwitchState();
                    },
                    switchType: SwitchType.unit, // Specify switch type
                  ),
                ),
                Divider(
                  color: Colors.grey[500],
                ),
                ListTile(
                  leading: Text(
                    themeProvider.isDarkMode ? "Dark Mode" : "Light Mode",
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  trailing: ReusableSwitch(
                    value: themeProvider.isDarkMode,
                    onChanged: (newValue) {
                    },
                    switchType: SwitchType.theme, // Specify switch type
                  ),
                ),
                Divider(
                  color: Colors.grey[500],
                ),
                ListTile(
                  leading: Text(
                    notificationsProvider.sendAlert ? "Send Alerts":"Stop Alerts",
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),

                  trailing: ReusableSwitch(
                    value: notificationsProvider.sendAlert,
                    onChanged: (newValue) {
                    },
                    switchType: SwitchType.alerts, // Specify switch type
                  ),
                ),
                Divider(
                  color: Colors.grey[500],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
