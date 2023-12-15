import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/widgets/code.dart';

class Todo {
  final int id;
  final String description;
  const Todo({required this.id, required this.description});
  @override
  String toString() {
    return 'Todo(id:$id, description:$description)';
  }
}

class Movie {
  final int id;
  final String title;
  const Movie({required this.id, required this.title});
  @override
  String toString() {
    return 'Movie(id:$id, title:$title)';
  }
}

class RxDartScreen extends StatefulWidget {
  const RxDartScreen({super.key});

  @override
  State<RxDartScreen> createState() => _RxDartScreenState();
}

class _RxDartScreenState extends State<RxDartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RxDart'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Builder(
                builder: (context) {
                  final todoStreamController = StreamController();
                  todoStreamController.add(
                    const Todo(id: 0, description: 'bbumi'),
                  );
                  todoStreamController.add(
                    const Todo(id: 1, description: 'ddori'),
                  );
                  //생성
                  final todoStream =
                      todoStreamController.stream.asBroadcastStream();
                  //구독
                  todoStream.listen(
                    (event) {
                      print('listen1:$event');
                    },
                  );
                  todoStream.listen(
                    (event) {
                      print('listen2:$event');
                    },
                  );

                  todoStreamController.add(
                    const Todo(id: 2, description: 'kkambong'),
                  );
                  return const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Code(
                        r'''
            final todoStreamController = StreamController();
            todoStreamController.add(
              Todo(id: 0, description: 'bbumi'),
            );
            todoStreamController.add(
              Todo(id: 1, description: 'ddori'),
            );
          
            final todoStream = todoStreamController.stream.asBroadcastStream();
            //구독
            todoStream.listen(
              (event) {
          print('listen1:$event');
              },
            );
            todoStream.listen(
              (event) {
          print('listen2:$event');
              },
            );
          
            todoStreamController.add(
              Todo(id: 2, description: 'kkambong'),
            );
          ''',
                        title: '일반 StreamController',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Code(
                        '''
          listen1:Todo(id:0, description:bbumi)
          listen2:Todo(id:0, description:bbumi)
          listen1:Todo(id:1, description:ddori)
          listen2:Todo(id:1, description:ddori)
          listen1:Todo(id:2, description:kkambong)
          listen2:Todo(id:2, description:kkambong)
          ''',
                        title: '결과',
                        bgColor: Color.fromARGB(99, 54, 152, 244),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                width: 10,
              ),
              Builder(
                builder: (context) {
                  final todoStreamController = PublishSubject();
                  todoStreamController.add(
                    const Todo(id: 0, description: 'bbumi'),
                  );
                  todoStreamController.add(
                    const Todo(id: 1, description: 'ddori'),
                  );
                  //생성
                  final todoStream =
                      todoStreamController.stream.asBroadcastStream();
                  //구독
                  todoStream.listen(
                    (event) {
                      print('listen1:$event');
                    },
                  );
                  todoStream.listen(
                    (event) {
                      print('listen2:$event');
                    },
                  );

                  todoStreamController.add(
                    const Todo(id: 2, description: 'kkambong'),
                  );
                  return const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Code(
                        r'''
            final todoStreamController = PublishSubject();
                  todoStreamController.add(
                    const Todo(id: 0, description: 'bbumi'),
                  );
                  todoStreamController.add(
                    const Todo(id: 1, description: 'ddori'),
                  );
                  //생성
                  final todoStream =
                      todoStreamController.stream.asBroadcastStream();
                  //구독
                  todoStream.listen(
                    (event) {
                      print('listen1:$event');
                    },
                  );
                  todoStream.listen(
                    (event) {
                      print('listen2:$event');
                    },
                  );
          
                  todoStreamController.add(
                    const Todo(id: 2, description: 'kkambong'),
                  );
          ''',
                        title: 'PublishSubject 리스너 추가 이후 stream data에 반응',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Code(
                        '''
          listen1:Todo(id:2, description:kkambong)
          listen2:Todo(id:2, description:kkambong)
          ''',
                        title: '결과',
                        bgColor: Color.fromARGB(99, 54, 152, 244),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                width: 10,
              ),
              Builder(
                builder: (context) {
                  final todoStreamController = BehaviorSubject();
                  todoStreamController.add(
                    const Todo(id: 0, description: 'bbumi'),
                  );
                  todoStreamController.add(
                    const Todo(id: 1, description: 'ddori'),
                  );
                  //생성
                  final todoStream =
                      todoStreamController.stream.asBroadcastStream();
                  //구독
                  todoStream.listen(
                    (event) {
                      print('listen1:$event');
                    },
                  );
                  todoStream.listen(
                    (event) {
                      print('listen2:$event');
                    },
                  );

                  todoStreamController.add(
                    const Todo(id: 2, description: 'kkambong'),
                  );
                  return const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Code(
                        r'''
              final todoStreamController = BehaviorSubject();
  todoStreamController.add(
    Todo(id: 0, description: 'bbumi'),
  );
  todoStreamController.add(
    Todo(id: 1, description: 'ddori'),
  );
  //생성
  final todoStream = todoStreamController.stream.asBroadcastStream();
  //구독
  todoStream.listen(
    (event) {
      print('listen1:$event');
    },
  );
  todoStream.listen(
    (event) {
      print('listen2:$event');
    },
  );

  todoStreamController.add(
    Todo(id: 2, description: 'kkambong'),
  );
          ''',
                        title:
                            'BehaviorSubject 리스너 추가 직전 하나 포함 이후 stream data에 반응',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Code(
                        '''
          listen1:Todo(id:1, description:ddori)
          listen2:Todo(id:1, description:ddori)
          listen1:Todo(id:2, description:kkambong)
          listen2:Todo(id:2, description:kkambong)
          ''',
                        title: '결과',
                        bgColor: Color.fromARGB(99, 54, 152, 244),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                width: 10,
              ),
              Builder(
                builder: (context) {
                  final todoStreamController = BehaviorSubject<Todo>.seeded(
                      const Todo(id: -1, description: 'create'));
                  print(
                      '1. todoStreamController.value:${todoStreamController.value}');
                  todoStreamController.add(
                    const Todo(id: 0, description: 'bbumi'),
                  );
                  todoStreamController.add(
                    const Todo(id: 1, description: 'ddori'),
                  );

                  final todoStream =
                      todoStreamController.stream.asBroadcastStream();
                  print(
                      '2. todoStreamController.value:${todoStreamController.value}');
                  //구독
                  todoStream.listen(
                    (event) {
                      print('listen1:$event');
                    },
                  );
                  todoStream.listen(
                    (event) {
                      print('listen2:$event');
                    },
                  );

                  todoStreamController.add(
                    const Todo(id: 2, description: 'kkambong'),
                  );

                  print(
                      '3. todoStreamController.value:${todoStreamController.value}');
                  return const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Code(
                        r'''
                final todoStreamController =
      BehaviorSubject<Todo>.seeded(Todo(id: -1, description: 'create'));
  print('1. todoStreamController.value:${todoStreamController.value}');
  todoStreamController.add(
    Todo(id: 0, description: 'bbumi'),
  );
  todoStreamController.add(
    Todo(id: 1, description: 'ddori'),
  );

  final todoStream = todoStreamController.stream.asBroadcastStream();
  print('2. todoStreamController.value:${todoStreamController.value}');
  //구독
  todoStream.listen(
    (event) {
      print('listen1:$event');
    },
  );
  todoStream.listen(
    (event) {
      print('listen2:$event');
    },
  );

  todoStreamController.add(
    Todo(id: 2, description: 'kkambong'),
  );

  print('3. todoStreamController.value:${todoStreamController.value}');
          ''',
                        title: 'BehaviorSubject with seeded',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Code(
                        '''
          1. todoStreamController.value:Todo(id: -1, description: create)
          2. todoStreamController.value:Todo(id: 1, description: ddori)
          3. todoStreamController.value:Todo(id: 2, description: kkambong)
          listen1:Todo(id: 1, description: ddori)
          listen2:Todo(id: 1, description: ddori)
          listen1:Todo(id: 2, description: kkambong)
          listen2:Todo(id: 2, description: kkambong)
          ''',
                        title: '결과',
                        bgColor: Color.fromARGB(99, 54, 152, 244),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                width: 10,
              ),
              Builder(
                builder: (context) {
                  final todoStreamController = ReplaySubject();
                  todoStreamController.add(
                    const Todo(id: 0, description: 'bbumi'),
                  );
                  todoStreamController.add(
                    const Todo(id: 1, description: 'ddori'),
                  );
                  //생성
                  final todoStream =
                      todoStreamController.stream.asBroadcastStream();
                  //구독
                  todoStream.listen(
                    (event) {
                      print('listen1:$event');
                    },
                  );
                  todoStream.listen(
                    (event) {
                      print('listen2:$event');
                    },
                  );

                  todoStreamController.add(
                    const Todo(id: 2, description: 'kkambong'),
                  );
                  return const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Code(
                        r'''
                final todoStreamController = ReplaySubject();
                  todoStreamController.add(
                    const Todo(id: 0, description: 'bbumi'),
                  );
                  todoStreamController.add(
                    const Todo(id: 1, description: 'ddori'),
                  );
                  //생성
                  final todoStream =
                      todoStreamController.stream.asBroadcastStream();
                  //구독
                  todoStream.listen(
                    (event) {
                      print('listen1:$event');
                    },
                  );
                  todoStream.listen(
                    (event) {
                      print('listen2:$event');
                    },
                  );

                  todoStreamController.add(
                    const Todo(id: 2, description: 'kkambong'),
                  );
          ''',
                        title: 'ReplaySubject 맨 처음 data부터 전부 다 반응한다.',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Code(
                        '''
          listen1:Todo(id: 0, description: bbumi)
          listen2:Todo(id: 0, description: bbumi)
          listen1:Todo(id: 1, description: ddori)
          listen2:Todo(id: 1, description: ddori)
          listen1:Todo(id: 2, description: kkambong)
          listen2:Todo(id: 2, description: kkambong)
          ''',
                        title: '결과',
                        bgColor: Color.fromARGB(99, 54, 152, 244),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                width: 20,
              ),
              Builder(
                builder: (context) {
                  Stream<String> streamA() async* {
                    List<String> list = ['a1', 'b1', 'c1'];
                    for (int i = 0; i < list.length; i++) {
                      yield list[i];
                      await Future.delayed(const Duration(seconds: 1));
                    }
                  }

                  Stream<String> streamB() async* {
                    List<String> list = ['A2', 'B2', 'C2'];
                    for (int i = 0; i < list.length; i++) {
                      yield list[i];
                      await Future.delayed(const Duration(seconds: 1));
                    }
                  }

                  final combineLatestList = Rx.merge([
                    streamA(),
                    streamB(),
                  ]);

                  combineLatestList.listen((event) {
                    print(event);
                  });

                  return const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Code('''
Stream<String> streamA() async* {
                    List<String> list = ['a1', 'b1', 'c1'];
                    for (int i = 0; i < list.length; i++) {
                      yield list[i];
                      await Future.delayed(const Duration(seconds: 1));
                    }
                  }

                  Stream<String> streamB() async* {
                    List<String> list = ['A2', 'B2', 'C2'];
                    for (int i = 0; i < list.length; i++) {
                      yield list[i];
                      await Future.delayed(const Duration(seconds: 1));
                    }
                  }

                  final combineLatestList = Rx.merge([
                    streamA(),
                    streamB(),
                  ]);

                  combineLatestList.listen((event) {
                    print(event);
                  });
''', title: 'Rx.merge'),
                      SizedBox(
                        height: 10,
                      ),
                      Code(
                        '''
a1
A2
b1
B2
c1
C2
''',
                        title: '결과',
                        bgColor: Color.fromARGB(99, 54, 152, 244),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                width: 20,
              ),
              Builder(
                builder: (context) {
                  Stream<List<int>> favouriteMovieIDs() async* {
                    yield [0];
                    await Future.delayed(const Duration(seconds: 1));
                    yield [0, 1];
                    await Future.delayed(const Duration(seconds: 1));
                    yield [1];
                    await Future.delayed(const Duration(seconds: 1));
                    yield [2, 3];
                  }

                  Stream<List<Movie>> allMovies() async* {
                    yield [
                      const Movie(id: 0, title: 'titanic'),
                      const Movie(id: 1, title: 'avatar'),
                      const Movie(id: 2, title: 'iron man'),
                      const Movie(id: 3, title: 'transformer'),
                    ];
                  }

                  Stream<List<Movie>> favouriteMovies() {
                    final combine = Rx.combineLatest2(
                        allMovies(), favouriteMovieIDs(),
                        (List<Movie> allMovies, List<int> favouriteMovieIDs) {
                      return allMovies
                          .where(
                              (movie) => favouriteMovieIDs.contains(movie.id))
                          .toList();
                    });
                    return combine;
                  }

                  favouriteMovies().listen((event) {
                    print('favouriteMovies : $event');
                  });

                  return const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Code(r'''
Stream<List<int>> favouriteMovieIDs() async* {
                    yield [0];
                    await Future.delayed(const Duration(seconds: 1));
                    yield [0, 1];
                    await Future.delayed(const Duration(seconds: 1));
                    yield [1];
                    await Future.delayed(const Duration(seconds: 1));
                    yield [2, 3];
                  }

                  Stream<List<Movie>> allMovies() async* {
                    yield [
                      const Movie(id: 0, title: 'titanic'),
                      const Movie(id: 1, title: 'avatar'),
                      const Movie(id: 2, title: 'iron man'),
                      const Movie(id: 3, title: 'transformer'),
                    ];
                  }

                  Stream<List<Movie>> favouriteMovies() {
                    final combine = Rx.combineLatest2(
                        allMovies(), favouriteMovieIDs(),
                        (List<Movie> allMovies, List<int> favouriteMovieIDs) {
                      return allMovies
                          .where(
                              (movie) => favouriteMovieIDs.contains(movie.id))
                          .toList();
                    });
                    return combine;
                  }

                  favouriteMovies().listen((event) {
                    print('favouriteMovies : $event');
                  });
''', title: 'Rx.combineLatest2'),
                      SizedBox(
                        height: 10,
                      ),
                      Code(
                        '''
favouriteMovies : [Todo(id:0, title:titanic)]
favouriteMovies : [Todo(id:0, title:titanic), Todo(id:1, title:avatar)]
favouriteMovies : [Todo(id:1, title:avatar)]
favouriteMovies : [Todo(id:2, title:iron man), Todo(id:3, title:transformer)]
''',
                        title: '결과',
                        bgColor: Color.fromARGB(99, 54, 152, 244),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
