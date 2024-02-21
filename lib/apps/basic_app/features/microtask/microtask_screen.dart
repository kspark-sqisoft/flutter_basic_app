import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'microtask_screen.g.dart';

@riverpod
class Message extends _$Message {
  @override
  Future<String> build() async {
    print('messageProvider build');
    await Future.delayed(const Duration(milliseconds: 100));
    print('messageProvider await end ==> result');
    return 'message';
  }

  Future<void> change(String message) async {
    print('messageProvider change');
    await Future.delayed(const Duration(milliseconds: 100));
    state = AsyncData(message);
  }
}

class MicrotaskScreen extends ConsumerStatefulWidget {
  const MicrotaskScreen({super.key});

  @override
  ConsumerState<MicrotaskScreen> createState() => _MicrotaskScreenState();
}

class _MicrotaskScreenState extends ConsumerState<MicrotaskScreen> {
  @override
  void initState() {
    print('_MicrotaskScreenState initState');
    futureFunc();
    Future(
      () => print('future 1'),
    );
    Future(() async {
      await Future.delayed(const Duration(seconds: 2));
      print('future 2');
    });
    Future.microtask(microTask);
    Future.microtask(microTask2);
    Future.microtask(
        () => ref.read(messageProvider.notifier).change('change message'));
    super.initState();
  }

  Future<void> futureFunc() async {
    await Future.delayed(const Duration(seconds: 1));
    print('futureFunc');
  }

  void microTask() {
    print('microTask1');
  }

  Future<void> microTask2() async {
    await Future.delayed(const Duration(seconds: 1));
    print('microTask2');
  }

  @override
  void dispose() {
    print('_MicrotaskScreenState dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('_MicrotaskScreenState build');
    final asyncMessage = ref.watch(messageProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Microtask'),
      ),
      body: switch (asyncMessage) {
        AsyncData(:final value) => Text(value),
        AsyncError(:final error, :final stackTrace) => Text(error.toString()),
        _ => const CircularProgressIndicator(),
      },
    );
  }
}
