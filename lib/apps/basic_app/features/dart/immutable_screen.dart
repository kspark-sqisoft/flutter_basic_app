import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

//Mutable 한 클래스
class Battery {
  int id;
  int level;
  Battery({this.id = 0, this.level = 0});
  @override
  String toString() {
    return 'Battery(id:$id, level:$level)';
  }
}

//IMMutable 한 클래스
@immutable
class IMBattery {
  final int id;
  final int level;
  const IMBattery({required this.id, required this.level});

  IMBattery copyWith({int? id, int? level}) {
    return IMBattery(id: id ?? this.id, level: level ?? this.level);
  }

  @override
  bool operator ==(Object other) {
    return other is IMBattery && other.id == id && other.level == level;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, id, level);
  }

  @override
  String toString() {
    return 'IMBattery(id:$id, level:$level)';
  }
}

class ImmutableScreen extends StatefulWidget {
  const ImmutableScreen({super.key});

  @override
  State<ImmutableScreen> createState() => _ImmutableScreenState();
}

class _ImmutableScreenState extends State<ImmutableScreen> {
  @override
  void initState() {
    print('#######원시값 - Immutable');
    int a = 1;
    int b = 1;
    int c = a;
    print('a=$a');
    print('b=$b');
    print('c=a, c=$c  복사본과 원본 메모리 같다(생성시)');
    print('a.hashCode=${a.hashCode}');
    print('b.hashCode=${b.hashCode}');
    print('c.hashCode=${c.hashCode}');
    print('a==b ${a == b} true 해시코드 같음, 값 같음');
    print('b==c ${b == c} true 해시코드 같음, 값 같음');
    print('a==c ${a == c} true 해시코드 같음, 값 같음');

    c = 100;
    print('c=100 값 변경, a 값은 변경되지 않음  복사본 변경은 새로운 메모리 생성 원본은 변하지 않음');
    print('a=$a');
    print('b=$b');
    print('c=$c');
    print('a.hashCode=${a.hashCode}');
    print('b.hashCode=${b.hashCode}');
    print('c.hashCode=${c.hashCode}');
    print('a==b ${a == b} true 해시코드 같음, 값 같음');
    print('b==c ${b == c} false 해시코드 다름, 값 다름');
    print('a==c ${a == c} false 해시코드 다름, 값 다름');

    print('#######클래스(..Collections) - Mutable');
    Battery battery1 = Battery(id: 0, level: 20);
    Battery battery2 = Battery(id: 0, level: 20);
    Battery battery3 = battery1;

    print('battery1=$battery1');
    print('battery2=$battery2');
    print('battery3=battery1, battery3=$battery3');
    print('battery1.hashCode=${battery1.hashCode}');
    print('battery2.hashCode=${battery2.hashCode} 값은 같은데 해시코드 다름');
    print('battery3.hashCode=${battery3.hashCode} 원본 메모리와 복사본 메모리 같다(얕은 복사)');
    print(
        'battery1==battery2 ${battery1 == battery2} false 해시코드 다름, 값 같음 ** Mutable=>Immutable는 값이 같으면 해시코드를 같게 해보자');
    print('battery2==battery3 ${battery2 == battery3} false 해시코드 다름, 값 같음');
    print(
        'battery1==battery3 ${battery1 == battery3} true 해시코드 같음, 값 같음  복사본도 수정 전엔 원본 메모리와 같다');

    battery3.level = 90;
    print('battery3.level=90 값 변경, battery1도 같이 변경됨 복사본 메모리 수정은 원본 메모리 수정');
    print('battery1=$battery1');
    print('battery2=$battery2');
    print('battery3=$battery3');
    print('battery1.hashCode=${battery1.hashCode}');
    print('battery2.hashCode=${battery2.hashCode}');
    print('battery3.hashCode=${battery3.hashCode}');
    print('battery1==battery2 ${battery1 == battery2} false 해시코드 다름, 값 다름');
    print('battery2==battery3 ${battery2 == battery3} false 해시코드 다름, 값 다름');
    print('battery1==battery3 ${battery1 == battery3} true 해시코드 같음, 값 같음');

    final batterys1 = [Battery(id: 5, level: 50), Battery(id: 6, level: 60)];
    final batterys2 = [Battery(id: 5, level: 50), Battery(id: 6, level: 60)];
    print('batterys1=$batterys1');
    print('batterys2=$batterys2');
    print('batterys1.hashCode=${batterys1.hashCode}');
    print('batterys2.hashCode=${batterys2.hashCode}');
    print('batterys1==batterys2 ${batterys1 == batterys2} false 해시코드 다름, 값 같음');

    print(
        '깊은 복사 batterys1==batterys2 ${const DeepCollectionEquality().equals(batterys1, batterys2)} false 해시코드 다르고');

    print('#######클래스====> ImMutable');
    IMBattery imbattery1 = const IMBattery(id: 0, level: 20);
    IMBattery imbattery2 = const IMBattery(id: 0, level: 20);
    IMBattery imbattery3 = imbattery1;

    print('imbattery1=$imbattery1');
    print('imbattery2=$imbattery2');
    print('imbattery3=imbattery1, imbattery3=$imbattery3');
    print('imbattery1.hashCode=${imbattery1.hashCode}');
    print('imbattery2.hashCode=${imbattery2.hashCode}');
    print('imbattery3.hashCode=${imbattery3.hashCode}');
    print(
        'imbattery1==imbattery2 ${imbattery1 == imbattery2} true 해시코드 같음, 값 같음');
    print(
        'imbattery2==imbattery3 ${imbattery2 == imbattery3} true 해시코드 같음, 값 같음');
    print(
        'imbattery1==imbattery3 ${imbattery1 == imbattery3} true 해시코드 같음, 값 같음');

    imbattery3 = imbattery1.copyWith(level: 90);
    print(
        'imbattery3 = imbattery1.copyWith(level: 90) 값 변경, imbattery1 값은 변경 되지 않음');
    print('imbattery1=$imbattery1');
    print('imbattery2=$imbattery2');
    print('imbattery3=$imbattery3');
    print('imbattery1.hashCode=${imbattery1.hashCode}');
    print('imbattery2.hashCode=${imbattery2.hashCode}');
    print('imbattery3.hashCode=${imbattery3.hashCode}');
    print(
        'imbattery1==battery2 ${imbattery1 == imbattery2} true 해시코드 같음, 값 같음');
    print(
        'imbattery2==battery3 ${imbattery2 == imbattery3} false 해시코드 다름, 값 다름');
    print(
        'imbattery1==battery3 ${imbattery1 == imbattery3} false 해시코드 다름, 값 같음');

    final imBatterys1 = [
      const IMBattery(id: 5, level: 50),
      const IMBattery(id: 6, level: 60)
    ];
    final imBatterys2 = [
      const IMBattery(id: 5, level: 50),
      const IMBattery(id: 6, level: 60)
    ];
    print('imBatterys1=$imBatterys1');
    print('imBatterys2=$imBatterys2');
    print('imBatterys1.hashCode=${imBatterys1.hashCode}');
    print('imBatterys2.hashCode=${imBatterys2.hashCode}');
    print(
        'imBatterys1==imBatterys2 ${imBatterys1 == imBatterys2} false 해시코드 다름, 값 같음');
    print(
        '깊은 복사 imBatterys1==imBatterys2 ${const DeepCollectionEquality().equals(imBatterys1, imBatterys2)} true 해시코드가 달라도 같다고 할수 있다(내부의 iterlator들이 immutable해야한다)');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Immutable vs Mutable')),
    );
  }
}
