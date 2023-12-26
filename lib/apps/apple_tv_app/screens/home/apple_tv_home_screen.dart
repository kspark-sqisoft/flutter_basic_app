import 'package:flutter/material.dart';

List<String> _movies = [
  'oppenheimer.jpg',
  'Emancipation.jpeg',
  'foundation.jpg',
  'Invasion.jpg',
  'Silo.jpg',
  'TedLasso.jpg',
  'The-Last-Thing-He-Told-Me-EPKTV.png',
];

class AppleTVHomeScreen extends StatelessWidget {
  const AppleTVHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            floating: true,
            pinned: false,
            snap: true,
            stretch: true,
            title: Text(
              '홈',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 500,
              color: Colors.red,
              child: Image.asset(
                'assets/images/samples/movies/oppenheimer.jpg',
                fit: BoxFit.cover,
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
                          'assets/images/samples/movies/${_movies[index]}',
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
                    _movies.shuffle();
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
                              'assets/images/samples/movies/${_movies[index]}',
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
                                    _movies[index].split('.').first,
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
          )
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
