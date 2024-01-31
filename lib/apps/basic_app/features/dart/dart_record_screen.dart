import 'package:flutter/material.dart';

import '../../../../core/widgets/code.dart';
import '../rxdart/rxdart_screen.dart';

//record 포지셔널
const (int, String) person = (1, 'keesoon');
//record 네임드
const ({int studentId, String studentName}) student =
    (studentId: 1, studentName: 'keesoon');
//record 혼합(포지셔널+네임드)
const (int, {String teacherNickName, String teacherName}) teacher =
    (1, teacherNickName: 'willy', teacherName: 'keesoon');

//map
const Map<String, dynamic> post = {'postId': 1, 'title': '제목', 'content': '내용'};
//list
const List<Product> products = [
  Product(productId: 0, productName: 'iPhone'),
  Product(productId: 1, productName: 'Macbook'),
  Product(productId: 2, productName: 'iPad'),
  Product(productId: 3, productName: 'Watch'),
];
//custom class
const product = Product(productId: 0, productName: 'iPhone');
//seled class
final desktop = Desktop(name: '조립PC', serialNo: 'no129475');
final macbook = Notebook(name: '맥북', serialNo: 'se567890');
final laptop = Notebook(name: '맥북', serialNo: 'se567890');

class Product {
  const Product({
    required this.productId,
    required this.productName,
  });
  final int productId;
  final String productName;
  @override
  String toString() {
    return 'Product(productId:$productId, productName:$productName)';
  }
}

sealed class Laptop {
  final String name;
  final String serialNo;
  Laptop({required this.name, required this.serialNo});
}

class Notebook extends Laptop {
  Notebook({required super.name, required super.serialNo});
}

class Desktop extends Laptop {
  Desktop({required super.name, required super.serialNo});
}

class DartRecordScreen extends StatelessWidget {
  const DartRecordScreen({super.key});
  static const routeName = '/dart';

