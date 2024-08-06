import 'package:tasktest/domain/entities/task.dart';
import 'package:tasktest/domain/repositories/task_repository_interface.dart';

class AddTask {
  final TaskRepositoryInterface repository;

  AddTask(this.repository);

  Future<void> call(Task task) {
    return repository.addTask(task);
  }
}
