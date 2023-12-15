import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/widgets/code.dart';

part 'json_parsing_screen.freezed.dart';
part 'json_parsing_screen.g.dart';

const postString = '''
{
    "userId":1,
    "id":1,
    "title":"sunt",
    "body":"quia"
}
''';
const postsString = '''
[
  {
    "userId":1,
    "id":1,
    "title":"sunt",
    "body":"quia"
  },
  {
    "userId":1,
    "id":2,
    "title":"qui",
    "body":"est"
  }
]
''';

@freezed
class Post with _$Post {
  const factory Post({
    int? userId,
    int? id,
    String? title,
    String? body,
  }) = _Post;
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}

class JsonParsingScreen extends StatelessWidget {
  const JsonParsingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final postJsonMap = jsonDecode(postString);
    final post = Post.fromJson(postJsonMap);
    print('post:$post');

    final postsJsonMap = jsonDecode(postsString);
    final posts =
        (postsJsonMap as List).map((post) => Post.fromJson(post)).toList();
    print('posts:$posts');

    return Scaffold(
      appBar: AppBar(title: const Text('Json Parsing')),
      body: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Code(
              '''
{
    "userId":1,
    "id":1,
    "title":"sunt",
    "body":"quia"
}
''',
              title: 'post.json',
            ),
            SizedBox(
              height: 5,
            ),
            Code(
              '''
final postJsonMap = jsonDecode(postString);
final post = Post.fromJson(postJsonMap);
''',
              bgColor: Color.fromARGB(115, 139, 159, 185),
            ),
          ],
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Code(
              '''
[
  {
    "userId":1,
    "id":1,
    "title":"sunt",
    "body":"quia"
  },
  {
    "userId":1,
    "id":2,
    "title":"qui",
    "body":"est"
  }
]
''',
              title: 'posts.json',
            ),
            SizedBox(
              height: 5,
            ),
            Code(
              '''
final postsJsonMap = jsonDecode(postsString);
final posts = (postsJsonMap as List).map((post) => Post.fromJson(post)).toList();
''',
              bgColor: Color.fromARGB(115, 139, 159, 185),
            ),
          ],
        )
      ]),
    );
  }
}
