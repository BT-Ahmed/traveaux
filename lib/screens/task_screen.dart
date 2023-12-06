import 'package:flutter/material.dart';

import '../models/task.dart';
import '../models/task_repository.dart';
import '../widgets/task_form.dart';

// A widget to display the task screen
class TaskScreen extends StatelessWidget {
  // The task to edit or null for a new task
  final Task? task;

  // A task repository to manage the tasks data
  TaskRepository _taskRepository = TaskRepository();

  // A constructor to create a task screen widget from a task
  TaskScreen({this.task});

  // A method to build the widget
  @override
  Widget build(BuildContext context) {
    // Return a task form widget with the task and a submit function
    return TaskForm(
      task: task,
      onSubmit: (task) {
        // If the task id is null, add a new task
        if (task.id == null) {
          _taskRepository.addTask(task);
        } else {
          // Otherwise, update an existing task
          _taskRepository.updateTask(task);
        }
      },
    );
  }
}
