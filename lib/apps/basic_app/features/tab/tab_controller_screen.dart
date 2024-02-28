import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const List<Tab> tabs = <Tab>[
  Tab(text: 'Zeroth'),
  Tab(text: 'First'),
  Tab(text: 'Second'),
];

class TabControllerScreen extends StatefulWidget {
  const TabControllerScreen({super.key});

  @override
  State<TabControllerScreen> createState() => _TabControllerScreenState();
}

class _TabControllerScreenState extends State<TabControllerScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      // The Builder widget is used to have a different BuildContext to access
      // closest DefaultTabController.
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context);

        tabController.addListener(() {
          if (!tabController.indexIsChanging) {
            // Your code goes here.
            // To get index of current tab use tabController.index
          }
        });
        return Scaffold(
          appBar: AppBar(
            title: const Text('TabController'),
            //appBar안의 bottom에 있지만 상황에 따라 다양한 곳에 아래 TabBarView를 스택으로 감싸고 스택의 위에 있을 수도 있다
            /*
            bottom: const TabBar(
              tabs: tabs,
            ),
            */
          ),
          body: Stack(
            children: [
              TabBarView(
                children: tabs.map((Tab tab) {
                  return Container(
                    color: Colors.lightBlue,
                    child: Center(
                      child: Text(
                        '${tab.text!} Tab',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(
                width: 300,
                child: TabBar(
                  tabs: tabs,
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
