import 'package:tasktest/domain/entities/task.dart';
import 'package:tasktest/domain/repositories/task_repository_interface.dart';

class GetTasks {
  final TaskRepositoryInterface repository;

  GetTasks(this.repository);

  Future<List<Task>> call() {
    return repository.getTasks();
  }
}
