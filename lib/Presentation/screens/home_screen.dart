import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../cubit/current_weather_cubit.dart';
import '../cubit/current_weather_state.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  // Header Section
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                          Colors.black38,
                          BlendMode.darken,
                        ),
                        image: AssetImage(
                          'assets/images/cloud-in-blue-sky.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: Stack(
                      children: <Widget>[
                        AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          leading: IconButton(
                            icon: Icon(Icons.menu, color: Colors.white),
                            onPressed: () {},
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 100,
                            left: 20,
                            right: 20,
                          ),
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.search, color: Colors.white),
                              hintStyle: TextStyle(color: Colors.white),
                              hintText: 'SEARCH',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 4,  // Ensuring fixed height
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),  // Reduced padding for better fit
                      child: SingleChildScrollView(  // Makes the content scrollable to avoid overflow
                        child: Column(
                          mainAxisSize: MainAxisSize.min,  // Ensure the column takes only necessary height
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              state.currentWeather?.name?.toUpperCase() ?? '',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.blue),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8),  // Add spacing between elements
                            Text(
                              DateFormat().add_MMMMEEEEd().format(DateTime.now()),
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            Divider(thickness: 1, height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        state.currentWeather?.weather?[0].description ?? '22',
                                        style: TextStyle(fontSize: 16,color: Colors.blue),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        '${state.currentWeather?.main?.temp} °C',
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.blue),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Min: ${state.currentWeather?.main?.temp_min} / Max: ${state.currentWeather?.main?.temp_max}',
                                        style: TextStyle(fontSize: 14,color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 20),  // Add space between the two columns
                                Column(
                                  children: <Widget>[
                                    Image.network(
                                      "https://openweathermap.org/img/wn/${state.currentWeather?.weather?[0].icon}.png",
                                      width: 80,  // Adjusted width to fit within the available space
                                      height: 80,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Wind: ${state.currentWeather?.wind?.speed} m/s',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )

              ],
                    ),
                  ),
                  // Other Cities Section
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Other City'.toUpperCase()),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Forecast Next 5 Days'.toUpperCase()),
                            Icon(Icons.next_plan_outlined, color: Colors.black45),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is WeatherLoading) {
            return Center(
              child: Text(
                "Weather loading...",
                style: TextStyle(color: Colors.white),
              ),
            );
          } else {
            return Center(
              child: Text(
                "Something went wrong.",
                style: TextStyle(color: Colors.white),
              ),
            );
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
