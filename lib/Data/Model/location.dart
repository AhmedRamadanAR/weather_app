import 'package:hive/hive.dart';

part 'location.g.dart';

@HiveType(typeId: 1)
class LocationModel extends HiveObject {
  @HiveField(0)
  double? lat ;

  @HiveField(1)
  double? lon;

  @HiveField(2)
  String? cityName;

  @HiveField(3)
  String? unit;

  LocationModel({required this.lat, required this.lon, required this.cityName,required this.unit});
  LocationModel copyWith({
    double? lat,
    double? lon,
    String? cityName,
    String? unit,
  }) {
    return LocationModel(
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      cityName: cityName ?? this.cityName,
      unit:unit ?? this.unit,
    );
  }

}
