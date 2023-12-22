import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants/constants.dart';
import 'weather_api_services.dart';

part 'weather_api_services_provider.g.dart';

@riverpod
WeatherApiServices weatherApiServices(WeatherApiServicesRef ref) {
  final options = BaseOptions(
    baseUrl: 'https://$kApiHost',
  );
  return WeatherApiServices(dio: Dio(options));
}
