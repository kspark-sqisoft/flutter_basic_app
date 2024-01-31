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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dart Enum')),
    );
  }
}
