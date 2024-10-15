import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/current_weather_cubit.dart';
import '../cubit/current_weather_state.dart';
import '../widgets/current_weather_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          print(state.toString());
          if (state is WeatherLoaded) {
            print(
                "https://openweathermap.org/img/wn/${state.currentWeather?.weather?[0].icon}.png");
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                    Color.fromARGB(255, 8, 39, 85),
                    Color.fromARGB(255, 12, 66, 172)
                  ],
                      begin: AlignmentDirectional.topStart,
                      end: AlignmentDirectional.bottomEnd)),
              child: SafeArea(
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    Card(color: Colors.transparent,elevation: 0,
                      child: Container(
                          child: Image(
                              image: AssetImage('assets/images/sun.png'))),
                    ),SizedBox(height: 20,),

                    CurrentWeatherWidget(currentWeather: state.currentWeather!)
                  ],
                )),
              ),
            );
          } else if (state is WeatherLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Text('No weather data available'))
            ;
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
