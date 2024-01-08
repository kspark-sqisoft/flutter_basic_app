import 'package:flutter/material.dart';

import '../../../../core/widgets/code.dart';

class ShapesScreen extends StatelessWidget {
  const ShapesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shapes')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          width: 5,
                          color: Colors.orange,
                        ),
                      ),
                      child: const Text(
                        'Container Border.all',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Code('''
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            width: 5,
                            color: Colors.orange,
                          ),
                        ),
                        child: const Text(
                          'Container Border.all',
                          style: TextStyle(color: Colors.white),
                        ),
                    )
                    ''')
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.rectangle,
                        border: Border(
                            left: BorderSide(color: Colors.orange, width: 5)),
                      ),
                      child: const Text(
                        'Container Border BorderSide',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Code('''
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.rectangle,
                        border: Border(
                            left: BorderSide(color: Colors.orange, width: 5)),
                      ),
                      child: const Text(
                        'Container Border BorderSide',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
            ''')
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.rectangle,
                        border: Border.all(width: 5, color: Colors.orange),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: const Text(
                        'Container BorderRadius.all',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Code('''
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.rectangle,
                        border: Border.all(width: 5, color: Colors.orange),
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: const Text(
                        'Container BorderRadius.all',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
            ''')
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.rectangle,
                        gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.red,
                              Colors.blue,
                            ]),
                        border: Border.all(width: 5, color: Colors.orange),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: const Text(
                        'Container gradient',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Code('''
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.rectangle,
                        gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.red,
                              Colors.blue,
                            ]),
                        border: Border.all(width: 5, color: Colors.orange),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: const Text(
                        'Container gradient',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
''')
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.rectangle,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            spreadRadius: 3,
                          )
                        ],
                        border: Border.all(width: 5, color: Colors.orange),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: const Text(
                        'Container boxShadow',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Code('''
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.rectangle,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            spreadRadius: 3,
                          )
                        ],
                        border: Border.all(width: 5, color: Colors.orange),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: const Text(
                        'Container boxShadow',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
''')
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.rectangle,
                        border: Border.all(width: 5, color: Colors.orange),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                            size: 50,
                            color: Colors.white,
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Code('''
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.rectangle,
                    border: Border.all(width: 5, color: Colors.orange),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        size: 50,
                        color: Colors.white,
                      )),
                )''')
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(width: 5, color: Colors.orange),
                      ),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                            size: 50,
                            color: Colors.white,
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Code('''
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(width: 5, color: Colors.orange),
                  ),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        size: 50,
                        color: Colors.white,
                      )),
                )
            ''')
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        'Container BoxShape.circle',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Code('''
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    'Container BoxShape.circle',
                    style: TextStyle(color: Colors.white),
                  ),
                )
            ''')
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://picsum.photos/200/300?random=1'),
                        ),
                      ),
                      child: const Text(
                        'Container BoxShape.rectangle',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Code('''
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                          NetworkImage('https://picsum.photos/200/300?random=1'),
                    ),
                  ),
                  child: const Text(
                    'Container BoxShape.rectangle',
                    style: TextStyle(color: Colors.white),
                  ),
                )
            ''')
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://picsum.photos/200/300?random=8'),
                        ),
                      ),
                      child: const Text(
                        'Container BoxShape.circle with image',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Code('''
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                          NetworkImage('https://picsum.photos/200/300?random=8'),
                    ),
                  ),
                  child: const Text(
                    'Container BoxShape.circle with image',
                    style: TextStyle(color: Colors.white),
                  ),
                )
            ''')
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      child: Image(
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://picsum.photos/200/300?random=6'),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Code('''
                const ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  child: Image(
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    image: NetworkImage('https://picsum.photos/200/300?random=6'),
                  ),
                )
            ''')
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        NetworkImage('https://picsum.photos/200/300?random=10'),
                    child: Text(
                      'CircleAvatar backgroundImage',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Code('''
                const CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      NetworkImage('https://picsum.photos/200/300?random=10'),
                  child: Text(
                    'CircleAvatar backgroundImage',
                    style: TextStyle(color: Colors.white),
                  ),
                )
            ''')
                ]),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    ClipOval(
                      child: Image.network(
                        'https://picsum.photos/200/300?random=19',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Code('''
                ClipOval(
                  child: Image.network(
                    'https://picsum.photos/200/300?random=19',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                )
            ''')
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.network(
                        "https://picsum.photos/200/300?random=20",
                        color: Colors.red,
                        colorBlendMode: BlendMode.colorBurn,
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.fill,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Code('''
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.network(
                        "https://picsum.photos/200/300?random=20",
                        color: Colors.red,
                        colorBlendMode: BlendMode.colorBurn,
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.fill,
                      ),
                    )
''')
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                //test
                Row(
                  children: [
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SizedBox(
                        width: 250,
                        height: 400,
                        child: Column(
                          children: [
                            Image.network(
                              "https://picsum.photos/300/400?random=20",
                              fit: BoxFit.cover,
                              width: 250,
                              height: 300,
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.white,
                                child: const Center(
                                  child: Text(
                                    'Keesoon Park',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Code('''
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SizedBox(
                        width: 250,
                        height: 400,
                        child: Column(
                          children: [
                            Image.network(
                              "https://picsum.photos/300/400?random=20",
                              fit: BoxFit.cover,
                              width: 250,
                              height: 300,
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.white,
                                child: const Center(
                                  child: Text(
                                    'Keesoon Park',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
''')
                  ],
                ),
                //test end
                const SizedBox(
                  height: 20,
                ),
                //test
                Row(
                  children: [
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: CircleAvatar(
                        radius: 200,
                        backgroundColor: Colors.white,
                        child: Column(
                          children: [
                            Image.network(
                              "https://picsum.photos/400/400?random=20",
                              fit: BoxFit.cover,
                              width: 400,
                              height: 300,
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.white,
                                child: const Center(
                                  child: Text(
                                    'Keesoon Park',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Code('''
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: CircleAvatar(
                        radius: 200,
                        backgroundColor: Colors.white,
                        child: Column(
                          children: [
                            Image.network(
                              "https://picsum.photos/400/400?random=20",
                              fit: BoxFit.cover,
                              width: 400,
                              height: 300,
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.white,
                                child: const Center(
                                  child: Text(
                                    'Keesoon Park',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
''')
                  ],
                ),
                //test end
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
