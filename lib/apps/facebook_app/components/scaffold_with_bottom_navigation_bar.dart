import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import 'package:badges/badges.dart' as badges;

final HideBottomNavbar hideBottomNavbar = HideBottomNavbar();

class ScaffoldWithBottomNavigationBar extends StatelessWidget {
  const ScaffoldWithBottomNavigationBar(
      {super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: navigationShell),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: hideBottomNavbar.visible,
        builder: (context, value, child) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: value ? kBottomNavigationBarHeight + 20 : 0.0,
          child: LayoutBuilder(
            builder: (context, constraints) => Wrap(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: Platform.isIOS
                          ? kBottomNavigationBarHeight + 20 + 12
                          : kBottomNavigationBarHeight + 20,
                      child: BottomNavigationBar(
                        type: BottomNavigationBarType.fixed,
                        items: const <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                            icon: FaIcon(
                              FontAwesomeIcons.house,
                            ),
                            label: '홈',
                          ),
                          BottomNavigationBarItem(
                            icon: FaIcon(FontAwesomeIcons.youtube),
                            label: '동영상',
                          ),
                          BottomNavigationBarItem(
                            icon: FaIcon(FontAwesomeIcons.userGroup),
                            label: '친구',
                          ),
                          BottomNavigationBarItem(
                            icon: FaIcon(FontAwesomeIcons.user),
                            label: '프로필',
                          ),
                          BottomNavigationBarItem(
                            icon: badges.Badge(
                              badgeContent: Text(
                                '1',
                                style: TextStyle(color: Colors.white),
                              ),
                              child: FaIcon(FontAwesomeIcons.bell),
                            ),
                            label: '알림',
                          ),
                          BottomNavigationBarItem(
                            icon: FaIcon(FontAwesomeIcons.bars),
                            label: '메뉴',
                          ),
                        ],
                        selectedLabelStyle: const TextStyle(
                          overflow: TextOverflow.visible,
                        ),
                        selectedItemColor: Colors.lightBlue,
                        unselectedItemColor: Colors.grey,
                        currentIndex: navigationShell.currentIndex,
                        iconSize: 24,
                        selectedFontSize: 12,
                        unselectedFontSize: 12,
                        onTap: (int index) {
                          navigationShell.goBranch(index,
                              initialLocation:
                                  index == navigationShell.currentIndex);
                        },
                      ),
                    ),
                    AnimatedPositioned(
                      curve: Curves.easeInOutCubic,
                      top: 0,
                      left: constraints.maxWidth /
                          6 *
                          (navigationShell
                              .currentIndex) // minimize the half of it
                      ,
                      duration: const Duration(
                        milliseconds: 300,
                      ),
                      child: Container(
                        width: constraints.maxWidth / 6,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: Colors.lightBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HideBottomNavbar {
  final ScrollController controller = ScrollController();
  final ValueNotifier<bool> visible = ValueNotifier<bool>(true);

  HideBottomNavbar() {
    visible.value = true;
    controller.addListener(
      () {
        if (controller.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (visible.value) {
            visible.value = false;
          }
        }

        if (controller.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (!visible.value) {
            visible.value = true;
          }
        }
      },
    );
  }

  void dispose() {
    controller.dispose();
    visible.dispose();
  }
}
