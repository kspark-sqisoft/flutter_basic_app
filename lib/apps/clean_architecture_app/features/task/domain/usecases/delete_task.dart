import 'package:dartz/dartz.dart' hide Task;
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class DeleteTask extends UseCase<Unit, DeleteTaskParams> {
  final TaskRepository repository;
  DeleteTask({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(DeleteTaskParams params) async {
    return await repository.deleteTask(params.task);
  }
}

class DeleteTaskParams extends Equatable {
  final Task task;
  const DeleteTaskParams({required this.task});

  @override
  List<Object?> get props => [task];
}
