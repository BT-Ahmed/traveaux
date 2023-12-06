import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

import '../models/task.dart';
import '../services/location_service.dart';

// A widget to display a task form
class TaskForm extends StatefulWidget {
  // The task to edit or null for a new task
  final Task? task;

  // A function to handle the task submission
  final Function onSubmit;

  // A constructor to create a task form widget from a task and a submit function
  TaskForm({this.task, required this.onSubmit});

  // A method to create the state of the widget
  @override
  _TaskFormState createState() => _TaskFormState();
}

// A class to represent the state of the task form widget
class _TaskFormState extends State<TaskForm> {
  // A global key for the form
  final _formKey = GlobalKey<FormState>();

  // A text editing controller for the title field
  final _titleController = TextEditingController();

  // A text editing controller for the description field
  final _descriptionController = TextEditingController();

  // A variable to store the picture file
  File? _picture;

  // A variable to store the latitude
  double? _latitude;

  // A variable to store the longitude
  double? _longitude;

  // A location service to get the current location
  LocationService _locationService = LocationService();

  // A method to initialize the state
  @override
  void initState() {
    // Call the super method
    super.initState();
    // If the task is not null, set the initial values of the controllers and variables
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _picture = File(widget.task!.picture);
      _latitude = widget.task!.latitude;
      _longitude = widget.task!.longitude;
    }
  }

  // A method to dispose the state
  @override
  void dispose() {
    // Dispose the controllers
    _titleController.dispose();
    _descriptionController.dispose();
    // Call the super method
    super.dispose();
  }

  // A method to build the widget
  @override
  Widget build(BuildContext context) {
    // Return a scaffold widget
    return Scaffold(
      // Set the app bar widget
      appBar: AppBar(
        // Set the title widget to a text widget with the task title or 'New Task'
        title: Text(widget.task?.title ?? 'New Task'),
      ),
      // Set the body widget to a form widget
      body: Form(
        // Set the key to the form key
        key: _formKey,
        // Set the child widget to a single child scroll view widget
        child: SingleChildScrollView(
          // Set the padding
          padding: EdgeInsets.all(10),
          // Set the child widget to a column widget
          child: Column(
            // Set the cross axis alignment to start
            crossAxisAlignment: CrossAxisAlignment.start,
            // Add some widgets as children
            children: [
              // A text widget for the title label
              Text(
                'Title',
                // Set the style to bold
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              // A text form field widget for the title input
              TextFormField(
                // Set the controller to the title controller
                controller: _titleController,
                // Set the decoration
                decoration: InputDecoration(
                  // Set the border to an outline input border
                  border: OutlineInputBorder(),
                  // Set the hint text
                  hintText: 'Enter the task title',
                ),
                // Set the validator function
                validator: (value) {
                  // If the value is empty, return an error message
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  // Otherwise, return null
                  return null;
                },
              ),
              // A sized box widget for some vertical space
              SizedBox(height: 10),
              // A text widget for the description label
              Text(
                'Description',
                // Set the style to bold
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              // A text form field widget for the description input
              TextFormField(
                // Set the controller to the description controller
                controller: _descriptionController,
                // Set the decoration
                decoration: InputDecoration(
                  // Set the border to an outline input border
                  border: OutlineInputBorder(),
                  // Set the hint text
                  hintText: 'Enter the task description',
                ),
                // Set the validator function
                validator: (value) {
                  // If the value is empty, return an error message
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  // Otherwise, return null
                  return null;
                },
              ),
              // A sized box widget for some vertical space
              SizedBox(height: 10),
              // A text widget for the picture label
              Text(
                'Picture',
                // Set the style to bold
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              // A row widget for the picture input
              Row(
                // Set the main axis alignment to space between
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // Add some widgets as children
                children: [
                  // A container widget for the picture preview
                  Container(
                    // Set the width and height
                    width: 100,
                    height: 100,
                    // Set the decoration
                    decoration: BoxDecoration(
                      // Set the border to a box border
                      border: Border.all(),
                      // Set the image to the picture file or a placeholder asset
                      image: DecorationImage(
                        image: _picture == null
                            ? AssetImage('assets/placeholder.png')
                            : FileImage(_picture!),
                        // Set the fit to cover
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // A column widget for the picture buttons
                  Column(
                    // Add some widgets as children
                    children: [
                      // An elevated button widget for the camera button
                      ElevatedButton(
                        // Set the child widget to a row widget with an icon and a text widget
                        child: Row(
                          // Add some widgets as children
                          children: [
                            // An icon widget for the camera icon
                            Icon(Icons.camera),
                            // A sized box widget for some horizontal space
                            SizedBox(width: 5),
                            // A text widget for the camera text
                            Text('Camera'),
                          ],
                        ),
                        // Set the on pressed function to pick an image from the camera
                        onPressed: () async {
                          // Use the image picker to pick an image from the camera
                          final image = await ImagePicker().pickImage(
                              source: ImageSource.camera,
                              maxWidth: 600,
                              maxHeight: 600);
                          // If the image is not null, set the picture file to the image file
                          if (image != null) {
                            setState(() {
                              _picture = File(image.path);
                            });
                          }
                        },
                      ),
                      // A sized box widget for some vertical space
                      SizedBox(height: 10),
                      // An elevated button widget for the gallery button
                      ElevatedButton(
                        // Set the child widget to a row widget with an icon and a text widget
                        child: Row(
                          // Add some widgets as children
                          children: [
                            // An icon widget for the gallery icon
                            Icon(Icons.photo),
                            // A sized box widget for some horizontal space
                            SizedBox(width: 5),
                            // A text widget for the gallery text
                            Text('Gallery'),
                          ],
                        ),
                        // Set the on pressed function to pick an image from the gallery
                        onPressed: () async {
                          // Use the image picker to pick an image from the gallery
                          final image = await ImagePicker().pickImage(
                              source: ImageSource.gallery,
                              maxWidth: 600,
                              maxHeight: 600);
                          // If the image is not null, set the picture file to the image file
                          if (image != null) {
                            setState(() {
                              _picture = File(image.path);
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              // A sized box widget for some vertical space
              SizedBox(height: 10),
              // A text widget for the location label
              Text(
                'Location',
                // Set the style to bold
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              // A row widget for the location input
              Row(
                // Set the main axis alignment to space between
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // Add some widgets as children
                children: [
                  // A column widget for the latitude and longitude fields
                  Column(
                    // Set the cross axis alignment to start
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // Add some widgets as children
                    children: [
                      // A text widget for the latitude label
                      Text('Latitude: ${_latitude ?? 'N/A'}'),
                      // A text widget for the longitude label
                      Text('Longitude: ${_longitude ?? 'N/A'}'),
                    ],
                  ),
                  // An elevated button widget for the location button
                  ElevatedButton(
                    // Set the child widget to a row widget with an icon and a text widget
                    child: Row(
                      // Add some widgets as children
                      children: [
                        // An icon widget for the location icon
                        Icon(Icons.location_on),
                        // A sized box widget for some horizontal space
                        SizedBox(width: 5),
                        // A text widget for the location text
                        Text('Get Location'),
                      ],
                    ),
                    // Set the on pressed function to get the current location
                    onPressed: () async {
                      // Try to get the current location using the location service
                      try {
                        // Get the current position
                        final position =
                            await _locationService.getCurrentLocation();
                        // Set the latitude and longitude variables to the position coordinates
                        setState(() {
                          _latitude = position.latitude;
                          _longitude = position.longitude;
                        });
                      } catch (e) {
                        // If an exception occurs, show a snackbar with the error message
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(e.toString()),
                        ));
                      }
                    },
                  ),
                ],
              ),
              // A sized box widget for some vertical space
              SizedBox(height: 10),
              // A center widget for the submit button
              Center(
                // Set the child widget to an elevated button widget
                child: ElevatedButton(
                  // Set the child widget to a text widget with the submit text
                  child: Text('Submit'),
                  // Set the on pressed function to validate and submit the form
                  onPressed: () {
                    // If the form is valid
                    if (_formKey.currentState!.validate()) {
                      // If the picture is null, show a snackbar with an error message
                      if (_picture == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Please select a picture'),
                        ));
                        // Return from the function
                        return;
                      }
                      // If the latitude or longitude is null, show a snackbar with an error message
                      if (_latitude == null || _longitude == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Please get your location'),
                        ));
                        // Return from the function
                        return;
                      }
                      // Otherwise, create a new task object from the form values
                      final task = Task(
                        id: widget.task?.id ??
                            DateTime.now().millisecondsSinceEpoch,
                        title: _titleController.text,
                        description: _descriptionController.text,
                        picture: _picture!.path,
                        latitude: _latitude!,
                        longitude: _longitude!,
                      );
                      // Call the submit function with the task as an argument
                      widget.onSubmit(task);
                      // Pop the current screen from the navigation stack
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
