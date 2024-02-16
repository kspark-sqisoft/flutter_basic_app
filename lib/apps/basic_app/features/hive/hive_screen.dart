import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data.dart';

class Phone {
  final int id;
  final String name;
  Phone({
    required this.id,
    required this.name,
  });
}

class HiveScreen extends StatefulWidget {
  const HiveScreen({super.key});

  @override
  State<HiveScreen> createState() => _HiveScreenState();
}

class _HiveScreenState extends State<HiveScreen> {
  @override
  void initState() {
    //immutable vs mutable
    int a = 1;
    int b = a;
    print('a=1');
    print('b=a');
    print('a.hashCode:${a.hashCode}');
    print('b.hashCode:${b.hashCode}');
    print('a == b:${a == b}'); //true

    b = 3;
    print('b=3 으로 변경');
    print('a.hashCode:${a.hashCode}');
    print('b.hashCode:${b.hashCode}');
    print('a == b:${a == b}'); //false

    final phone1 = Phone(id: 0, name: 'iPhone');
    final phone2 = Phone(id: 0, name: 'iPhone');
    print('phone1=Phone(id: 0, name: iPhone)');
    print('phone2=Phone(id: 0, name: iPhone)');
    print('phone1.hashCode:${phone1.hashCode}');
    print('phone2.hashCode:${phone2.hashCode}');
    print('phone1 == phone2:${phone1 == phone2}'); //false

    final data1 = Data(id: 10, message: 'keesoon');
    final data2 = Data(id: 10, message: 'keesoon');
    print('data1=Data(id: 0, name: keesoon)');
    print('data2=Data(id: 0, name: keesoon)');
    print('data1.hashCode:${data1.hashCode}');
    print('data2.hashCode:${data2.hashCode}');
    print('data1 == data2:${data1 == data2}');

    final data3 = data1.copyWith(id: 10, message: 'keesoon');
    print('data3=data1.copyWith(id: 10, message: keesoon)');
    print('data3.hashCode:${data3.hashCode}');
    print('data1 == data3:${data1 == data3}');

    //deep equality
    final datas1 = [Data(id: 1, message: 'a'), Data(id: 2, message: 'b')];
    final datas2 = [Data(id: 1, message: 'a'), Data(id: 2, message: 'b')];
    print(datas1.hashCode);
    print(datas2.hashCode);
    print('datas1==datas2 : ${datas1 == datas2}');

    print(
        'deep equality datas1==datas2 : ${const DeepCollectionEquality().equals(datas1, datas2)}');
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
