import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'data.dart';

class HiveScreen2 extends StatefulWidget {
  const HiveScreen2({super.key});

  @override
  State<HiveScreen2> createState() => _HiveScreen2State();
}

class _HiveScreen2State extends State<HiveScreen2> {
  late Box<Data> dataBox;

  @override
  void initState() {
    initHiveDB();
    super.initState();
  }

  Future<void> initHiveDB() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(DataAdapter());
    }

    dataBox = await Hive.openBox<Data>('MyData');

    print('dataBox.values=${dataBox.values}');

    final datas = dataBox.values.map<Data>((data) => data).toList();
    print('datas:$datas');

    await dataBox.put(0, Data(id: 0, message: '0'));
    await dataBox.put(1, Data(id: 1, message: '1'));
  }

  @override
  void dispose() {
    dataBox.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive 2'),
      ),
    );
  }
}