  @override
  Widget build(BuildContext context) {
    //record 포지셔널 구조분해
    final (i, n) = person;
    print(i);
    print(n);

    //record 네임드 구조분해
    final (:studentId, :studentName) = student;
    print(studentId);
    print(studentName);

    //record 혼합(포지셔널+네임드) 구조분해
    final (id, :teacherNickName, :teacherName) = teacher;
    print(id);
    print(teacherNickName);
    print(teacherName);

    //map 구조분해
    final {'postId': postId, 'title': title, 'content': content} = post;
    print(postId);
    print(title);
    print(content);

    //list 구조분해
    final [item0, item1, item2, item3] = products;
    print(item0);
    print(item1);
    print(item2);
    print(item3);

    final [firstItem, ...rest] = products;
    print(firstItem);
    print(rest);

    //class (custom object) 구조분해
    final Product(:productId, :productName) = product;
    print(productId);
    print(productName);

    //selead class switch 구문 패턴 매칭
    final result = switch (laptop) {
      Desktop(name: final name, serialNo: final serialNo) =>
        'Desktop(name:$name, serialNo:$serialNo)',
      Notebook(:final name, :final serialNo) =>
        'Notebook(name:$name, serialNo:$serialNo)',
    };
    print(result);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dart Record'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Theme.of(context).colorScheme.primaryContainer,
                height: 50,
                child: const Center(child: Text('타입 구조 분해')),
              ),
              const SizedBox(
                height: 5,
              ),
              const Row(
                children: [
                  Code(
                    '''
const (int, String) person = (1, 'keesoon');
          ''',
                    title: 'record 포지셔널',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Code(
                    '''
final (i, n) = person;
          ''',
                    bgColor: Color.fromARGB(99, 54, 152, 244),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Code(
                    '''
const ({int studentId, String studentName}) student =
    (studentId: 1, studentName: 'keesoon');
          ''',
                    title: 'record 네임드',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Code(
                    '''
final (:studentId, :studentName) = student;
          ''',
                    bgColor: Color.fromARGB(99, 54, 152, 244),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Code(
                    '''
const (int, {String teacherNickName, String teacherName}) teacher =
    (1, teacherNickName: 'willy', teacherName: 'keesoon');
          ''',
                    title: 'record 혼합(포지셔널+네임드)',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Code(
                    '''
final (id, :teacherNickName, :teacherName) = teacher;
          ''',
                    bgColor: Color.fromARGB(99, 54, 152, 244),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Code(
                    '''
const Map<String, dynamic> post = {'postId': 1, 'title': '제목', 'content': '내용'};
          ''',
                    title: 'map',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Code(
                    '''
final {'postId': postId, 'title': title, 'content': content} = post;
          ''',
                    bgColor: Color.fromARGB(99, 54, 152, 244),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Code(
                    '''
const List<Product> products = [
  Product(productId: 0, productName: 'iPhone'),
  Product(productId: 1, productName: 'Macbook'),
  Product(productId: 2, productName: 'iPad'),
  Product(productId: 3, productName: 'Watch'),
];
          ''',
                    title: 'list',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Code(
                    '''
final [item0, item1, item2, item3] = products;

final [firstItem, ...rest] = products;
          ''',
                    bgColor: Color.fromARGB(99, 54, 152, 244),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Code(
                    '''
const product = Product(productId: 0, productName: 'iPhone');
          ''',
                    title: 'object(class)',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Code(
                    '''
final Product(:productId, :productName) = product;
          ''',
                    bgColor: Color.fromARGB(99, 54, 152, 244),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Code('''
final laptop = Notebook(name: '맥북', serialNo: 'se567890');
          ''', title: 'sealed class'),
                  SizedBox(
                    width: 10,
                  ),
                  Code(
                    r'''
final result = switch (laptop) {
      Desktop(name: final name, serialNo: final serialNo) =>
        'Desktop(name:$name, serialNo:$serialNo)',
      Notebook(:final name, :final serialNo) =>
        'Notebook(name:$name, serialNo:$serialNo)',
    };
          ''',
                    bgColor: Color.fromARGB(99, 54, 152, 244),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Theme.of(context).colorScheme.primaryContainer,
                height: 50,
                child: const Center(child: Text('코드 스닙펫')),
              ),
              const SizedBox(
                height: 5,
              ),
              Builder(
                builder: (context) {
                  List<int> nums = [1, 2, 3];
                  final newNums = nums..addAll([4, 5]);
                  print('nums:$nums');
                  print('nums.hashCode:${nums.hashCode}');
                  print('newNums:$newNums');
                  print('newNums.hashCode:${newNums.hashCode}');
                  return const Row(
                    children: [
                      Code('''
List<int> nums = [1, 2, 3];
                final newNums = nums..addAll([4, 5]);
                print(newNums);
          ''', title: '..addAll 리턴 받음'),
                      SizedBox(
                        width: 10,
                      ),
                      Code(
                        r'''
[1, 2, 3, 4, 5]
                            ''',
                        bgColor: Color.fromARGB(99, 54, 152, 244),
                      )
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 5,
              ),
              Builder(
                builder: (context) {
                  List<int> nums = [1, 2, 3];
                  print('nums.hashCode:${nums.hashCode}');
                  nums.addAll([4, 5]);
                  print('nums:$nums');
                  print('nums.hashCode:${nums.hashCode}');
                  return const Row(
                    children: [
                      Code('''
List<int> nums = [1, 2, 3];
                  nums.addAll([4, 5]);
                  print(nums);
          ''', title: '.addAll'),
                      SizedBox(
                        width: 10,
                      ),
                      Code(
                        r'''
[1, 2, 3, 4, 5]
                            ''',
                        bgColor: Color.fromARGB(99, 54, 152, 244),
                      )
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 5,
              ),
              Builder(
                builder: (context) {
                  List<int> nums = [1, 2, 3];
                  List<int> newNums = [...nums, 4, 5];
                  print(newNums);
                  return const Row(
                    children: [
                      Code('''
List<int> nums = [1, 2, 3];
    List<int> newNums = [...nums, 4, 5];
    print(newNums);
          ''', title: '...'),
                      SizedBox(
                        width: 10,
                      ),
                      Code(
                        r'''
[1, 2, 3, 4, 5]
                            ''',
                        bgColor: Color.fromARGB(99, 54, 152, 244),
                      )
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 5,
              ),
              Builder(
                builder: (context) {
                  List<Movie> movies = [
                    const Movie(id: 1, title: 'Titanic'),
                    const Movie(id: 2, title: 'Avata'),
                    const Movie(id: 3, title: 'Spider Man'),
                    const Movie(id: 4, title: 'Transformer'),
                    const Movie(id: 5, title: 'Iron Man'),
                  ];

                  List<int> favoriteMovieIDs = [1, 3, 4];

                  List<Movie> favoriteMovies = movies
                      .where((movie) => favoriteMovieIDs.contains(movie.id))
                      .toList();

                  print(favoriteMovies);
                  return const Row(
                    children: [
                      Code('''
List<Movie> movies = [
                    const Movie(id: 1, title: 'Titanic'),
                    const Movie(id: 2, title: 'Avata'),
                    const Movie(id: 3, title: 'Spider Man'),
                    const Movie(id: 4, title: 'Transformer'),
                    const Movie(id: 5, title: 'Iron Man'),
                  ];

                  List<int> favoriteMovieIDs = [1, 3, 4];

                  List<Movie> favoriteMovies = movies
                      .where((movie) => favoriteMovieIDs.contains(movie.id))
                      .toList();

                  print(favoriteMovies);
          ''', title: 'where contains'),
                      SizedBox(
                        width: 10,
                      ),
                      Code(
                        r'''
[Movie(id:1, title:Titanic), Movie(id:3, title:Spider Man), Movie(id:4, title:Transformer)]
                            ''',
                        bgColor: Color.fromARGB(99, 54, 152, 244),
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
