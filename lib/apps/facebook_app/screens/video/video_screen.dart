import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../riverpod_app/pages/medias/media_kit_video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  List<String> menus = ['회원님을 위한 추천', '라이브', '게임', '릴스', '팔로잉'];
  int _currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('동영상'),
          scrolledUnderElevation: 0,
          floating: true,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    maxRadius: 20,
                    backgroundColor: Colors.grey[100],
                    child: const FaIcon(
                      FontAwesomeIcons.user,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    maxRadius: 20,
                    backgroundColor: Colors.grey[100],
                    child: const FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SliverPersistentHeader(
            delegate: SliverFixedHeaderDelegate(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 30,
                    child: ListView.builder(
                      itemCount: menus.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _currentTabIndex == index
                              ? Colors.blue.withOpacity(0.1)
                              : Colors.transparent,
                          elevation: 0,
                        ),
                        onPressed: () {
                          setState(() {
                            _currentTabIndex = index;
                          });
                        },
                        child: Text(
                          menus[index],
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          maxHeight: 60,
          minHeight: 40,
        )),
        const SliverToBoxAdapter(
          child: Divider(
            thickness: 8,
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'VieLax',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('2023년 12월 17일'),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(40, 40),
                          ),
                          child: const Text(
                            '···',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const FaIcon(
                            FontAwesomeIcons.xmark,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                child: Text(
                    'Going to the sea to catch fish looks very interesting'),
              ),
              const SizedBox(
                height: 570,
                child: MediaKitVideoPlayer(
                  path: 'https://www.pexels.com/download/video/5752729/',
                  fit: BoxFit.cover,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
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
                            Text('3,220개'),
                          ],
                        ),
                        Row(
                          children: [
                            Text('댓글 52개'),
                            SizedBox(
                              width: 5,
                            ),
                            Text('공유 144회'),
                            SizedBox(
                              width: 5,
                            ),
                            Text('조회 12.9만회'),
                          ],
                        )
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
      ],
    );
  }
}

class SliverFixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  SliverFixedHeaderDelegate({
    required this.child,
    required this.maxHeight,
    required this.minHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => maxHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverFixedHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.child != child;
  }
}
