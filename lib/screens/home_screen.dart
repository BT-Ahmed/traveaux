import 'package:flutter/material.dart';

import '../models/user.dart';
import '../models/task.dart';
import '../models/task_repository.dart';
import 'task_screen.dart';
import '../widgets/task_list.dart';

// A widget to display the home screen
class HomeScreen extends StatefulWidget {
  // The user to display
  final User user;

  // A constructor to create a home screen widget from a user
  HomeScreen({required this.user});

  // A method to create the state of the widget
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// A class to represent the state of the home screen widget
class _HomeScreenState extends State<HomeScreen> {
  // A task repository to manage the tasks data
  TaskRepository _taskRepository = TaskRepository();

  // A method to build the widget
  @override
  Widget build(BuildContext context) {
    // Return a scaffold widget
    return Scaffold(
      // Set the app bar widget
      appBar: AppBar(
        // Set the title widget to a text widget with the user name
        title: Text('Welcome, ${widget.user.name}'),
        // Set the actions widget to a list of widgets
        actions: [
          // An icon button widget for the logout button
          IconButton(
            // Set the icon to a logout icon
            icon: Icon(Icons.logout),
            // Set the on pressed function to pop the current screen from the navigation stack
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      // Set the body widget to a task list widget
      body: TaskList(),
      // Set the floating action button widget to a floating action button widget
      floatingActionButton: FloatingActionButton(
        // Set the child widget to a plus icon
        child: Icon(Icons.add),
        // Set the on pressed function to navigate to the task screen with no arguments
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TaskScreen(
                task: null,
              )));
        },
      ),
    );
  }
}
