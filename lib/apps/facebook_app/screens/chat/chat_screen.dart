import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../home/home_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.delta.direction <= 0) {
            context.go('/home');
          }
        },
        onVerticalDragUpdate: (details) {},
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => context.go('/home'),
              ),
              title: const Text(
                '채팅',
              ),
              actions: const [
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.gear,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FaIcon(
                      FontAwesomeIcons.penToSquare,
                      size: 20,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                )
              ],
            ),
            SliverPadding(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
              sliver: SliverToBoxAdapter(
                child: Container(
                  height: 40,
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.grey[200]),
                  child: const Center(
                    child: TextField(
                      style: TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: FaIcon(
                            FontAwesomeIcons.magnifyingGlass,
                            size: 16,
                          ),
                        ),
                        prefixIconConstraints: BoxConstraints(
                          minWidth: 25,
                          minHeight: 25,
                        ),
                        border: InputBorder.none,
                        hintText: '검색',
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: users.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 24,
                          child: CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.blue,
                            backgroundImage: AssetImage(
                                'assets/images/facebook/user$index.jpg'),
                          ),
                        ),
                        Text(
                          users[index],
                          style: const TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
