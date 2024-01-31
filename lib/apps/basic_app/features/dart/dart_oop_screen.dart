import 'package:flutter/material.dart';

//생성자 초기화 리스트를 사용해 인스턴스 변수 초기화
class Computer {
  final String name;
  final String brend;
  Computer({required String name, required String brend})
      : name = name,
        brend = brend {
    print('생성자 바디 가능');
  }

  factory Computer.factory({required String name, required String brend}) {
    return Computer(name: name, brend: brend);
  }
}

//생성자 초기화 리스트를 사용해 인스턴스 변수 초기화 축약형
class Car {
  final String name;
  final String brend;
  Car({required this.name, required this.brend});

  factory Car.factory({required String name, required String brend}) =>
      Car(name: name, brend: brend);
}

//const 생성자(바디를 가질수 없다.)
class Phone {
  final String name;
  final String brend;
  const Phone({required this.name, required this.brend});

  //주의 아래는 화살표가 아니다.
  factory Phone.factory({required String name, required String brend}) = Phone;
}

mixin Printing {
  void printing() {
    print('I Can print');
  }
}

//FaceID를 Macbook 자식 에게만 사용할수 있다.
mixin FaceID on Macbook {
  void faceID() {
    print('I Can faceID');
  }
}

//
class Laptop {
  final String name;
  final String company;
  final String? color;
  Laptop({
    required this.name,
    required this.company,
    this.color = 'red',
  }) {
    print('Laptop basic constructor');
  }

  void calculate() {
    print('Laptop method calculate');
  }

  @override
  String toString() {
    return 'Laptop(name:$name, company:$company, color:$color)';
  }
}

class Macbook extends Laptop with Printing {
  final String screen;
  Macbook({
    required super.name,
    required super.company,
    super.color,
    required this.screen,
  }) {
    print('Macbook basic constructor');
  }

  @override
  void calculate() {
    print('Macbook method calculate');
  }

  @override
  String toString() {
    return 'Macbook(name:$name, company:$company, color:$color, screen:$screen)';
  }
}

class MacbookAir extends Macbook with FaceID {
  MacbookAir({
    required super.name,
    required super.company,
    required super.color,
    required super.screen,
  });
  @override
  String toString() {
    return 'MacbookAir(name:$name, company:$company, color:$color, screen:$screen)';
  }
}

class SPC extends Laptop with Printing {
  SPC({
    required super.name,
    required super.company,
    super.color,
  }) {
    print('SPC basic constructor');
  }

  @override
  String toString() {
    return 'SPC(name:$name, company:$company, color:$color)';
  }
}

class DartOOPScreen extends StatefulWidget {
  const DartOOPScreen({super.key});

  @override
  State<DartOOPScreen> createState() => _DartOOPScreenState();
}

class _DartOOPScreenState extends State<DartOOPScreen> {
  @override
  void initState() {
    Macbook macbook = Macbook(
        name: 'macbook pro',
        company: 'apple',
        color: 'silver',
        screen: 'small');
    print(macbook);
    macbook.calculate();
    macbook.printing();

    MacbookAir macbookAir = MacbookAir(
        name: 'macbook air',
        company: 'apple',
        color: 'silver',
        screen: 'small');
    print(macbookAir);
    macbookAir.calculate();
    macbookAir.printing();
    macbookAir.faceID();

    SPC spc = SPC(
      name: 'dell scp 9500',
      company: 'dell',
      color: 'black',
    );
    print(spc);
    spc.calculate();
    spc.printing();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dart OOP')),
    );
  }
}
