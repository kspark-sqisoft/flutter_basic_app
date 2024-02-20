import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'riverpod_screen_controller.g.dart';
part 'riverpod_screen_controller.freezed.dart';

@riverpod
Future<int> age(AgeRef ref) async {
  print('ageProvider');
  ref.onDispose(() {
    print('ageProvider onDispose');
  });
  await Future.delayed(const Duration(seconds: 1));
  return 44;
}

@riverpod
class RiverpodScreenController extends _$RiverpodScreenController {
  Timer? _timer;
  int _index = 0;

  final _samplePhones = [
    [Phone(id: '0', name: 'iInone X')],
    [Phone(id: '1', name: 'iInone 11')],
    [Phone(id: '2', name: 'iInone 12')],
  ];

  Object? _key; // 1. create a key

  @override
  FutureOr<List<Phone>> build() async {
    print('RiverpodScreenControllerProvider build');
    //other provider

    final age = await ref.watch(ageProvider
        .future); //read:읽고 바로 ageProvider dispose, watch:riverpodScreenControllerProvider가 dispose 되고 dispose
    print('age=$age');

    _key = Object();
    ref.onDispose(
      () {
        print('RiverpodScreenControllerProvider onDispose');
        _timer?.cancel();
        _key = null;
      },
    );

    init();

    return fetchPhones(_index);
  }

  void init() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      _index = _index + 1;
      if (_index > _samplePhones.length - 1) {
        _index = 0;
      }

      state = const AsyncValue.loading();

      final key = _key;
      final newState =
          await AsyncValue.guard(() async => await fetchPhones(_index));
      if (key == _key) {
        state = newState;
      }
    });
  }

  Future<List<Phone>> fetchPhones(int index) async {
    await Future.delayed(const Duration(seconds: 1));
    if (index == 2) {
      throw Exception('my error');
    }
    return _samplePhones[index];
  }
}

@freezed
class Phone with _$Phone {
  factory Phone({
    required String id,
    required String name,
  }) = _Phone;
  factory Phone.fromJson(Map<String, dynamic> json) => _$PhoneFromJson(json);
}
