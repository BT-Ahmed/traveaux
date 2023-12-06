import 'package:flutter/material.dart';

import 'screens/login_screen.dart';

// A widget to display the app
class App extends StatelessWidget {
  // A constructor to create an app widget
  App();

  // A method to build the widget
  @override
  Widget build(BuildContext context) {
    // Return a material app widget
    return MaterialApp(
      // Set the title to the app name
      title: 'Task Manager',
      // Set the theme to a light theme
      theme: ThemeData.light(),
      // Set the home to the login screen widget
      home: LoginScreen(),
    );
  }
}
