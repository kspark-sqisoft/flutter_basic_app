import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../custom_icons/custom_icons_icons.dart';

class ScaffoldWithNavbar extends StatefulWidget {
  const ScaffoldWithNavbar({
    super.key,
    required this.navigationShell,
  });
  final StatefulNavigationShell navigationShell;

  @override
  State<ScaffoldWithNavbar> createState() => _ScaffoldWithNavbarState();
}

class _ScaffoldWithNavbarState extends State<ScaffoldWithNavbar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.youtube), label: '홈'),
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(
                  CustomIcons.apple_tv_plus,
                ),
              ),
              label: 'Apple TV+'),
          BottomNavigationBarItem(
              icon: Icon(CustomIcons.discount_2000), label: '스토어'),
          BottomNavigationBarItem(
              icon: Icon(CustomIcons.youtube_videos_7639), label: '보관함'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: '검색'),
        ],
        selectedLabelStyle: const TextStyle(
          overflow: TextOverflow.visible,
        ),
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.grey,
        currentIndex: widget.navigationShell.currentIndex,
        onTap: (int index) {
          widget.navigationShell.goBranch(index,
              initialLocation: index == widget.navigationShell.currentIndex);
        },
      ),
    );
  }
}
