import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tasktest/data/repositories/task_repository.dart';
import 'package:tasktest/domain/entities/task.dart';
import 'package:tasktest/presentation/providers/task_provider.dart';

@GenerateMocks([TaskRepository])
import 'task_provider_test.mocks.dart';

void main() {
  late ProviderContainer container;
  late MockTaskRepository mockTaskRepository;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    container = ProviderContainer(overrides: [
      taskRepositoryProvider.overrideWithValue(mockTaskRepository),
    ]);
  });

  tearDown(() {
    container.dispose();
  });

  test('taskListProvider should return a list of tasks', () async {
    final tasks = [Task(id: '1', title: 'Test Task')];
    when(mockTaskRepository.getTasks()).thenAnswer((_) async => tasks);

    final taskList = container.read(taskListProvider.notifier);
    await taskList.loadTasks();

    expect(container.read(taskListProvider), tasks);
  });

  test('should add task to the list', () async {
    final task = Task(id: '1', title: 'New Task');
    when(mockTaskRepository.getTasks()).thenAnswer((_) async => [task]);
    when(mockTaskRepository.addTask(task)).thenAnswer((_) async {});

    final taskListNotifier = container.read(taskListProvider.notifier);
    await taskListNotifier.addNewTask(task);

    expect(container.read(taskListProvider), [task]);
  });


  test('should remove task from the list', () async {
    final task = Task(id: '1', title: 'New Task');
    final tasks = [task];
    when(mockTaskRepository.getTasks()).thenAnswer((_) async => tasks);
    when(mockTaskRepository.deleteTask(task.id)).thenAnswer((_) async {});

    final taskList = container.read(taskListProvider.notifier);
    await taskList.loadTasks();
    await taskList.removeTask(task.id);

    expect(container.read(taskListProvider), []);
  });
}
