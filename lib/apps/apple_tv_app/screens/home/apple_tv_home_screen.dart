import 'dart:developer';

import 'package:flutter/material.dart';

List<String> _upNextMovies = [
  'oppenheimer.jpg',
  'Emancipation.jpeg',
  'foundation.jpg',
  'Invasion.jpg',
  'Silo.jpg',
  'TedLasso.jpg',
  'The-Last-Thing-He-Told-Me-EPKTV.png',
];
List<String> _toChartMovies = [
  'The_Buccaneers.jpg',
  'Silo2.jpg',
  'Emancipation.jpeg',
  'oppenheimer.jpg',
  'foundation.jpg',
  'Invasion.jpg',
  'The-Last-Thing-He-Told-Me-EPKTV.png',
];

class AppleTVHomeScreen extends StatefulWidget {
  const AppleTVHomeScreen({super.key});

  @override
  State<AppleTVHomeScreen> createState() => _AppleTVHomeScreenState();
}

class _AppleTVHomeScreenState extends State<AppleTVHomeScreen> {
  static const kExpandedHeight = 510.0;
  late ScrollController _scrollController;

  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > kExpandedHeight - kToolbarHeight;
  }

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: false,
            pinned: true,
            snap: false, //floating true 일때만 적용
            stretch: false,
            stretchTriggerOffset: 150,
            onStretchTrigger: () async {
              log('onStretchTrigger');
            },
            centerTitle: false,
            backgroundColor: Colors.black.withOpacity(.8),

            expandedHeight: 510,
            collapsedHeight: 60,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.fadeTitle,
                StretchMode.zoomBackground,
                StretchMode.blurBackground
              ],
              expandedTitleScale: 1,
              titlePadding: EdgeInsets.zero,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/samples/movies/oppenheimer.jpg',
                    fit: BoxFit.cover,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '홈',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 28),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(.5),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {},
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(
                                    Icons.add,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'KP',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.all(18),
                child: _isSliverAppBarExpanded
                    ? const Text(
                        '홈',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )
                    : null,
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Up Next',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 20),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                height: 130,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ClipPath(
                        clipper: ShapeBorderClipper(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        child: Image.asset(
                          'assets/images/samples/movies/${_upNextMovies[index]}',
                          fit: BoxFit.cover,
                          width: 200,
                          height: 130,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Top Chart: Apple TV+ >',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ClipPath(
                            clipper: ShapeBorderClipper(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            child: Image.asset(
                              'assets/images/samples/movies/${_toChartMovies[index]}',
                              fit: BoxFit.cover,
                              width: 180,
                              height: 100,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${index + 1}',
                              style: const TextStyle(fontSize: 24),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 160,
                                  child: Text(
                                    _upNextMovies[index].split('.').first,
                                    maxLines: 2,
                                  ),
                                ),
                                const Text(
                                  '1965년 - Holiday',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Explore Challels & Apps',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ClipPath(
                        clipper: ShapeBorderClipper(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        child: Stack(
                          //fit: StackFit.expand,
                          children: [
                            Image.asset(
                              'assets/images/samples/movies/${_toChartMovies[index]}',
                              fit: BoxFit.cover,
                              width: 130,
                              height: 200,
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: 130,
                                height: 70,
                                color: Colors.black.withOpacity(.8),
                                child: const Center(
                                  child: SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(60)),
                                      child: Image(
                                        fit: BoxFit.contain,
                                        image: AssetImage(
                                            'assets/images/apple/apple-tv-hd-logo2.png'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
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
