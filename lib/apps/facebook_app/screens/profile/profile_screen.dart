import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          centerTitle: true,
          pinned: true,
          scrolledUnderElevation: 0,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
              ),
              Text(
                '박기순',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                width: 5,
              ),
              CircleAvatar(
                radius: 10,
                backgroundColor: Colors.red,
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.one,
                    size: 11,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              FaIcon(FontAwesomeIcons.caretDown)
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    maxRadius: 20,
                    backgroundColor: Colors.grey[100],
                    child: const FaIcon(
                      FontAwesomeIcons.pen,
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
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 260,
                    child: Image.asset(
                      'assets/images/facebook/profile_bg.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
              Positioned(
                top: 150,
                left: 10,
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 68,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(68),
                        child:
                            Image.asset('assets/images/facebook/profile.jpg')),
                  ),
                ),
              ),
              Positioned(
                top: 260,
                left: 110,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.grey[200]!,
                    child: const FaIcon(
                      FontAwesomeIcons.camera,
                      size: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 210,
                right: 20,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.grey[200]!,
                    child: const FaIcon(
                      FontAwesomeIcons.camera,
                      size: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(8),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text(
                      '박기순 ',
                      style: TextStyle(fontSize: 20),
                    ),
                    FaIcon(
                      FontAwesomeIcons.chevronRight,
                      size: 16,
                    )
                  ],
                ),
                const Row(
                  children: [
                    Text(
                      '친구 ',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      '160',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '명',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    )
                  ],
                ),
                const Row(
                  children: [
                    FaIcon(FontAwesomeIcons.heart,
                        size: 16, color: Colors.grey),
                    Text(' 기혼',
                        style: TextStyle(fontSize: 12, color: Colors.grey))
                  ],
                ),
                const Row(
                  children: [
                    FaIcon(FontAwesomeIcons.rss, size: 16, color: Colors.grey),
                    Text(' 21명이 팔로우함 ',
                        style: TextStyle(fontSize: 12, color: Colors.grey))
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // <-- Radius
                            ),
                          ),
                          child: const Text('+ 스토리에 추가'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // <-- Radius
                            ),
                          ),
                          child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(FontAwesomeIcons.pen, size: 16),
                                Text(' 프로필 편집')
                              ]),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // <-- Radius
                        ),
                      ),
                      child: const Text('...'),
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
        SliverPadding(
          padding: const EdgeInsets.all(8),
          sliver: SliverToBoxAdapter(
            child: Column(children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue[100],
                        foregroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // <-- Radius
                        ),
                      ),
                      child: const Text('게시물'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.black,
                        shadowColor: Colors.transparent,
                        surfaceTintColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // <-- Radius
                        ),
                      ),
                      child: const Text('사진'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.black,
                      shadowColor: Colors.transparent,
                      surfaceTintColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30), // <-- Radius
                      ),
                    ),
                    child: const Text('릴스'),
                  ),
                ],
              ),
              const Divider(),
            ]),
          ),
        ),
        const SliverPadding(
          padding: EdgeInsets.all(8),
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('친구'),
                    Text(
                      '친구 160명',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Text(
                  '친구 찾기',
                  style: TextStyle(color: Colors.lightBlue, fontSize: 12),
                )
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(8),
          sliver: SliverGrid.builder(
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisExtent: 170),
            itemBuilder: (context, index) => Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          'assets/images/facebook/friend$index.jpg',
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width / 3,
                          height: 100,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              '박기순',
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
