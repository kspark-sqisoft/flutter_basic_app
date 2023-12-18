import 'package:flutter/material.dart';

class LifeCycle2Screen extends StatefulWidget {
  const LifeCycle2Screen({super.key});

  @override
  State<LifeCycle2Screen> createState() => _LifeCycle2ScreenState();
}

class _LifeCycle2ScreenState extends State<LifeCycle2Screen> {
  bool isExistWidgets = false;
  int count = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('_LifeCycle2ScreenState build');
    return Scaffold(
        appBar: AppBar(title: const Text('LifeCycle2')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FractionallySizedBox(
                  widthFactor: 0.6,
                  child:
                      Image.asset('assets/images/etc/lifecycle_overview.png'),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isExistWidgets = !isExistWidgets;
                    });
                    MyConstStatelessWidget.buildCount = 0;
                    MyStatelessWidget.buildCount = 0;
                    MyStatefulWidget.buildCount = 0;
                    count = 0;
                    print(
                        '_LifeCycle2ScreenState setState isExistWidgets:$isExistWidgets');
                  },
                  child:
                      Text(isExistWidgets ? 'Remove Widgets' : 'Add Widgets'),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (isExistWidgets) ...[
                  ElevatedButton(
                      onPressed: () {
                        setState(() {});
                        print('_LifeCycle2ScreenState setState no change');
                      },
                      child: const Text('setState no value change'))
                ] else
                  const SizedBox.shrink(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    if (isExistWidgets) ...[
                      const MyConstStatelessWidget(),
                      const SizedBox(
                        width: 10,
                      ),
                      MyStatelessWidget(
                        count: count,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MyStatefulWidget(
                        count: count,
                      )
                    ] else
                      const SizedBox.shrink(),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                if (isExistWidgets) ...[
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          count++;
                        });
                      },
                      child: Text('Count Up   count:$count'))
                ] else
                  const SizedBox.shrink()
              ],
            ),
          ),
        ));
  }
}

class MyConstStatelessWidget extends StatelessWidget {
  const MyConstStatelessWidget({super.key});
  static int buildCount = 0;

  @override
  Widget build(BuildContext context) {
    MyConstStatelessWidget.buildCount++;
    print('MyConstStatelessWidget build');
    final size = MediaQuery.of(context).size; //size 가 변하면 빌드(InheritedWidget)
    return Container(
      width: size.width / 4,
      height: 200,
      decoration: const BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            spreadRadius: 3,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'MyConstStatelessWidget',
            style: TextStyle(fontSize: 22),
          ),
          Text(
            'build count : ${MyConstStatelessWidget.buildCount}',
            style: const TextStyle(fontSize: 20),
          ),
          const Text(''),
        ],
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key, required this.count});
  final int count;
  static int buildCount = 0;

  @override
  Widget build(BuildContext context) {
    print('MyStatelessWidget build');
    MyStatelessWidget.buildCount++;
    final size = MediaQuery.of(context).size; //size 가 변하면 빌드(InheritedWidget)
    return Container(
      width: size.width / 4,
      height: 200,
      decoration: const BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            spreadRadius: 3,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'MyStatelessWidget',
            style: TextStyle(fontSize: 22),
          ),
          Text(
            'build count : ${MyStatelessWidget.buildCount}',
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            'count : $count',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key, required this.count});
  final int count;
  static int buildCount = 0;

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String lastLifecycle = '';
  @override
  void initState() {
    print('_MyStatefulWidgetState initState');
    lastLifecycle = 'initState';
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('_MyStatefulWidgetState didChangeDependencies');
    lastLifecycle = 'didChangeDependencies';
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant MyStatefulWidget oldWidget) {
    print('_MyStatefulWidgetState didUpdateWidget');
    lastLifecycle = 'didUpdateWidget';
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    print('_MyStatefulWidgetState deactivate');
    lastLifecycle = 'deactivate';
    super.deactivate();
  }

  @override
  void dispose() {
    print('_MyStatefulWidgetState dispose');
    lastLifecycle = 'dispose';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('_MyStatefulWidgetState build');
    MyStatefulWidget.buildCount++;
    final size = MediaQuery.of(context).size; //size 가 변하면 빌드(InheritedWidget)
    return Container(
      width: size.width / 4,
      height: 200,
      decoration: const BoxDecoration(
        color: Colors.lightGreen,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            spreadRadius: 3,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'MyStatefulWidget',
            style: TextStyle(fontSize: 22),
          ),
          Text(
            'build count : ${MyStatefulWidget.buildCount}',
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            'count : ${widget.count}',
            style: const TextStyle(fontSize: 16),
          ),
          Text('build before last life cycle : $lastLifecycle'),
        ],
      ),
    );
  }
}
