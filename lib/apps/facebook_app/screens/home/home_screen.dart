import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
                                        ))
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
        )
      ],
    );
  }
}
