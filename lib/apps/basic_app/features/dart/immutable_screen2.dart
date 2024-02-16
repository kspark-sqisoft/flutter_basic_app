import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'immutable_screen.dart';

part 'immutable_screen2.freezed.dart';
part 'immutable_screen2.g.dart';

class MutableClass {
  int id;
  int level;
  List<int> list;
  MutableClass({required this.id, required this.level, required this.list});
  @override
  String toString() {
    return 'MutableClass(id:$id, level:$level, list:$list)';
  }
}

@immutable
class IMMutableClass {
  final int id;
  final int level;
  final List<int> list;
  const IMMutableClass(
      {required this.id, required this.level, required this.list});
  IMMutableClass copyWith({int? id, int? level, List<int>? list}) {
    return IMMutableClass(
        id: id ?? this.id, level: level ?? this.level, list: list ?? this.list);
  }

  @override
  bool operator ==(Object other) {
    return other is IMMutableClass &&
        other.id == id &&
        other.level == level &&
        //other.list == list; //이렇게만 하면 안된다.
        const DeepCollectionEquality().equals(other.list, list);
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, id, level,
        const DeepCollectionEquality().hash(list)); //list 만 하면 안된다.
  }

  @override
  String toString() {
    return 'IMMutableClass(id:$id, level:$level, list:$list)';
  }
}

@freezed
class FreezedClass with _$FreezedClass {
  const factory FreezedClass({
    int? id,
    int? level,
    List<int>? list,
  }) = _FreezedClass;
  factory FreezedClass.fromJson(Map<String, dynamic> json) =>
      _$FreezedClassFromJson(json);
}

class ImmutableScreen2 extends StatefulWidget {
  const ImmutableScreen2({super.key});

  @override
  State<ImmutableScreen2> createState() => _ImmutableScreen2State();
}

class MyClass {
  final List<int> datas;
  const MyClass({required this.datas});
}

