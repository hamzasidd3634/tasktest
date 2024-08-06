import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tasktest/domain/entities/task.dart';
import 'package:tasktest/domain/repositories/task_repository_interface.dart';
import 'package:tasktest/domain/usecases/add_task.dart';

@GenerateMocks([TaskRepositoryInterface])
import 'add_task_test.mocks.dart';

void main() {
  late AddTask useCase;
  late MockTaskRepositoryInterface mockTaskRepository;

  setUp(() {
    mockTaskRepository = MockTaskRepositoryInterface();
    useCase = AddTask(mockTaskRepository);
  });

  final task = Task(id: '1', title: 'Test Task');

  test('should add task to the repository', () async {
    await useCase(task);
    verify(mockTaskRepository.addTask(task)).called(1);
  });
}
