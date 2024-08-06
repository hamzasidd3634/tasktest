
import 'package:tasktest/domain/entities/task.dart';

abstract class TaskRepositoryInterface {
  Future<void> addTask(Task task);
  Future<void> deleteTask(String taskId);
  Future<List<Task>> getTasks();
}
