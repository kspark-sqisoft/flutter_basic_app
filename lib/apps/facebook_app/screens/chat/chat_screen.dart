import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../home/home_screen.dart';

final List<String> chats = [
  'Please try again, or scroll up to choose',
  '나',
  '안녕하세요 방가워요 그냥 친하게 지내고 싶어요',
  '회원님과  박상삼님이 10년 전 Facebook 친구 에요',
  '안녕하세요 방가워요 그냥 친하게 지내고 싶어요',
  '안녕하세요 방가워요 그냥 친하게 지내고 싶어요',
];
final List<String> chatDates = [
  ' · 11월 4일',
  ' · 2020.04.27',
  ' · 2020.02.17',
  ' · 2019.11.17',
  ' · 2019.05.12',
  ' · 2019.08.02',
];

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    _tabController =
        TabController(vsync: this, length: 2, animationDuration: Duration.zero);
    _tabController.addListener(() {
      log('_tabController.index : ${_tabController.index}');
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity == null) return;
          if (details.primaryVelocity! < 0) {
            // drag from right to left
          } else {
            // drag from left to right
            context.go('/home');
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
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
                            backgroundImage: AssetImage(index == 0
                                ? 'assets/images/facebook/profile.jpg'
                                : 'assets/images/facebook/user$index.jpg'),
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
            ),
            SliverFillRemaining(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.transparent,
                    dividerColor: Colors.transparent,
                    tabs: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _currentTabIndex == 0
                              ? Colors.blue.withOpacity(0.1)
                              : Colors.transparent,
                          elevation: 0,
                        ),
                        onPressed: () {
                          setState(() {
                            _currentTabIndex = 0;
                          });

                          _tabController.animateTo(_currentTabIndex,
                              duration: Duration.zero);
                        },
                        child: const Text('받은 메시지함'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _currentTabIndex == 1
                              ? Colors.blue.withOpacity(0.1)
                              : Colors.transparent,
                          elevation: 0,
                        ),
                        onPressed: () {
                          setState(() {
                            _currentTabIndex = 1;
                          });
                          _tabController.animateTo(_currentTabIndex,
                              duration: Duration.zero);
                        },
                        child: const Text('커뮤니티'),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: const [
                        MailBox(),
                        Community(),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MailBox extends StatelessWidget {
  const MailBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SlidableAutoCloseBehavior(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: 20,
        itemBuilder: (context, index) => Slidable(
          key: ValueKey(index),
          closeOnScroll: true,
          endActionPane: ActionPane(
            extentRatio: .75,
            dragDismissible: false,
            motion: const BehindMotion(),
            dismissible: DismissiblePane(onDismissed: () {}),
            children: [
              CustomSlidableAction(
                onPressed: (BuildContext context) {},
                backgroundColor: Colors.grey[200]!,
                foregroundColor: Colors.black,
                child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(FontAwesomeIcons.inbox),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '더 보기',
                        style: TextStyle(fontSize: 11),
                      )
                    ]),
              ),
              CustomSlidableAction(
                onPressed: (BuildContext context) {},
                backgroundColor: Colors.grey[200]!,
                foregroundColor: Colors.black,
                child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(FontAwesomeIcons.bellSlash),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '알림 해제',
                        style: TextStyle(fontSize: 11),
                      )
                    ]),
              ),
              CustomSlidableAction(
                onPressed: (BuildContext context) {},
                backgroundColor: const Color(0xFFBA93DF),
                foregroundColor: Colors.black,
                child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(FontAwesomeIcons.boxArchive),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '보관',
                        style: TextStyle(fontSize: 11),
                      )
                    ]),
              ),
            ],
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.blue,
                backgroundImage: AssetImage(index % 6 == 0
                    ? 'assets/images/facebook/profile.jpg'
                    : 'assets/images/facebook/user${index % 6}.jpg'),
              ),
            ),
            title: Text(users[index % 6]),
            subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      chats[index % 6],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  Text(
                    chatDates[index % 6],
                    maxLines: 1,
                    style: const TextStyle(fontSize: 12),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

class Community extends StatelessWidget {
  const Community({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('그룹의 다른 채팅'),
        Expanded(
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: 6,
            itemBuilder: (context, index) => ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey[200],
                radius: 20,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey[200],
                  child: const FaIcon(
                    FontAwesomeIcons.message,
                    size: 18,
                  ),
                ),
              ),
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      users[index % 6],
                    ),
                    Text(
                      chats[index % 6],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ]),
            ),
          ),
        )
      ],
    );
  }
}
