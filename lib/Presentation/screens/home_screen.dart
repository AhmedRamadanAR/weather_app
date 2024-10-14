import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../cubit/current_weather_cubit.dart';
import '../cubit/current_weather_state.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state) {

            if (state is WeatherLoaded) {
              return SingleChildScrollView(
                
                child: Expanded(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              colorFilter:
                                  ColorFilter.mode(Colors.black38, BlendMode.darken),
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
                              Container(
                                child: AppBar(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  leading: IconButton(
                                    icon: Icon(
                                      Icons.menu,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                              //TODO
                              Container(
                                padding:
                                    EdgeInsets.only(top: 100, left: 20, right: 20),
                                child: TextField(
                                  //onChanged: (value) => controller.city = value,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  textInputAction: TextInputAction.search,
                                  //  onSubmitted: (value) => controller.updateWeather(),
                                  decoration: InputDecoration(
                                    suffix: Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                    hintStyle: TextStyle(color: Colors.white),
                                    hintText: 'Search'.toUpperCase(),
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
                                alignment: Alignment(0.0, 1.0),
                                child: SizedBox(
                                  height: 10,
                                  width: 10,
                                  child: OverflowBox(
                                    minWidth: 0.0,
                                    maxWidth: MediaQuery.of(context).size.width,
                                    minHeight: 0.0,
                                    maxHeight:
                                        (MediaQuery.of(context).size.height / 4),
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(horizontal: 15),
                                          width: double.infinity,
                                          height: double.infinity,
                                          child: Card(
                                            color: Colors.white,
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(25),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                //TODO
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      top: 15, left: 20, right: 20),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Center(
                                                        child: Text(
                                                          '${state.currentWeather?.name.toString()}'
                                                              .toUpperCase(),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: Text(
                                                          DateFormat()
                                                              .add_MMMMEEEEd()
                                                              .format(DateTime.now()),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Divider(),
                                                //TODO
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      padding:
                                                          EdgeInsets.only(left: 50),
                                                      child: Column(
                                                        children: <Widget>[
                                                          Text(
                                                            '${state.currentWeather?.weather?[0].description}',
                                                          ),
                                                          SizedBox(height: 10),
                                                          Text(
                                                              '${(state.currentWeather?.main?.temp)}'),
                                                          Text(
                                                            'min: ${state.currentWeather?.main?.tempMin?.toString()} / max: ${state.currentWeather?.main?.tempMax?.toString()}',
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.only(right: 20),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.center,
                                                        children: <Widget>[
                                                          SizedBox(
                                                              width: 120,
                                                              height: 120,
                                                              child: Image.network(
                                                                  "https://openweathermap.org/img/wn/${state.currentWeather?.weather?[0].icon}.png")),
                                                          Container(
                                                            child: Text(
                                                              'wind ${state.currentWeather?.wind?.speed} m/s',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Container(
                                padding: EdgeInsets.only(top: 120),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          'other city'.toUpperCase(),
                                        ),
                                      ),
                                      //  MyList(),
                                      Container(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'forcast next 5 days'.toUpperCase(),
                                            ),
                                            Icon(
                                              Icons.next_plan_outlined,
                                              color: Colors.black45,
                                            ),
                                          ],
                                        ),
                                      ),
                                      //    MyChart(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (State is WeatherLoading) {
              return Center(child: Text("weather loading ",style: TextStyle(color: Colors.white),),);
            } else {
              return Center(child: Text("else ",style: TextStyle(color: Colors.white),),);
            }
          }),
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
