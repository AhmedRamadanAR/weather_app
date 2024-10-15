import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_pro/Presentation/providers/unit_provider.dart';
import 'package:weather_pro/Presentation/widgets/switch_widget.dart';

class DrawerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DrawerState();
}

class _DrawerState extends State<DrawerWidget> {


  @override
  Widget build(BuildContext context) {
    var unitProvider = Provider.of<UnitProvider>(context);

    return Drawer(elevation: 1,
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image(image: AssetImage('assets/images/blue_settings.png'),width: 200,height: 180),
            Divider(color: Colors.grey[500],),
            ListTile(
              leading: Text(unitProvider.isCelsius ? "Celsius °C " : "Fahrenheit °F",style: TextStyle(fontSize: 25,fontWeight:FontWeight.w700),),
             trailing: SwitchWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
