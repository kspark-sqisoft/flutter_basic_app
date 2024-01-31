import 'dart:convert';

import 'package:flutter/material.dart';

enum StatusCode {
  badRequest(401, 'Bad request'),
  unAuthorized(401, 'Unauthorized'),
  forbidden(403, 'Forbidden'),
  notFound(404, 'Not found'),
  internalServerError(500, 'Internal server error'),
  notImplemented(501, 'Not implemented');

  const StatusCode(this.code, this.description);
  final int code;
  final String description;

  String toJson() => name;
  static StatusCode fromJson(Map<String, dynamic> json) {
    return values.firstWhere(
      (element) => element.code == json['code'],
      orElse: () => StatusCode.notImplemented,
    );
  }

  @override
  String toString() => 'StatusCode($code, $description)';
}

class DartEnumScreen extends StatefulWidget {
  const DartEnumScreen({super.key});

  @override
  State<DartEnumScreen> createState() => _DartEnumScreenState();
}

class _DartEnumScreenState extends State<DartEnumScreen> {
  @override
  void initState() {
    StatusCode statusCode = StatusCode.unAuthorized;
    print(statusCode.name);
    print(statusCode.code);
    print(statusCode.description);
    print(statusCode);

    String json = '''{"code":404}''';

    StatusCode statusCode2 = StatusCode.fromJson(jsonDecode(json));

    print(statusCode2.name);
    print(statusCode2.code);
    print(statusCode2.description);
    print(statusCode2);

    processStatus(statusCode2);
    super.initState();
  }

  void processStatus(StatusCode statusCode) {
    return switch (statusCode) {
      StatusCode.badRequest => print('badRequest'),
      StatusCode.unAuthorized => print('unAuthorized'),
      StatusCode.forbidden => print('forbidden'),
      StatusCode.notFound => print('notFound'),
      StatusCode.internalServerError => print('internalServerError'),
      StatusCode.notImplemented => print('notImplemented'),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dart Enum')),
    );
  }
}
