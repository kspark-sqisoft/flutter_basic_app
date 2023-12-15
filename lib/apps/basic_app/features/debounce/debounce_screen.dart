import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

class Data {
  final int id;
  final int gap;
  Data({
    required this.id,
    required this.gap,
  });

  @override
  String toString() {
    return '$id';
  }
}

class DataAndStartTime {
  final Data data;
  final int rxTime;
  DataAndStartTime({required this.data, required this.rxTime});
  @override
  String toString() {
    return '$data';
  }
}

List<int> gaps = [1, 1, 2, 1, 3, 1, 1, 2, 1, 1, 1, 4, 1, 5, 2, 1, 1];

Stream<Data> rawStream() async* {
  for (int i = 0; i < gaps.length; i++) {
    await Future.delayed(Duration(seconds: gaps[i]));
    yield Data(id: i + 1, gap: gaps[i]);
  }
}

final rawStreamProvider = StreamProvider.autoDispose((ref) => rawStream());
const double boxSize = 50;

class DebounceScreen extends ConsumerStatefulWidget {
  const DebounceScreen({super.key});

  @override
  ConsumerState<DebounceScreen> createState() => _DebounceScreenState();
}

class _DebounceScreenState extends ConsumerState<DebounceScreen> {
  final List<Data> _datas = [];
  final List<DataAndStartTime> _rxThrottleDatas = [];
  final List<DataAndStartTime> _rxDebounceDatas = [];
  int _timeSec = 0;

  int _rxThrottleTime = 0;
  int _rxThrottlePrevTime = 0;

  int _rxDebounceTime = 0;
  int _rxDebouncePrevTime = 0;

  static const int _throttleGap = 2;
  static const int _debounceGap = 2;

  Timer? _timer;

  @override
  void initState() {
    ref.listenManual(rawStreamProvider, (previous, next) {
      _datas.add(next.value!);
      _setState();
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _timeSec++;
      _setState();
      if (_timeSec > 50) {
        _timer?.cancel();
      }
    });

    final throttleTime =
        rawStream().throttleTime(const Duration(seconds: _throttleGap));
    throttleTime.listen(
      (event) {
        //print('throttleTime:$event ${DateTime.now().second}');
        _rxThrottleTime = _timeSec - _rxThrottlePrevTime;
        _rxThrottleDatas
            .add(DataAndStartTime(data: event, rxTime: _rxThrottleTime));
        _rxThrottlePrevTime = _timeSec;

        _setState();
      },
    );

    final debounceTime =
        rawStream().debounceTime(const Duration(seconds: _debounceGap));
    debounceTime.listen(
      (event) {
        //print('throttleTime:$event ${DateTime.now().second}');
        _rxDebounceTime = _timeSec - _rxDebouncePrevTime;
        _rxDebounceDatas
            .add(DataAndStartTime(data: event, rxTime: _rxDebounceTime));
        _rxDebouncePrevTime = _timeSec;

        _setState();
      },
    );

    super.initState();
  }

  void _setState() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debounce Throttle')),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FractionallySizedBox(
            heightFactor: 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Time $_timeSec',
                  style: const TextStyle(fontSize: 20),
                ),
                Flexible(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _timeSec,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: 1 * boxSize,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: boxSize,
                              height: boxSize,
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(7))),
                                  child: Center(
                                      child: Text(
                                    (index + 1).toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Original Event',
                  style: TextStyle(fontSize: 20),
                ),
                Flexible(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _datas.length,
                    itemBuilder: (context, index) {
                      var data = _datas[index];
                      return SizedBox(
                        width: data.gap * boxSize,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: boxSize,
                              height: boxSize,
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7))),
                                  child: Center(
                                      child: Text(
                                    data.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Throttle Event gap:$_throttleGap',
                  style: TextStyle(fontSize: 20),
                ),
                const Text(
                    '처음건 무조건 발동($_throttleGap)건너띄고, 이후 일정 주기($_throttleGap)마다 실행 보장'),
                const Text('무한 스크롤링'),
                Flexible(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _rxThrottleDatas.length,
                    itemBuilder: (context, index) {
                      var data = _rxThrottleDatas[index];
                      return SizedBox(
                        width: data.rxTime * boxSize,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: boxSize,
                              height: boxSize,
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.lightGreen,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7))),
                                  child: Center(
                                      child: Text(
                                    data.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Debounce Event gap:$_debounceGap',
                  style: TextStyle(fontSize: 20),
                ),
                const Text('연속 이벤트 마지막(이전 이벤트 무시)을 일정 주기($_debounceGap) 후 발동'),
                const Text('Ajax 자동 완성 키 누르기, 리사이즈'),
                Flexible(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _rxDebounceDatas.length,
                    itemBuilder: (context, index) {
                      var data = _rxDebounceDatas[index];
                      return SizedBox(
                        width: data.rxTime * boxSize,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: boxSize,
                              height: boxSize,
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.lightBlue,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7))),
                                  child: Center(
                                      child: Text(
                                    data.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
