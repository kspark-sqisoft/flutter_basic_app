import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(DioRef ref, {BaseOptions? baseOptions}) {
  print('dioProvider build');

  ref.onDispose(() {
    print('dioProvider onDispose');
  });
  ref.onAddListener(() {
    print('dioProvider  onAddListener');
  });
  ref.onRemoveListener(() {
    print('dioProvider  onRemoveListener');
  });
  ref.onCancel(() {
    print('dioProvider  onCancel');
  });
  ref.onResume(() {
    print('dioProvider  onResume');
  });
  return Dio(baseOptions);
}
