import 'package:flutter/material.dart';

const rainbowColors = [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.blue,
  Colors.indigo,
  Colors.purple,
];

class CustomScrollViewScreen extends StatefulWidget {
  const CustomScrollViewScreen({super.key});

  @override
  State<CustomScrollViewScreen> createState() => _CustomScrollViewScreenState();
}

class _CustomScrollViewScreenState extends State<CustomScrollViewScreen> {
  final List<int> numbers = List.generate(7, (index) => index);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true, //내릴때 상단에 고정 되어 떠 있다.
            pinned: false, //완전 고정
            snap: true, //자석 효과 floating true에서 적용
            stretch: false, //
            expandedHeight: 200, //내리면 200으로 커짐
            collapsedHeight: 150, //위로 150보다 작아지면 앱바가 안보임
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://picsum.photos/600/400?random=10',
                fit: BoxFit.cover,
              ),
              title: const Text('FlexibleSpace'),
            ),
            title: const Text('CustomScrollView'),
          ),
          //단일 위젯 표현
          SliverToBoxAdapter(
            child: Container(
                color: Colors.grey,
                height: 100,
                child: const Center(
                  child: Text(
                    'SliverToBoxAdapter',
                    style: TextStyle(fontSize: 20),
                  ),
                )),
          ),
          SliverPersistentHeader(
            delegate: SliverFixedHeaderDelegate(
              maxHeight: 100,
              minHeight: 50,
              child: Container(
                color: Colors.grey.withOpacity(0.6),
                child: const Text(
                  'SliverPersistentHeader #1 SliverList',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              numbers
                  .map(
                    (e) => Card(
                      color: rainbowColors[e % rainbowColors.length],
                      index: e,
                      height: 50,
                    ),
                  )
                  .toList(),
            ),
          ),
          SliverPersistentHeader(
            delegate: SliverFixedHeaderDelegate(
              maxHeight: 100,
              minHeight: 50,
              child: Container(
                color: Colors.grey,
                child: const Text(
                  'SliverPersistentHeader #2 SliverList delegate',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Card(
                  color: rainbowColors[index % rainbowColors.length],
                  index: index,
                  height: 50,
                );
              },
              childCount: numbers.length,
            ),
          ),
          SliverPersistentHeader(
            delegate: SliverFixedHeaderDelegate(
              maxHeight: 100,
              minHeight: 50,
              child: Container(
                color: Colors.grey,
                child: const Text(
                  'SliverPersistentHeader #3 SliverList.builder',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          SliverList.builder(
            itemCount: numbers.length,
            itemBuilder: (context, index) => Card(
              color: rainbowColors[index % rainbowColors.length],
              index: index,
              height: 50,
            ),
          ),
          SliverPersistentHeader(
            delegate: SliverFixedHeaderDelegate(
              maxHeight: 100,
              minHeight: 50,
              child: Container(
                color: Colors.grey,
                child: const Text(
                  'SliverPersistentHeader #4 SliverGrid',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          SliverGrid(
            delegate: SliverChildListDelegate(
              numbers
                  .map(
                    (e) => Card(
                      color: rainbowColors[e % rainbowColors.length],
                      index: e,
                    ),
                  )
                  .toList(),
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
          ),
          SliverPersistentHeader(
            delegate: SliverFixedHeaderDelegate(
              maxHeight: 100,
              minHeight: 50,
              child: Container(
                color: Colors.grey,
                child: const Text(
                  'SliverPersistentHeader #5 SliverGrid delegate gridDelegate',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Card(
                  color: rainbowColors[index % rainbowColors.length],
                  index: index,
                );
              },
              childCount: numbers.length,
            ),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150),
          ),
          SliverPersistentHeader(
            delegate: SliverFixedHeaderDelegate(
              maxHeight: 100,
              minHeight: 50,
              child: Container(
                color: Colors.grey,
                child: const Text(
                  'SliverPersistentHeader #6 SliverGrid.builder',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          SliverGrid.builder(
            itemCount: 20,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6),
            itemBuilder: (context, index) => Card(
              color: rainbowColors[index % rainbowColors.length],
              index: index,
            ),
          ),
          SliverPersistentHeader(
            delegate: SliverFixedHeaderDelegate(
              maxHeight: 100,
              minHeight: 50,
              child: Container(
                color: Colors.grey,
                child: const Text(
                  'SliverPersistentHeader #7 SliverPadding',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverGrid.builder(
              itemCount: 20,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6),
              itemBuilder: (context, index) => Card(
                color: rainbowColors[index % rainbowColors.length],
                index: index,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Card extends StatelessWidget {
  const Card({
    super.key,
    required this.color,
    required this.index,
    this.height = 300,
  });
  final Color color;
  final int index;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 300,
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 30.0,
          ),
        ),
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
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverFixedHeaderDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.child != child;
  }
}
