import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;
  const Failure({this.message});

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure({super.message, this.statusCode});
  @override
  List<Object?> get props => [message, statusCode];

  @override
  String toString() {
    return 'ServerFailure($message, statusCode:$statusCode)';
  }
}

class ConnectionFailure extends Failure {
  const ConnectionFailure({super.message});
}
