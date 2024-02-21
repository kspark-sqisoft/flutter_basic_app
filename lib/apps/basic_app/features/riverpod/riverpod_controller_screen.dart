import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'riverpod_screen_controller.dart';

class RiverpodControllerScreen extends ConsumerStatefulWidget {
  const RiverpodControllerScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RiverpodControllerScreenState();
}

class _RiverpodControllerScreenState
    extends ConsumerState<RiverpodControllerScreen> {
  @override
  void initState() {
    print('_RiverpodControllerScreenState initState');

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
    print('_RiverpodControllerScreenState build');
    final AsyncValue<List<Phone>> riverpodScreenController =
        ref.watch(riverpodScreenControllerProvider);

    print('state:${riverpodScreenController.toStr}');
    print('props:${riverpodScreenController.props}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('RiverpodController'),
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
