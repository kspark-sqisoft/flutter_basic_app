import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/widgets/code.dart';

part 'serialization_screen.freezed.dart';
part 'serialization_screen.g.dart';

const weatherJsonString = '''
{
  "city":"seoul",
  "time":"2023-12-05 03:30:38.143609Z", 
  "temp":0.5,
  "temp_min":0.8,
  "temp_max":4.2,
  "sky_type":"sunny",
  "location":{
    "lat":4.2234,
    "lon":1.2984
  }
}
''';

enum SkyType {
  sunny,
  cloudy,
  rainny;

  String toJson() => name;
  static SkyType fromJson(String json) => values.byName(json);
}

@freezed
class Weather with _$Weather {
  @JsonSerializable(explicitToJson: true)
  const factory Weather({
    required String city,
    DateTime? time,
    @Default(0.0) double temp,
    @JsonKey(name: 'temp_min') @Default(0.0) double tempMin,
    @JsonKey(name: 'temp_max') @Default(0.0) double tempMax,
    @JsonKey(name: 'sky_type') required SkyType skyType,
    required Location location,
  }) = _Weather;
  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
}

@freezed
class Location with _$Location {
  const factory Location({
    @Default(0.0) double lat,
    @Default(0.0) double lon,
  }) = _Location;
  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}