class _ImmutableScreen2State extends State<ImmutableScreen2> {
  @override
  void initState() {
    int a = 1;
    int b = a;
    print('a=$a');
    print('b=a, b=$b');
    print('a.hashCode=${a.hashCode}');
    print('b.hashCode=${b.hashCode}');
    print('a==b ${a == b}');
    b = 2;
    print('b=2 복사본 b 값 변경');
    print('a=$a');
    print('b=$b');
    print('a.hashCode=${a.hashCode}');
    print('b.hashCode=${b.hashCode}');
    print('a==b ${a == b}');
    b = 1;
    print('b=2 복사본 b 값 변경');
    print('a=$a');
    print('b=$b');
    print('a.hashCode=${a.hashCode}');
    print('b.hashCode=${b.hashCode}');
    print('a==b ${a == b}');

    Battery battery1 = Battery(id: 0, level: 20);
    Battery battery2 = battery1;

    print('battery1=$battery1');
    print('battery2=battery1, battery2=$battery2');
    print('battery1.hashCode=${battery1.hashCode}');
    print('battery2.hashCode=${battery2.hashCode}');
    print('battery1==battery2 ${battery1 == battery2}');

    battery2.id = 1;
    battery2.level = 50;
    print('battery1=$battery1');
    print('battery2=$battery2');
    print('battery1.hashCode=${battery1.hashCode}');
    print('battery2.hashCode=${battery2.hashCode}');
    print('battery1==battery2 ${battery1 == battery2}');

    battery2.id = 0;
    battery2.level = 20;
    print('battery1=$battery1');
    print('battery2=$battery2');
    print('battery1.hashCode=${battery1.hashCode}');
    print('battery2.hashCode=${battery2.hashCode}');
    print('battery1==battery2 ${battery1 == battery2}');

    IMBattery imbattery1 = const IMBattery(id: 0, level: 20);
    IMBattery imbattery2 = imbattery1;
    print('imbattery1=$imbattery1');
    print('imbattery2=$imbattery2');
    print('imbattery1.hashCode=${imbattery1.hashCode}');
    print('imbattery2.hashCode=${imbattery2.hashCode}');

    imbattery2 = imbattery1.copyWith(level: 50);
    print('imbattery1=$imbattery1');
    print('imbattery2=$imbattery2');
    print('imbattery1.hashCode=${imbattery1.hashCode}');
    print('imbattery2.hashCode=${imbattery2.hashCode}');

    imbattery2 = imbattery1.copyWith(id: 0, level: 20);
    print('imbattery1=$imbattery1');
    print('imbattery2=$imbattery2');
    print('imbattery1.hashCode=${imbattery1.hashCode}');
    print('imbattery2.hashCode=${imbattery2.hashCode}');

    List<int> list1 = [1, 2, 3];
    List<int> list2 = [1, 2, 3];
    print(list1 == list2);

    UnmodifiableListView<int> ulist1 = UnmodifiableListView<int>(list1);
    UnmodifiableListView<int> ulist2 = UnmodifiableListView<int>(list2);
    print(ulist1 == ulist2);

    bool areEqual = const DeepCollectionEquality().equals(list1, list2);
    print(areEqual);

    MutableClass mutableClass1 = MutableClass(id: 0, level: 10, list: [1, 2]);
    MutableClass mutableClass2 = mutableClass1;
    print('mutableClass1:$mutableClass1');
    print('mutableClass2:$mutableClass2');
    print('mutableClass1.hashCode:${mutableClass1.hashCode}');
    print('mutableClass2.hashCode:${mutableClass2.hashCode}');
    print('mutableClass1 == mutableClass2 ${mutableClass1 == mutableClass2}');
    mutableClass2.list = [10, 20];
    print('mutableClass1:$mutableClass1');
    print('mutableClass2:$mutableClass2');
    print('mutableClass1.hashCode:${mutableClass1.hashCode}');
    print('mutableClass2.hashCode:${mutableClass2.hashCode}');
    print('mutableClass1 == mutableClass2 ${mutableClass1 == mutableClass2}');

    IMMutableClass imMutableClass1 =
        const IMMutableClass(id: 0, level: 10, list: [1, 2]);
    IMMutableClass imMutableClass2 = imMutableClass1;
    print('imMutableClass1:$imMutableClass1');
    print('imMutableClass2:$imMutableClass2');
    print('imMutableClass1.hashCode:${imMutableClass1.hashCode}');
    print('imMutableClass2.hashCode:${imMutableClass2.hashCode}');
    print(
        'imMutableClass1 == imMutableClass2 ${imMutableClass1 == imMutableClass2}');

    imMutableClass2 = imMutableClass1.copyWith(list: [10, 20]);
    print('imMutableClass1:$imMutableClass1');
    print('imMutableClass2:$imMutableClass2');
    print('imMutableClass1.hashCode:${imMutableClass1.hashCode}');
    print('imMutableClass2.hashCode:${imMutableClass2.hashCode}');
    print(
        'imMutableClass1 == imMutableClass2 ${imMutableClass1 == imMutableClass2}');

    imMutableClass2 = imMutableClass1.copyWith(list: [1, 2]);
    print('imMutableClass1:$imMutableClass1');
    print('imMutableClass2:$imMutableClass2');
    print('imMutableClass1.hashCode:${imMutableClass1.hashCode}');
    print('imMutableClass2.hashCode:${imMutableClass2.hashCode}');
    print(
        'imMutableClass1 == imMutableClass2 ${imMutableClass1 == imMutableClass2}');

    FreezedClass freezedClass1 =
        const FreezedClass(id: 0, level: 10, list: [1, 2]);
    FreezedClass freezedClass2 = freezedClass1;
    print('freezedClass1:$freezedClass1');
    print('freezedClass2:$freezedClass2');
    print('freezedClass1.hashCode:${freezedClass1.hashCode}');
    print('freezedClass2.hashCode:${freezedClass2.hashCode}');
    print('freezedClass1 == freezedClass2 ${freezedClass1 == freezedClass2}');

    freezedClass2 = freezedClass1.copyWith(list: [10, 20]);
    print('freezedClass1:$freezedClass1');
    print('freezedClass2:$freezedClass2');
    print('freezedClass1.hashCode:${freezedClass1.hashCode}');
    print('freezedClass2.hashCode:${freezedClass2.hashCode}');
    print('freezedClass1 == freezedClass2 ${freezedClass1 == freezedClass2}');

    freezedClass2 = freezedClass1.copyWith(list: [1, 2]);
    print('freezedClass1:$freezedClass1');
    print('freezedClass2:$freezedClass2');
    print('freezedClass1.hashCode:${freezedClass1.hashCode}');
    print('freezedClass2.hashCode:${freezedClass2.hashCode}');
    print('freezedClass1 == freezedClass2 ${freezedClass1 == freezedClass2}');

    List<int> myMutableList = mutableClass1.list;
    myMutableList.add(3);
    print('myMutableList=$myMutableList');

    /*
    수정 할수 없는 리스트를 수정 하려고 하면 에러 발생
    Unsupported operation: Cannot add to an unmodifiable list

    List<int> myIMMutableList = imMutableClass1.list;
    myIMMutableList.add(3);
    print('myIMMutableList=$myIMMutableList');

    List<int> myFreezedList = freezedClass1.list!;
    myFreezedList.add(3);
    print('myFreezedList=$myFreezedList');
    */

    List<int> myIMMutableList = List<int>.from(
        imMutableClass1.list); //UnmodifiableList를 MutableList로 변경
    myIMMutableList.add(3);
    print('myIMMutableList=$myIMMutableList');

    List<int> myFreezedList = List<int>.from(freezedClass1.list!);
    myFreezedList.add(3);
    print('myFreezedList=$myFreezedList');

    MyClass myClass = const MyClass(datas: [1, 2, 3, 4]);
    List<int> myClassList = List.from(myClass.datas);
    print('myClassList=$myClassList');
    myClassList.add(5);
    print('myClassList=$myClassList');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Immutable vs Mutable 2')),
    );
  }
}
