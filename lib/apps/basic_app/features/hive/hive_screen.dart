import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data.dart';

class HiveScreen extends StatefulWidget {
  const HiveScreen({super.key});

  @override
  State<HiveScreen> createState() => _HiveScreenState();
}

class _HiveScreenState extends State<HiveScreen> {
  @override
  void initState() {
    //deep equality
    final datas1 = [Data(id: 1, message: 'a'), Data(id: 2, message: 'b')];
    final datas2 = [Data(id: 1, message: 'a'), Data(id: 2, message: 'b')];
    print('data1==data2 : ${datas1 == datas2}');
    print(
        'data1==data2 : ${const DeepCollectionEquality().equals(datas1, datas2)}');
    initHiveDB();
    super.initState();
  }

  Future<void> initHiveDB() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(DataAdapter());
    }

    var dataBox = await Hive.openBox('data');

    print('dataBox.values=${dataBox.values}');
    await dataBox.put('name', 'younga');
    await dataBox.put('datas', [
      Data(id: 4, message: '4'),
      Data(id: 5, message: '5'),
      Data(id: 6, message: '6')
    ]);
    print('name=${dataBox.get('name')}');
    print(
        'datas.runtimeType=${dataBox.get('name').runtimeType} datas=${dataBox.get('datas')}');

    final datas =
        (dataBox.get('datas') as List).map<Data>((data) => data).toList();
    print('datas.runtimeType=${datas.runtimeType}  datas=$datas');

    //await dataBox.add('bbumi'); //중복 허용
    //await dataBox.deleteAt(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hive')),
    );
  }
}
