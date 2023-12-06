import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'task.dart';
import '../services/file_service.dart';

// A class to manage the tasks data
class TaskRepository {
  // A list of tasks
  List<Task> tasks = [];

  // A file service to read and write JSON files
  FileService fileService = FileService();

  // A method to load the tasks from a JSON file
  Future<void> loadTasks() async {
    // Get the directory path
    final directory = await getApplicationDocumentsDirectory();
    // Get the file path
    final file = File('${directory.path}/tasks.json');
    // Read the file content
    final content = await fileService.readFile(file);
    // Parse the content as a list of maps
    final list = content as List<dynamic>;
    // Convert each map to a task object and add it to the tasks list
    tasks = list.map((map) => Task.fromMap(map)).toList();
  }

  // A method to save the tasks to a JSON file
  Future<void> saveTasks() async {
    // Get the directory path
    final directory = await getApplicationDocumentsDirectory();
    // Get the file path
    final file = File('${directory.path}/tasks.json');
    // Convert each task object to a map and store it in a list
    final list = tasks.map((task) => task.toMap()).toList();
    // Write the list to the file
    await fileService.writeFile(file, list);
  }

  // A method to add a new task
  void addTask(Task task) {
    // Add the task to the tasks list
    tasks.add(task);
    // Save the tasks to the file
    saveTasks();
  }

  // A method to update an existing task
  void updateTask(Task task) {
    // Find the index of the task in the tasks list
    final index = tasks.indexWhere((t) => t.id == task.id);
    // Replace the task at that index with the updated task
    tasks[index] = task;
    // Save the tasks to the file
    saveTasks();
  }

  // A method to delete an existing task
  void deleteTask(Task task) {
    // Remove the task from the tasks list
    tasks.remove(task);
    // Save the tasks to the file
    saveTasks();
  }
}
