import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../home/home_screen.dart';

final List<IconData> meIcons = [
  FontAwesomeIcons.clockRotateLeft,
  FontAwesomeIcons.bookmark,
  FontAwesomeIcons.globe,
  FontAwesomeIcons.youtube,
  FontAwesomeIcons.users,
  FontAwesomeIcons.rss,
  FontAwesomeIcons.calendarCheck,
  FontAwesomeIcons.houseCrack,
];
final List<String> meTitles = [
  '과거의 오늘',
  '저장됨',
  '그룹',
  '동영상',
  '친구',
  '피드',
  '이벤트',
  '재난 안전 확인'
];

final List<IconData> moreIcons = [
  FontAwesomeIcons.question,
  FontAwesomeIcons.gear,
  FontAwesomeIcons.universalAccess,
  FontAwesomeIcons.meta,
];
final List<String> moreTitles = [
  '도움말 및 지원',
  '설정 및 개인정보',
  '프로페셔널 액세스',
  'Meta의 다른 제품',
];

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverAppBar(
        title: const Text('메뉴'),
        scrolledUnderElevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                CircleAvatar(
                  maxRadius: 20,
                  backgroundColor: Colors.grey[100],
                  child: const FaIcon(
                    FontAwesomeIcons.gear,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  maxRadius: 20,
                  backgroundColor: Colors.grey[300],
                  child: const FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 26,
                            child: CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.blue,
                              backgroundImage: AssetImage(
                                  'assets/images/facebook/profile.jpg'),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '박기순',
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey[200],
                        child: const FaIcon(FontAwesomeIcons.chevronDown),
                      )
                    ],
                  ),
                  const Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.transparent,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey,
                          child: FaIcon(FontAwesomeIcons.plus),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('다른 프로필 만들기')
                    ],
                  )
                ]),
              ),
            ),
          ),
        ),
      ),
      //내 바로가기
      const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('내 바로가기'),
        ),
      ),
      SliverToBoxAdapter(
        child: SizedBox(
          height: 120,
          child: ListView.builder(
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 36,
                    child: CircleAvatar(
                      radius: 34,
                      backgroundColor: Colors.blue,
                      backgroundImage: AssetImage(index == 0
                          ? 'assets/images/facebook/profile.jpg'
                          : 'assets/images/facebook/user$index.jpg'),
                    ),
                  ),
                  Text(users[index])
                ],
              ),
            ),
          ),
        ),
      ),
      SliverGrid.builder(
        itemCount: meIcons.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisExtent: 100),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(1.0),
          child: Card(
              child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FaIcon(
                    meIcons[index],
                    color: Colors.lightBlue,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(meTitles[index]),
                ],
              ),
            ),
          )),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        sliver: SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[100],
            ),
            child: const Center(
                child: Padding(
              padding: EdgeInsets.all(14.0),
              child: Text('더 보기'),
            )),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Column(children: [
          ...moreTitles
              .map(
                (e) => ExpansionTile(
                  title: Text(e),
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Card(
                            child: Container(
                              width: double.infinity,
                              height: 70,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Row(children: [
                                  FaIcon(FontAwesomeIcons.arrowsToEye),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('고객 센터')
                                ]),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Card(
                            child: Container(
                              width: double.infinity,
                              height: 70,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Row(children: [
                                  FaIcon(FontAwesomeIcons.envelopeOpenText),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('지원 관련 메시지함')
                                ]),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Card(
                            child: Container(
                              width: double.infinity,
                              height: 70,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Row(children: [
                                  FaIcon(FontAwesomeIcons.triangleExclamation),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('문제 신고')
                                ]),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Card(
                            child: Container(
                              width: double.infinity,
                              height: 70,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Row(children: [
                                  FaIcon(FontAwesomeIcons.userShield),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('안전')
                                ]),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    )
                  ],
                ),
              )
              .toList()
        ]),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        sliver: SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[100],
            ),
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(14.0),
                child: Text('로그아웃'),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
