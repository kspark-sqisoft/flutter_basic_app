import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:collection/collection.dart';
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.white,
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
        itemBuilder: (context, index) => Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                decoration: const BoxDecoration(
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
              ),
            )),
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
          ...moreTitles.mapIndexed(
            (index, e) {
              final GlobalKey expansionTileKey = GlobalKey();
              //0
              if (index == 0) {
                return ExpansionTile(
                  key: expansionTileKey,
                  onExpansionChanged: (value) {
                    if (value) {
                      _scrollToSelectedContent(
                          expansionTileKey: expansionTileKey);
                    }
                  },
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: double.infinity,
                                height: 70,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
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
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: double.infinity,
                                height: 70,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
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
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: double.infinity,
                                height: 70,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Row(children: [
                                    FaIcon(
                                        FontAwesomeIcons.triangleExclamation),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('문제 신고')
                                  ]),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: double.infinity,
                                height: 70,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
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
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    )
                  ],
                );
                //1
              } else if (index == 1) {
                return ExpansionTile(
                  key: expansionTileKey,
                  onExpansionChanged: (value) {
                    if (value) {
                      _scrollToSelectedContent(
                          expansionTileKey: expansionTileKey);
                    }
                  },
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: double.infinity,
                                height: 70,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Row(children: [
                                    FaIcon(FontAwesomeIcons.user),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('설정')
                                  ]),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: double.infinity,
                                height: 70,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Row(children: [
                                    FaIcon(FontAwesomeIcons.idCard),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('기기 요청')
                                  ]),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: double.infinity,
                                height: 70,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Row(children: [
                                    FaIcon(FontAwesomeIcons.rectangleAd),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('최근 광고 활동')
                                  ]),
                                ),
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
                );
                //2
              } else if (index == 2) {
                return ExpansionTile(
                  key: expansionTileKey,
                  onExpansionChanged: (value) {
                    if (value) {
                      _scrollToSelectedContent(
                          expansionTileKey: expansionTileKey);
                    }
                  },
                  title: Text(e),
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Container(
                                color: Colors.white,
                                height: 290,
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/facebook/ballons.jpg',
                                          fit: BoxFit.cover,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          height: 150,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 40,
                                              ),
                                              Text(
                                                'Meta Verified',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                  '구독하여 인증 배지 등 다양한 혜택을 이용해보세요.'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      top: 120,
                                      left: 10,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                        ),
                                        child: const CircleAvatar(
                                          radius: 24,
                                          backgroundColor: Colors.white,
                                          child: FaIcon(
                                            FontAwesomeIcons.faceGrinStars,
                                            color: Colors.lightBlue,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Container(
                                color: Colors.white,
                                height: 290,
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/facebook/ballons2.jpg',
                                          fit: BoxFit.cover,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          height: 150,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 40,
                                              ),
                                              Text(
                                                'Meta Verified',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                  '구독하여 인증 배지 등 다양한 혜택을 이용해보세요.'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      top: 120,
                                      left: 10,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                        ),
                                        child: const CircleAvatar(
                                          radius: 24,
                                          backgroundColor: Colors.white,
                                          child: FaIcon(
                                            FontAwesomeIcons.check,
                                            color: Colors.lightBlue,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                );
                //3
              } else {
                return ExpansionTile(
                  key: expansionTileKey,
                  onExpansionChanged: (value) {
                    if (value) {
                      _scrollToSelectedContent(
                          expansionTileKey: expansionTileKey);
                    }
                  },
                  title: Text(e),
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Container(
                                color: Colors.white,
                                height: 290,
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/facebook/meta_products.jpg',
                                          fit: BoxFit.cover,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          height: 150,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 40,
                                              ),
                                              Text(
                                                'Meta Quest',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text('이제 Meta Quest 3를 이용해 보세요!'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      top: 120,
                                      left: 10,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                        ),
                                        child: const CircleAvatar(
                                          radius: 24,
                                          backgroundColor: Colors.white,
                                          child: FaIcon(
                                            FontAwesomeIcons.meta,
                                            color: Colors.lightBlue,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    color: Colors.white,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height: 92,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            'assets/images/facebook/sparkar.png',
                                            fit: BoxFit.cover,
                                            width: 50,
                                            height: 50,
                                          ),
                                          const Text('Spark AR'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    color: Colors.white,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height: 92,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Image.asset(
                                              'assets/images/facebook/threads.png',
                                              fit: BoxFit.cover,
                                              width: 40,
                                              height: 40,
                                            ),
                                          ),
                                          const Text('Threads'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    color: Colors.white,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height: 92,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Image.asset(
                                              'assets/images/facebook/whatsapp.png',
                                              fit: BoxFit.cover,
                                              width: 40,
                                              height: 40,
                                            ),
                                          ),
                                          const Text('WhatsApp'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                );
              }
            },
          ).toList()
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

  void _scrollToSelectedContent({required GlobalKey expansionTileKey}) {
    final keyContext = expansionTileKey.currentContext;
    if (keyContext != null) {
      Future.delayed(const Duration(milliseconds: 200)).then((value) {
        Scrollable.ensureVisible(keyContext,
            duration: const Duration(milliseconds: 200));
      });
    }
  }
}
