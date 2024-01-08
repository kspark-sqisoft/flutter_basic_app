import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../home/home_screen.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('알림'),
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
        const SliverPadding(
          padding: EdgeInsets.all(8),
          sliver: SliverToBoxAdapter(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '오늘',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ]),
          ),
        ),
        SliverList.builder(
          itemCount: 6,
          itemBuilder: (context, index) => Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 30,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      'assets/images/facebook/friend$index.jpg',
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${users[index]}님이 새로운 사진을 추가했습니다.',
                          maxLines: 2,
                        ),
                        const Text(
                          '1일',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        )
                      ]),
                ),
                const Text('...')
              ],
            ),
          ),
        ),
        const SliverPadding(
          padding: EdgeInsets.all(8),
          sliver: SliverToBoxAdapter(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '이전 알림',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ]),
          ),
        ),
        SliverList.builder(
          itemCount: 6,
          itemBuilder: (context, index) => Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 30,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      'assets/images/facebook/friend$index.jpg',
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${users[index]}님이 새로운 사진을 추가했습니다.',
                          maxLines: 2,
                        ),
                        const Text(
                          '1일',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        )
                      ]),
                ),
                const Text('...')
              ],
            ),
          ),
        ),
      ],
    );
  }
}
