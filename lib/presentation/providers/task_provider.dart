import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasktest/data/repositories/task_repository.dart';
import 'package:tasktest/domain/entities/task.dart';
import 'package:tasktest/domain/repositories/task_repository_interface.dart';
import 'package:tasktest/domain/usecases/add_task.dart';
import 'package:tasktest/domain/usecases/delete_task.dart';
import 'package:tasktest/domain/usecases/get_tasks.dart';


final taskRepositoryProvider = Provider<TaskRepositoryInterface>((ref) {
  return TaskRepository();
});

final taskListProvider = StateNotifierProvider<TaskListNotifier, List<Task>>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return TaskListNotifier(
    getTasks: GetTasks(repository),
    addTask: AddTask(repository),
    deleteTask: DeleteTask(repository),
  );
});

class TaskListNotifier extends StateNotifier<List<Task>> {
  final GetTasks getTasks;
  final AddTask addTask;
  final DeleteTask deleteTask;

  TaskListNotifier({
    required this.getTasks,
    required this.addTask,
    required this.deleteTask,
  }) : super([]) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    state = await getTasks();
  }

  Future<void> addNewTask(Task task) async {
    // await addTask(task);
    state = [...state,task];
    // final ids = <dynamic>{};
    // state.retainWhere((x) => ids.add(x.id));
    // print(state);
  }

  Future<void> removeTask(String taskId) async {
    await deleteTask(taskId);
    state = state.where((task) => task.id != taskId).toList();
  }
}
