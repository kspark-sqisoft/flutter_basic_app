import 'package:flutter/material.dart';

class ConstrainedBoxScreen extends StatelessWidget {
  const ConstrainedBoxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ConstrainedBox'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text('Container'),
                Container(
                  width: 200,
                  height: 200,
                  color: Colors.lightBlue,
                  child: const Text(
                    'Delicious Candy',
                    style: TextStyle(fontSize: 70),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                //자식을 제한 한다.하위 항목에 추가 제약을 가하는 위젯, SizedBox.expand 위젯을 사용하여 동일한 동작을 얻을 수 있습니다.
                const Text('ConstrainedBox'),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                      maxWidth: 200,
                      maxHeight: 200,
                      minWidth: 100,
                      minHeight: 100),
                  child: Container(
                    color: Colors.lightGreen,
                    child: const Text(
                      'Delicious Candy',
                      style: TextStyle(fontSize: 90),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text('Container'),
                Card(
                  elevation: 1,
                  child: Image.asset(
                    'assets/images/facebook/profile.jpg', //original 719x720
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text('ConstrainedBox'),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 200,
                    maxHeight: 200,
                    minWidth: 100,
                    minHeight: 100,
                  ),
                  child: Card(
                    elevation: 1,
                    child: Image.asset(
                      'assets/images/facebook/profile.jpg', //original 719x720
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text('ConstrainedBox.tightFor'),
                ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(),
                  child: Card(
                    elevation: 1,
                    child: Image.asset(
                      'assets/images/facebook/profile.jpg', //original 719x720
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text('ConstrainedBox.expand'),
                Container(
                  width: 400,
                  height: 400,
                  color: Colors.lightGreen,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints.expand(),
                    child: Card(
                      elevation: 1,
                      child: Image.asset(
                        'assets/images/facebook/profile.jpg', //original 719x720
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text('OverflowBox'),
                Container(
                  width: 100,
                  height: 100,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  //자신이 얻는 것보다 자식에게 다른 제약을 가하는 위젯 부모로부터 자식이 부모를 넘치게 할 수도 있습니다.
                  child: const OverflowBox(
                    maxWidth: 200,
                    maxHeight: 200,
                    child: FlutterLogo(
                      size: 200,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text('FittedBox'),
                Container(
                  width: 400,
                  height: 300,
                  color: Colors.blue,
                  //fit에 따라 자식 항목의 크기(위치) 조정
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Image.network(
                        'https://picsum.photos/200/300?random=20'),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text('FractionallySizedBox'),
                Container(
                  color: Colors.amber,
                  width: 400,
                  height: 300,
                  child: SizedBox.expand(
                    child: FractionallySizedBox(
                      widthFactor: 0.5,
                      heightFactor: 0.5,
                      alignment: FractionalOffset.center,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('button'),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
