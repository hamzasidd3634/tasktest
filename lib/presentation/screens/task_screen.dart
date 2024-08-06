import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasktest/domain/entities/task.dart';
import 'package:tasktest/presentation/providers/task_provider.dart';


class TaskScreen extends ConsumerWidget {
  final TextEditingController _taskController = TextEditingController();

  TaskScreen({super.key});



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskList = ref.watch(taskListProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Task Manager')),
      body: taskList.isEmpty
          ? Center(child: Text('No tasks available'))
          : ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) {
          final task = taskList[index];
          return ListTile(
            title: Text(task.title),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                ref.read(taskListProvider.notifier).removeTask(task.id);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context,ref);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Task'),
        content: TextField(
          controller: _taskController,
          decoration: InputDecoration(hintText: 'Enter task title'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if(_taskController.text.isNotEmpty){
                final newTask = Task(
                  id: DateTime.now().toString(),
                  title: _taskController.text,
                );
                ref.read(taskListProvider.notifier).addNewTask(newTask);
                Navigator.of(context).pop();
                _taskController.clear();
              }else{
                BotToast.showText(text: "Please enter text");
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}
