import 'package:flutter/material.dart';

import '../models/task.dart';
import 'task_form.dart';

// A widget to display a task card
class TaskCard extends StatelessWidget {
  // The task to display
  final Task task;

  // A function to handle the task deletion
  final Function onDelete;

  // A constructor to create a task card widget from a task and a delete function
  TaskCard({required this.task, required this.onDelete});

  // A method to build the widget
  @override
  Widget build(BuildContext context) {
    // Return a card widget
    return Card(
      // Add some margin and elevation
      margin: EdgeInsets.all(10),
      elevation: 5,
      // Add a list tile widget as the child
      child: ListTile(
        // Set the leading widget to a circle avatar with the task picture
        leading: CircleAvatar(
          backgroundImage: FileImage(File(task.picture)),
        ),
        // Set the title widget to a text widget with the task title
        title: Text(task.title),
        // Set the subtitle widget to a text widget with the task description
        subtitle: Text(task.description),
        // Set the trailing widget to a row widget with two icon buttons
        trailing: Row(
          // Set the main axis size to minimum
          mainAxisSize: MainAxisSize.min,
          // Add two icon buttons as children
          children: [
            // The first icon button is for editing the task
            IconButton(
              // Set the icon to a edit icon
              icon: Icon(Icons.edit),
              // Set the color to blue
              color: Colors.blue,
              // Set the on pressed function to navigate to the task screen with the task as an argument
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TaskScreen(task: task)));
              },
            ),
            // The second icon button is for deleting the task
            IconButton(
              // Set the icon to a delete icon
              icon: Icon(Icons.delete),
              // Set the color to red
              color: Colors.red,
              // Set the on pressed function to call the delete function with the task as an argument
              onPressed: () {
                onDelete(task);
              },
            ),
          ],
        ),
      ),
    );
  }
}
