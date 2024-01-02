import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../components/scaffold_with_bottom_navigation_bar.dart';
import '../chat/chat_screen.dart';

final users = ['박기순', 'Metallica', '정수봉', '김대열', '성민창', 'iJustine'];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity == null) return;
        if (details.primaryVelocity! < 0) {
          // drag from right to left
          context.push('/chat');
        } else {
          // drag from left to right
        }
      },
      child: CustomScrollView(
        controller: hideBottomNavbar.controller,
        slivers: [
          SliverAppBar(
            floating: true,
            centerTitle: false,
            title: Text(
              'facebook',
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.blue[600]
                    : Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: PopupMenuButton(
                  constraints:
                      const BoxConstraints.expand(width: 140, height: 170),
                  offset: const Offset(50, 54),
                  icon: CircleAvatar(
                    maxRadius: 18,
                    backgroundColor: Colors.grey[300],
                    child: const FaIcon(
                      FontAwesomeIcons.plus,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  itemBuilder: (context) {
                    return <PopupMenuEntry>[
                      const PopupMenuItem(
                        height: 26,
                        child: Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.penToSquare,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '게시',
                              style: TextStyle(fontSize: 13),
                            )
                          ],
                        ),
                      ),
                      const PopupMenuDivider(),
                      const PopupMenuItem(
                        height: 26,
                        child: Row(
                          children: [
                            FaIcon(FontAwesomeIcons.bookOpen, size: 20),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '스토리',
                              style: TextStyle(fontSize: 13),
                            )
                          ],
                        ),
                      ),
                      const PopupMenuDivider(),
                      const PopupMenuItem(
                        height: 26,
                        child: Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.youtube,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '릴스',
                              style: TextStyle(fontSize: 13),
                            )
                          ],
                        ),
                      ),
                      const PopupMenuDivider(),
                      const PopupMenuItem(
                        height: 26,
                        child: Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.video,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '라이브 방송',
                              style: TextStyle(fontSize: 13),
                            )
                          ],
                        ),
                      ),
                    ];
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  maxRadius: 18,
                  backgroundColor: Colors.grey[300],
                  child: IconButton(
                    onPressed: () {},
                    icon: const FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  maxRadius: 18,
                  backgroundColor: Colors.grey[300],
                  child: IconButton(
                    onPressed: () {},
                    icon: const FaIcon(
                      FontAwesomeIcons.comment,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/facebook/profile.jpg'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('무슨 생각을 하고 계신가요?'),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.images,
                          color: Colors.lightGreen,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Divider(
              thickness: 8,
            ),
          ),
          //story
          SliverToBoxAdapter(
            child: SizedBox(
              height: 170,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    //first
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Card(
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        child: SizedBox(
                          width: 100,
                          height: 170,
                          child: ClipPath(
                            clipper: ShapeBorderClipper(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            child: Stack(
                              //fit: StackFit.expand,
                              children: [
                                Image.asset(
                                  'assets/images/facebook/profile.jpg',
                                  fit: BoxFit.cover,
                                  width: 130,
                                  height: 200,
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Stack(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 60,
                                            color: Colors.white,
                                            child: const Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    '스토리 만들기',
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  )
                                                ]),
                                          )
                                        ],
                                      ),
                                      const Positioned(
                                        top: 80,
                                        left: 30,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 22,
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.blue,
                                            child: FaIcon(
                                              FontAwesomeIcons.plus,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Card(
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        child: SizedBox(
                          width: 100,
                          height: 170,
                          child: ClipPath(
                            clipper: ShapeBorderClipper(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/images/facebook/story$index.jpg',
                                  fit: BoxFit.cover,
                                  width: 130,
                                  height: 200,
                                ),
                                Positioned(
                                  top: 5,
                                  left: 5,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 20,
                                    child: CircleAvatar(
                                      radius: 18,
                                      backgroundColor: Colors.blue,
                                      backgroundImage: AssetImage(
                                          'assets/images/facebook/user$index.jpg'),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      users[index],
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Divider(
              thickness: 8,
            ),
          ),
          //content1
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.blue,
                                  backgroundImage: AssetImage(
                                      'assets/images/facebook/user3.jpg'),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '김대열',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          '회원님을 위한 추천 · 36분 · ',
                                          maxLines: 2,
                                          style: TextStyle(fontSize: 11),
                                        ),
                                        FaIcon(
                                          FontAwesomeIcons.earthAmericas,
                                          size: 16,
                                          color: Colors.grey[500],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      useRootNavigator: true,
                                      showDragHandle: true,
                                      isScrollControlled: true,
                                      builder: (BuildContext context) {
                                        //크기 만큼 bottom sheet height
                                        return Wrap(
                                          children: [
                                            Container(
                                              color: Colors.transparent,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .bottomSheetTheme
                                                      .backgroundColor,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(30),
                                                    topRight:
                                                        Radius.circular(30),
                                                  ),
                                                ),
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      //box1
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 10.0,
                                                                right: 10,
                                                                bottom: 10),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          decoration: BoxDecoration(
                                                              color: Theme.of(
                                                                      context)
                                                                  .canvasColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: const Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  FaIcon(FontAwesomeIcons
                                                                      .circlePlus),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        '더 많이 보기',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      Text(
                                                                        '이와 비슷한 광고가 지금보다 많이 표시됩니다.',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              11,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  FaIcon(FontAwesomeIcons
                                                                      .circleMinus),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        '더 많이 보기',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      Text(
                                                                        '이와 비슷한 광고가 지금보다 적게 표시됩니다.',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              11,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      //box2
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 10.0,
                                                                right: 10,
                                                                bottom: 10),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          decoration: BoxDecoration(
                                                              color: Theme.of(
                                                                      context)
                                                                  .canvasColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: const Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  FaIcon(FontAwesomeIcons
                                                                      .bookmark),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        '게시물 저장',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      Text(
                                                                        '저장된 항목에 추가합니다.',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              11,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  FaIcon(FontAwesomeIcons
                                                                      .eyeSlash),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        '게시물 숨기기',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      Text(
                                                                        'Tottenham Hotsper님은 신고한 사람을 알 수 없습니다.',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              11,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  FaIcon(FontAwesomeIcons
                                                                      .circleExclamation),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        '게시물 신고',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      Text(
                                                                        'Tottenham Hotsper님은 신고한 사람을 알 수 없습니다.',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              11,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  FaIcon(
                                                                      FontAwesomeIcons
                                                                          .bell),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        '이 게시물에 대한 알림 받기',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: const Text(
                                    '···',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const FaIcon(
                                      FontAwesomeIcons.xmark,
                                      color: Colors.grey,
                                    ))
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          '소원을 빌면 복이 온다는 ㄷㄷ',
                          maxLines: 2,
                        ),
                        const SizedBox(
                          height: 5,
                        )
                      ]),
                ),
                StaggeredGrid.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  children: const [
                    StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 2,
                      child: Tile(index: 0),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 1,
                      child: Tile(index: 1),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: Tile(index: 2),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: Tile(index: 3),
                    ),
                  ],
                ),
                //좋아요 ...
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 13,
                                child: FaIcon(
                                  FontAwesomeIcons.thumbsUp,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('1개'),
                            ],
                          ),
                          Text('공유 1회')
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //좋아요
                          Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.thumbsUp,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('좋아요'),
                            ],
                          ),
                          //댓글
                          Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.comment,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('댓글'),
                            ],
                          ),
                          //복사
                          Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.copy,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('복사'),
                            ],
                          ),
                          //공유하기
                          Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.share,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('공유하기'),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: Divider(
              thickness: 8,
            ),
          ),
          //content2
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.blue,
                                  backgroundImage: AssetImage(
                                      'assets/images/facebook/user3.jpg'),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '정수봉',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          '회원님을 위한 추천 · 36분 · ',
                                          maxLines: 2,
                                          style: TextStyle(fontSize: 11),
                                        ),
                                        FaIcon(
                                          FontAwesomeIcons.earthAmericas,
                                          size: 16,
                                          color: Colors.grey[500],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    '···',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const FaIcon(
                                      FontAwesomeIcons.xmark,
                                      color: Colors.grey,
                                    ))
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          '이겨라(짝) 이겨라(짝)\n연기력 오지는 레전드 장면...',
                          maxLines: 2,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ]),
                ),
                StaggeredGrid.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  children: const [
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: Tile2(index: 1),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: Tile2(index: 2),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 2,
                      child: Tile2(index: 3),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 1,
                      child: Tile2(index: 0),
                    ),
                  ],
                ),
                //좋아요 ...
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 13,
                                child: FaIcon(
                                  FontAwesomeIcons.thumbsUp,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('1개'),
                            ],
                          ),
                          Text('공유 1회')
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //좋아요
                          Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.thumbsUp,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('좋아요'),
                            ],
                          ),
                          //댓글
                          Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.comment,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('댓글'),
                            ],
                          ),
                          //복사
                          Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.copy,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('복사'),
                            ],
                          ),
                          //공유하기
                          Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.share,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('공유하기'),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: Divider(
              thickness: 8,
            ),
          ),
          //content3
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.blue,
                                  backgroundImage: AssetImage(
                                      'assets/images/facebook/user3.jpg'),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '윤보환',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          '회원님을 위한 추천 · 36분 · ',
                                          maxLines: 2,
                                          style: TextStyle(fontSize: 11),
                                        ),
                                        FaIcon(
                                          FontAwesomeIcons.earthAmericas,
                                          size: 16,
                                          color: Colors.grey[500],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    '···',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const FaIcon(
                                      FontAwesomeIcons.xmark,
                                      color: Colors.grey,
                                    ))
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          '연말 연시 따뜻한 감성',
                          maxLines: 2,
                        ),
                        const SizedBox(
                          height: 5,
                        )
                      ]),
                ),
                StaggeredGrid.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  children: const [
                    StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 2,
                      child: Tile3(index: 0),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 2,
                      child: Tile3(index: 1),
                    ),
                  ],
                ),
                //좋아요 ...
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 13,
                                child: FaIcon(
                                  FontAwesomeIcons.thumbsUp,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('1개'),
                            ],
                          ),
                          Text('공유 1회')
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //좋아요
                          Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.thumbsUp,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('좋아요'),
                            ],
                          ),
                          //댓글
                          Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.comment,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('댓글'),
                            ],
                          ),
                          //복사
                          Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.copy,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('복사'),
                            ],
                          ),
                          //공유하기
                          Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.share,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('공유하기'),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/facebook/story$index.jpg',
      fit: BoxFit.cover,
    );
  }
}

class Tile2 extends StatelessWidget {
  const Tile2({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/facebook/content$index.jpg',
      fit: BoxFit.cover,
    );
  }
}

class Tile3 extends StatelessWidget {
  const Tile3({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/facebook/contentA$index.jpg',
      fit: BoxFit.cover,
    );
  }
}
