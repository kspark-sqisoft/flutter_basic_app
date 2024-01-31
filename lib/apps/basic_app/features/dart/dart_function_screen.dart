import 'package:flutter/material.dart';

//함수 기본형
int sum(int a, int b) {
  return a + b;
}

//익명 함수(Anonymous Function)
var minus = (int a, int b) {
  return a - b;
};

//람다 함수
var multiply = (int a, int b) => a * b;

//클로저
Function dividerFunction(int a, int b) {
  return (int a, int b) => a * b;
}

//고차 함수(함수를 인자로 전달하거나 반환)
void sendFunction() {
  print('인자로 전달될 함수 실행');
}

void excuteFunction(void Function() func) {
  func();
}

//클래스 접근 지정자(Getter, Setter)
class Person {
  String _name = 'Dart';

  String get name => _name;
  set name(String value) {
    _name = name;
  }
}

//typedef 아래 둘다 가능
//MathFunction은 (int, int) => int 형식의 함수 시그니처를 갖는 타입
//오른쪽의 복작함 함수 시그니처를 간결하게 하여 가독성을 높인다.
typedef MathFunction = int Function(int a, int b);
//typedef MathFunction = int Function(int, int);
//typedef int MathFunction(int a, int b);
//typedef MathFunction<T> = T Function(T a, T b);

class DartFunctionScreen extends StatefulWidget {
  const DartFunctionScreen({super.key});

  @override
  State<DartFunctionScreen> createState() => _DartFunctionScreenState();
}

class _DartFunctionScreenState extends State<DartFunctionScreen> {
  @override
  void initState() {
    //함수 기본형
    print('sum(2,2)=${sum(2, 2)}');

    //익명 함수(Anonymous Function)
    print('minus(5, 2)=${minus(5, 2)}');

    //람다 함수
    print('multiply(5, 2)=${multiply(5, 2)}');

    //클로저
    var divider = dividerFunction(10, 2);
    print('divider(10, 2)=${divider(10, 2)}');

    //고차 함수(함수를 인자로 전달하거나 반환)
    excuteFunction(sendFunction);

    //typedef
    MathFunction mathFunction;
    mathFunction = sum;
    print(mathFunction(1, 2));

    mathFunction = minus;
    print(mathFunction(5, 2));

    super.initState();
  }

  void onVoidCallback() {
    print('onVoidCallback');
  }

  int onFunction(int input) {
    print('onFunction($input)');
    return input + 100;
  }

  Widget widgetBuilder(BuildContext context, IconData iconData) {
    return Icon(iconData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dart Function'),
      ),
      body: Column(
        children: [
          MyWidget(
            onVoidCallback: onVoidCallback,
            onFunction: onFunction,
            widgetBuilder: widgetBuilder,
          )
        ],
      ),
    );
  }
}

typedef WidgetBuilder = Widget Function(
    BuildContext context, IconData iconData);

class MyWidget extends StatelessWidget {
  const MyWidget({
    super.key,
    required this.onVoidCallback,
    required this.onFunction,
    required this.widgetBuilder,
  });
  final VoidCallback onVoidCallback;
  final int Function(int) onFunction;
  final WidgetBuilder widgetBuilder;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 400,
      child: Column(children: [
        ElevatedButton(
          onPressed: onVoidCallback,
          child: const Text('onVoidCallback'),
        ),
        ElevatedButton(
          onPressed: () {
            int result = onFunction(5);
            print('result:$result');
          },
          child: const Text('onFunction'),
        ),
        widgetBuilder(context, Icons.upcoming),
        const SizedBox(
          height: 10,
        ),
        widgetBuilder(context, Icons.summarize),
      ]),
    );
  }
}
