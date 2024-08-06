import 'dart:collection';
import 'package:tasktest/data/model/task_model.dart';
import 'package:tasktest/domain/entities/task.dart';
import 'package:tasktest/domain/repositories/task_repository_interface.dart';


class TaskRepository implements TaskRepositoryInterface {
  final List<TaskModel> _tasks = [];

  @override
  Future<void> addTask(Task task) async {
    _tasks.add(TaskModel.fromTask(task));
  }

  @override
  Future<void> deleteTask(String taskId) async {
    _tasks.removeWhere((task) => task.id == taskId);
  }

  @override
  Future<List<Task>> getTasks() async {
    return UnmodifiableListView(_tasks.map((taskModel) => taskModel.toTask()));
  }
}
