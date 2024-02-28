import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';

class ButtonsTabbarScreen extends StatefulWidget {
  const ButtonsTabbarScreen({super.key});

  @override
  State<ButtonsTabbarScreen> createState() => _ButtonsTabbarScreenState();
}

class _ButtonsTabbarScreenState extends State<ButtonsTabbarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buttons Tabar'),
      ),
      body: DefaultTabController(
        length: 6,
        child: Stack(
          children: [
            const Expanded(
              child: TabBarView(
                children: <Widget>[
                  MyTabView(
                    iconData: Icons.directions_car,
                    index: 0,
                  ),
                  MyTabView(
                    iconData: Icons.directions_transit,
                    index: 1,
                  ),
                  MyTabView(
                    iconData: Icons.directions_bike,
                    index: 2,
                  ),
                  MyTabView(
                    iconData: Icons.directions_car,
                    index: 3,
                  ),
                  MyTabView(
                    iconData: Icons.directions_transit,
                    index: 4,
                  ),
                  MyTabView(
                    iconData: Icons.directions_bike,
                    index: 5,
                  ),
                ],
              ),
            ),
            ButtonsTabBar(
              backgroundColor: Colors.red,
              unselectedBackgroundColor: Colors.grey[300],
              unselectedLabelStyle: const TextStyle(color: Colors.black),
              labelStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              tabs: const [
                Tab(
                  icon: Icon(Icons.directions_car),
                  text: "car",
                ),
                Tab(
                  icon: Icon(Icons.directions_transit),
                  text: "transit",
                ),
                Tab(icon: Icon(Icons.directions_bike)),
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyTabView extends StatefulWidget {
  const MyTabView({super.key, required this.iconData, required this.index});
  final IconData iconData;
  final int index;

  @override
  State<MyTabView> createState() => _MyTabViewState();
}

class _MyTabViewState extends State<MyTabView> {
  @override
  void initState() {
    print('MyTabView initState ${widget.index}');
    super.initState();
  }

  @override
  void dispose() {
    print('MyTabView dispose ${widget.index}');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue,
      child: Center(
        child: Icon(widget.iconData),
      ),
    );
  }
}
