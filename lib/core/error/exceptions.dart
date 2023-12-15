class ServerException implements Exception {
  final int? statusCode;
  final String? message;
  ServerException({this.statusCode, this.message});
}
