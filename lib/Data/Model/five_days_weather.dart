
import 'package:json_annotation/json_annotation.dart';
part 'five_days_weather.g.dart';
@JsonSerializable()
class FiveDaysWeather {
  String? cod;
  int? message;
  int? cnt;
  List<FiveDaysWeatherData>? list;
  City? city;

  FiveDaysWeather({
    required this.message,
    required this.cnt,
    required this.cod,
    required this.list,
    required this.city,
  });
  factory FiveDaysWeather.fromJson(Map<String, dynamic> json) =>
      _$FiveDaysWeatherFromJson(json);
}
@JsonSerializable()

class City {
  int? id;
  String? name;
  Coord? coord;
  String? country;
  int? population;
  int? timezone;
  int? sunrise;
  int? sunset;
  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });
  factory City.fromJson(Map<String, dynamic> json) =>
      _$CityFromJson(json);
}
@JsonSerializable()

class Coord {
  double? lat;
  double? lon;

  Coord({
    required this.lat,
    required this.lon,
  });
  factory Coord.fromJson(Map<String, dynamic> json) =>
      _$CoordFromJson(json);
}
@JsonSerializable()
class FiveDaysWeatherData {
  int? dt;
  MainClass? main;
  List<Weather>? weather;
  Clouds? clouds;
  Wind? wind;
  int? visibility;
  int? pop;
  Sys? sys;
  String? dtTxt;

  FiveDaysWeatherData({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.dtTxt,
  });
  factory FiveDaysWeatherData.fromJson(Map<String, dynamic> json) =>
      _$FiveDaysWeatherDataFromJson(json);
}
@JsonSerializable()

class Clouds {
  int? all;

  Clouds({
    required this.all,
  });
  factory Clouds.fromJson(Map<String, dynamic> json) =>
      _$CloudsFromJson(json);
}
@JsonSerializable()

class MainClass {
  double? temp;
  double? feelsLike;
  double? temp_min;
  double? temp_max;
  int? pressure;
  int? seaLevel;
  int? grndLevel;
  int? humidity;
  double? tempKf;

  MainClass({
    required this.temp,
    required this.feelsLike,
    required this.temp_min,
    required this.temp_max,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });
  factory MainClass.fromJson(Map<String, dynamic> json) =>
      _$MainClassFromJson(json);
}
@JsonSerializable()

class Sys {
  String? pod;

  Sys({
    required this.pod,
  });
  factory Sys.fromJson(Map<String, dynamic> json) =>
      _$SysFromJson(json);
}

@JsonSerializable()

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;


  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });
  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
}


@JsonSerializable()

class Wind {
  double? speed;
  int? deg;
  double? gust;
  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });
  factory Wind.fromJson(Map<String, dynamic> json) =>
      _$WindFromJson(json);
}
