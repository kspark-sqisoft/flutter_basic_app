import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'riverpod_screen_controller.dart';

class RiverpodScreen extends ConsumerStatefulWidget {
  const RiverpodScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RiverpodScreenState();
}

class _RiverpodScreenState extends ConsumerState<RiverpodScreen> {
  @override
  void initState() {
    print('_RiverpodScreenState initState');

    /*
    ref.listenManual(riverpodScreenControllerProvider, (previous, next) {
      print(next);
    });
    */

    super.initState();
  }

  Future<int> getNum() async {
    return 1;
  }

  Future<int> getNumX() async => await getNum();

  @override
  void dispose() {
    print('_RiverpodScreenState dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('_RiverpodScreenState build');
    final riverpodScreenController =
        ref.watch(riverpodScreenControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod'),
      ),
      body: Center(
        child: riverpodScreenController.when(
          //skipLoadingOnReload: true,
          data: (data) {
            return Text(data.toString());
          },
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
