import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/task_repository.dart';

class DeleteTasks extends UseCase<Unit, NoParams> {
  final TaskRepository repository;
  DeleteTasks({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await repository.deleteTasks();
  }
}
