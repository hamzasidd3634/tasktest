
import 'package:tasktest/domain/entities/task.dart';

class TaskModel extends Task {
  TaskModel({required super.id, required super.title});

  factory TaskModel.fromTask(Task task) {
    return TaskModel(id: task.id, title: task.title);
  }

  Task toTask() {
    return Task(id: id, title: title);
  }
}
