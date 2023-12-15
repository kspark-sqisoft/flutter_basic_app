// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serialization_screen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeatherImpl _$$WeatherImplFromJson(Map<String, dynamic> json) =>
    _$WeatherImpl(
      city: json['city'] as String,
      time:
          json['time'] == null ? null : DateTime.parse(json['time'] as String),
      temp: (json['temp'] as num?)?.toDouble() ?? 0.0,
      tempMin: (json['temp_min'] as num?)?.toDouble() ?? 0.0,
      tempMax: (json['temp_max'] as num?)?.toDouble() ?? 0.0,
      skyType: $enumDecode(_$SkyTypeEnumMap, json['sky_type']),
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$WeatherImplToJson(_$WeatherImpl instance) =>
    <String, dynamic>{
      'city': instance.city,
      'time': instance.time?.toIso8601String(),
      'temp': instance.temp,
      'temp_min': instance.tempMin,
      'temp_max': instance.tempMax,
      'sky_type': instance.skyType.toJson(),
      'location': instance.location.toJson(),
    };

const _$SkyTypeEnumMap = {
  SkyType.sunny: 'sunny',
  SkyType.cloudy: 'cloudy',
  SkyType.rainny: 'rainny',
};

_$LocationImpl _$$LocationImplFromJson(Map<String, dynamic> json) =>
    _$LocationImpl(
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lon: (json['lon'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$LocationImplToJson(_$LocationImpl instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
    };
