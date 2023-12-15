import 'dart:math';

import 'package:flutter/material.dart';

class LifeCycleScreen extends StatefulWidget {
  const LifeCycleScreen({super.key});

  @override
  State<LifeCycleScreen> createState() => _LifeCycleScreenState();
}

class _LifeCycleScreenState extends State<LifeCycleScreen> {
  bool isAddedChidWidget = true;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LifeCycle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isAddedChidWidget
                ? Row(
                    children: [
                      STLWidget(
                        count: count,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      STFWidget(
                        count: count,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      STFWidgetUniqkey(key: UniqueKey(), count: count),
                      const SizedBox(
                        width: 10,
                      ),
                      const MyScaffold(
                        child: MyMiddlePage(child: MyChildPage()),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isAddedChidWidget = !isAddedChidWidget;
                  print('##########################');
                  print(
                      '_LifeCycleScreenState setState isAddedChidWidget:$isAddedChidWidget');
                });
              },
              child: Text(isAddedChidWidget ? 'remove widgets' : 'add widgets'),
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  count++;
                  print('##########################');
                  print('_LifeCycleScreenState setState count:$count');
                });
              },
              child: const Text('change count'),
            ),
          ],
        ),
      ),
    );
  }
}

class STLWidget extends StatelessWidget {
  const STLWidget({super.key, required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    print('STLWidget build');
    return Container(
      color: Colors.red,
      width: 100,
      height: 100,
      child: Center(child: Text('STLWidget count:$count')),
    );
  }
}

class STFWidget extends StatefulWidget {
  const STFWidget({super.key, required this.count});
  final int count;

  @override
  State<STFWidget> createState() => _STFWidgetState();
}

class _STFWidgetState extends State<STFWidget> {
  @override
  void initState() {
    print('_STFWidgetState initState');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('_STFWidgetState didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant STFWidget oldWidget) {
    print('_STFWidgetState didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    print('_STFWidgetState deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('_STFWidgetState dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('_STFWidgetState build');
    return Container(
      color: Colors.blue,
      width: 100,
      height: 100,
      child: Center(child: Text('STFWidget count:${widget.count}')),
    );
  }
}

class STFWidgetUniqkey extends StatefulWidget {
  const STFWidgetUniqkey({super.key, required this.count});
  final int count;

  @override
  State<STFWidgetUniqkey> createState() => _STFWidgetUniqkeyState();
}

class _STFWidgetUniqkeyState extends State<STFWidgetUniqkey> {
  @override
  void initState() {
    print('_STFWidgetUniqkeyState initState');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('_STFWidgetUniqkeyState didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant STFWidgetUniqkey oldWidget) {
    print('_STFWidgetUniqkeyState didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    print('_STFWidgetUniqkeyState deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('_STFWidgetUniqkeyState dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('_STFWidgetUniqkeyState build');
    return Container(
      color: Colors.green,
      width: 100,
      height: 100,
      child: Center(child: Text('STFWidgetUniqkey count:${widget.count}')),
    );
  }
}

//Inherited Widget
class MyScaffold extends StatefulWidget {
  const MyScaffold({super.key, required this.child});
  final Widget child;

  @override
  State<MyScaffold> createState() => _MyScaffoldState();

  static MyScaffoldScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyScaffoldScope>();
  }

  static MyScaffoldScope of(BuildContext context) {
    final MyScaffoldScope? result = maybeOf(context);
    assert(result != null, 'No MyScaffoldScope found in context');
    return result!;
  }
}

class _MyScaffoldState extends State<MyScaffold> {
  //자식에 전달 하고픈 색
  Color color = Colors.amber;
  @override
  Widget build(BuildContext context) {
    print('_MyScaffoldState build');
    return MyScaffoldScope(
      color: color,
      child: GestureDetector(
        onTap: () {
          setState(() {
            color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
            print('_MyScaffoldState setState color:$color');
          });
        },
        child: widget.child,
      ),
    );
  }
}

class MyScaffoldScope extends InheritedWidget {
  const MyScaffoldScope({
    super.key,
    required super.child,
    required this.color,
  });
  final Color color;

  @override
  bool updateShouldNotify(covariant MyScaffoldScope oldWidget) {
    //하위 위젯이 리빌드 될지 여부
    bool beShouldUpdate = color != oldWidget.color;
    if (beShouldUpdate) {
      print('MyScaffoldScope updateShouldNotify');
    }
    return beShouldUpdate;
  }
}

class MyMiddlePage extends StatelessWidget {
  const MyMiddlePage({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    print('MyMiddlePage build'); //호출 되지 않는다.
    return child;
  }
}

class MyChildPage extends StatelessWidget {
  const MyChildPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('MyChildPage build');
    return Container(
      width: 100,
      height: 100,
      color: MyScaffold.of(context).color,
      child: const Center(child: Text('MyChildPage(InheritedWidget)')),
    );
  }
}
