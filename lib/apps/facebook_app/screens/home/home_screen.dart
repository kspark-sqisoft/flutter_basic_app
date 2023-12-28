import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../components/scaffold_with_bottom_navigation_bar.dart';

final users = ['', 'Metallica', '정수봉', '김대열', '성민창', 'iJustine'];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: hideBottomNavbar.controller,
      slivers: [
        SliverAppBar(
          floating: true,
          backgroundColor: Colors.white,
          centerTitle: false,
          title: Text(
            'facebook',
            style: TextStyle(
              color: Colors.blue[600],
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                maxRadius: 18,
                backgroundColor: Colors.grey[300],
                child: IconButton(
                  onPressed: () {},
                  icon: const FaIcon(
                    FontAwesomeIcons.plus,
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
                                      mainAxisAlignment: MainAxisAlignment.end,
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
                                    style: const TextStyle(color: Colors.white),
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
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          sliver: SliverToBoxAdapter(
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
                          backgroundImage:
                              AssetImage('assets/images/facebook/user3.jpg'),
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
                                  fontWeight: FontWeight.bold, fontSize: 11),
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
                        const Text(
                          '···',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
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
                const Column(
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                )
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: Divider(
            thickness: 8,
          ),
        ),
        //content2
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          sliver: SliverToBoxAdapter(
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
                          backgroundImage:
                              AssetImage('assets/images/facebook/user3.jpg'),
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
                                  fontWeight: FontWeight.bold, fontSize: 11),
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
                        const Text(
                          '···',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
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
                const Column(
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: Divider(
            thickness: 8,
          ),
        ),
        //content3
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          sliver: SliverToBoxAdapter(
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
                          backgroundImage:
                              AssetImage('assets/images/facebook/user3.jpg'),
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
                                  fontWeight: FontWeight.bold, fontSize: 11),
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
                        const Text(
                          '···',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
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
                const Column(
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                )
              ],
            ),
          ),
        ),
      ],
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
