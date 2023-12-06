import 'package:flutter/material.dart';

import '../models/task.dart';
import '../models/task_repository.dart';
import 'task_card.dart';

// A widget to display a task list
class TaskList extends StatefulWidget {
  // A constructor to create a task list widget
  TaskList();

  // A method to create the state of the widget
  @override
  _TaskListState createState() => _TaskListState();
}

// A class to represent the state of the task list widget
class _TaskListState extends State<TaskList> {
  // A task repository to manage the tasks data
  TaskRepository _taskRepository = TaskRepository();

  // A method to initialize the state
  @override
  void initState() {
    // Call the super method
    super.initState();
    // Load the tasks from the file
    _taskRepository.loadTasks();
  }

  // A method to build the widget
  @override
  Widget build(BuildContext context) {
    // Return a future builder widget
    return FutureBuilder(
      // Set the future to the load tasks method
      future: _taskRepository.loadTasks(),
      // Set the builder function
      builder: (context, snapshot) {
        // If the snapshot has data
        if (snapshot.hasData) {
          // Return a list view builder widget
          return ListView.builder(
            // Set the item count to the length of the tasks list
            itemCount: _taskRepository.tasks.length,
            // Set the item builder function
            itemBuilder: (context, index) {
              // Get the task at the index
              final task = _taskRepository.tasks[index];
              // Return a task card widget with the task and a delete function
              return TaskCard(
                task: task,
                onDelete: (task) {
                  // Delete the task from the repository
                  _taskRepository.deleteTask(task);
                  // Set the state
                  setState(() {});
                },
              );
            },
          );
        }
        // Otherwise, return a circular progress indicator widget
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
