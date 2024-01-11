class ServerException implements Exception {
  final int? statusCode;
  final String? message;
  ServerException({this.statusCode, this.message});
}

class ParsingException implements Exception {}

class ConnectionException implements Exception {}

class UnKnownException implements Exception {}

class NoDataException implements Exception {}
