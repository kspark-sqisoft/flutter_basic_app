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
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 570,
            child: MediaKitVideoPlayer(
              path: 'https://www.pexels.com/download/video/5752729/',
              fit: BoxFit.cover,
            ),
          ),
        )
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