class SerializationScreen extends StatelessWidget {
  const SerializationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Weather weather = Weather.fromJson(jsonDecode(weatherJsonString));
    print('weather:$weather');
    final weatherMap = weather.toJson();
    print('weather.toJson():$weatherMap');
    print('original json:${jsonEncode(weatherMap)}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Serialization'),
      ),
      body: const SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Code(
                weatherJsonString,
                title: 'weather.json',
              ),
              SizedBox(
                height: 20,
              ),
              Code(
                r'''
enum SkyType {
  sunny,
  cloudy,
  rainny;

  String toJson() => name;
  static SkyType fromJson(String json) => values.byName(json);
}

class Weather {
  final String city;
  final DateTime? time;
  final double temp;
  final double tempMax;
  final double tempMin;
  final SkyType skyType;
  final Location location;
  Weather(
      {required this.city,
      required this.temp,
      required this.tempMax,
      required this.tempMin,
      required this.skyType,
      required this.location,
      this.time});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'city': city,
      'time': time?.millisecondsSinceEpoch,
      'temp': temp,
      'temp_max': tempMax,
      'temp_min': tempMin,
      'sky_type': skyType.toJson(),
      'location': location.toJson(),
    };
  }

  factory Weather.fromJson(Map<String, dynamic> map) {
    return Weather(
      city: map['city'] as String,
      time: map['time'] != null ? DateTime.parse(map['time'] as String) : null,
      temp: map['temp'] as double,
      tempMax: map['temp_max'] as double,
      tempMin: map['temp_min'] as double,
      skyType: SkyType.fromJson(map['sky_type'] as String),
      location: Location.fromJson(map['location'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() {
    return 'Weather(city:$city, time:$time, temp:$temp, 
    tempMax:$tempMax, tempMin:$tempMin, skyType:$skyType, location:$location)';
  }

  Weather copyWith(
      {String? city,
      ValueGetter<DateTime?>? time,
      double? temp,
      double? tempMax,
      double? tempMin,
      SkyType? skyType,
      Location? location}) {
    return Weather(
        city: city ?? this.city,
        time: time != null ? time() : this.time,
        temp: temp ?? this.temp,
        tempMax: tempMax ?? this.tempMax,
        tempMin: tempMin ?? this.tempMin,
        skyType: skyType ?? this.skyType,
        location: location ?? this.location);
  }

  @override
  bool operator ==(covariant Weather other) {
    if (identical(this, other)) return true;

    return other.city == city &&
        other.time == time &&
        other.temp == temp &&
        other.tempMax == tempMax &&
        other.tempMin == tempMin &&
        other.skyType == skyType &&
        other.location == location;
  }

  @override
  int get hashCode {
    return city.hashCode ^
        time.hashCode ^
        temp.hashCode ^
        tempMax.hashCode ^
        tempMin.hashCode ^
        skyType.hashCode ^
        location.hashCode;
  }
}

class Location {
  final double lat;
  final double lon;
  Location({required this.lat, required this.lon});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'lat': lat,
      'lon': lon,
    };
  }

  factory Location.fromJson(Map<String, dynamic> map) {
    return Location(
      lat: map['lat'] as double,
      lon: map['lon'] as double,
    );
  }

  @override
  String toString() {
    return 'Location(lat:$lat, lon:$lon)';
  }

  Location copyWith({double? lat, double? lon}) {
    return Location(lat: lat ?? this.lat, lon: lon ?? this.lon);
  }

  @override
  bool operator ==(covariant Location other) {
    if (identical(this, other)) return true;

    return other.lat == lat && other.lon == lon;
  }

  @override
  int get hashCode => lat.hashCode ^ lon.hashCode;
}
''',
                title: 'None',
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Code(
                    r'''
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'main.freezed.dart';
part 'main.g.dart';

enum SkyType {
  sunny,
  cloudy,
  rainny,
}

@freezed
class Weather with _$Weather {
  @JsonSerializable(explicitToJson: true)
  const factory Weather({
    required String city,
    DateTime? time,
    @Default(0.0) double temp,
    @JsonKey(name: 'temp_min') @Default(0.0) double tempMin,
    @JsonKey(name: 'temp_max') @Default(0.0) double tempMax,
    @JsonKey(name: 'sky_type') required SkyType skyType,
    required Location location,
  }) = _Weather;
  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
}

@freezed
class Location with _$Location {
  const factory Location({
    @Default(0.0) double lat,
    @Default(0.0) double lon,
  }) = _Location;
  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}
''',
                    title: 'Freezed + JsonSerializable',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Code(
                    r'''
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'main.g.dart';


enum SkyType {
  sunny,
  cloudy,
  rainny;

  String toJson() => name;
  static SkyType fromJson(String json) => values.byName(json);
}

@JsonSerializable(explicitToJson: true)
class Weather extends Equatable {
  final String city;
  final DateTime? time;
  final double temp;
  @JsonKey(name: 'temp_max')
  final double tempMax;
  @JsonKey(name: 'temp_min')
  final double tempMin;
  @JsonKey(name: 'sky_type')
  final SkyType skyType;
  final Location location;
  const Weather(
      {required this.city,
      required this.temp,
      required this.tempMax,
      required this.tempMin,
      required this.skyType,
      required this.location,
      this.time});

  @override
  List<Object?> get props => [city, time, tempMax, tempMin, skyType, location];
  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  @override
  String toString() {
    return 'Weather(city:$city, time:$time, temp:$temp, 
    tempMax:$tempMax, tempMin:$tempMin, skyType:$skyType, location:$location)';
  }

  Weather copyWith(
      {String? city,
      ValueGetter<DateTime?>? time,
      double? temp,
      double? tempMax,
      double? tempMin,
      SkyType? skyType,
      Location? location}) {
    return Weather(
        city: city ?? this.city,
        time: time != null ? time() : this.time,
        temp: temp ?? this.temp,
        tempMax: tempMax ?? this.tempMax,
        tempMin: tempMin ?? this.tempMin,
        skyType: skyType ?? this.skyType,
        location: location ?? this.location);
  }
}

@JsonSerializable()
class Location extends Equatable {
  final double lat;
  final double lon;
  const Location({required this.lat, required this.lon});

  @override
  List<Object?> get props => [lat, lon];
  Map<String, dynamic> toJson() => _$LocationToJson(this);

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  @override
  String toString() {
    return 'Location(lat:$lat, lon:$lon)';
  }

  Location copyWith({
    double? lat,
    double? lon,
  }) {
    return Location(
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
    );
  }
}
''',
                    title: 'Equatable + JsonSerializable',
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
