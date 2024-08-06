
import 'package:tasktest/domain/repositories/task_repository_interface.dart';

class DeleteTask {
  final TaskRepositoryInterface repository;

  DeleteTask(this.repository);

  Future<void> call(String taskId) {
    return repository.deleteTask(taskId);
  }
}
