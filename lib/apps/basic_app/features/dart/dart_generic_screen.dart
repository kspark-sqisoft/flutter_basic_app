import 'dart:math';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dart_generic_screen.freezed.dart';

// ==============================================
// 타입 매개 변수
// ==============================================
class Box<T> {
  T value;
  Box(this.value);
}

// ==============================================
// 타입 매개 변수 타입 제한
// ==============================================
class Data {}

class FutureData extends Data {}

class StreamData extends Data {}

class DataManager<T extends Data> {
  final T data;
  DataManager({required this.data});
}

// ==============================================
// 메서드 generic
// ==============================================
T getData<T>(T param) {
  return param;
}

// ==============================================
//
// ==============================================
abstract class IMedia {}

class Photo implements IMedia {}

class Video implements IMedia {}

class MediaRepository<T extends IMedia> {
  final T media;
  MediaRepository({required this.media});
  T getData() {
    return media;
  }
}

// ==============================================
//
// ==============================================
typedef SuccessCallback<R, S> = R Function(S success);
typedef FailCallback<R, F> = R Function(F fail);

sealed class Result<S, F> {
  factory Result.success(S success) = Success;
  factory Result.fail(F fail) = Fail;
  R when<R>(
    SuccessCallback<R, S> successCallback,
    FailCallback<R, F> failCallback,
  );
}

class Success<S, F> implements Result<S, F> {
  final S success;
  Success(this.success);
  @override
  R when<R>(
    SuccessCallback<R, S> successCallback,
    FailCallback<R, F> failCallback,
  ) =>
      successCallback(this.success);
}

class Fail<S, F> implements Result<S, F> {
  F fail;
  Fail(this.fail);
  @override
  R when<R>(SuccessCallback<R, S> successCallback,
          FailCallback<R, F> failCallback) =>
      failCallback(this.fail);
}

// ==============================================
// freezed
// ==============================================
@freezed
class ResultResponse with _$ResultResponse {
  factory ResultResponse.success(String data) = SuccessResponse;
  factory ResultResponse.fail(Exception exception) = FailResponse;
}

extension ResultResponseExtension on ResultResponse {
  String getMessage() => when(
        success: (data) => 'Success $data',
        fail: (exception) => 'Fail ${exception.toString()}',
      );
}

// ==============================================
// freezed
// ==============================================
sealed class Action {
  factory Action.click(Point point) => ClickAction(point: point);
  factory Action.touch(Point point) => TouchAction(point: point);
}

class ClickAction implements Action {
  final Point point;
  ClickAction({required this.point});
}

class TouchAction implements Action {
  final Point point;
  TouchAction({required this.point});
}

class DartGenericScreen extends StatefulWidget {
  const DartGenericScreen({super.key});

  @override
  State<DartGenericScreen> createState() => _DartGenericScreenState();
}

class _DartGenericScreenState extends State<DartGenericScreen> {
  @override
  void initState() {
    var stringBox = Box<String>('Dart');
    print(stringBox);
    var intBox = Box(42);
    print(intBox);

    var dataManager = DataManager(data: FutureData());
    print(dataManager);

    var intData = getData<int>(3);
    print(intData);
    var stringData = getData<String>('keesoon');
    print(stringData);

    var mediaRepository = MediaRepository(media: Photo());
    print(mediaRepository);

    var result = Result.success('success data');
    print(result);
    result.when((success) {
      print('success:$success');
    }, (fail) {
      print('success:$fail');
    });

    //freezed
    var resultResponse = ResultResponse.success('success data');
    print(resultResponse);
    resultResponse.when(
      success: (data) {
        print('success:$data');
      },
      fail: (exception) {
        print('fail:$exception');
      },
    );

    //action
    var action = Action.touch(const Point(10, 20));
    print(action);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dart Generic'),
      ),
    );
  }
}
