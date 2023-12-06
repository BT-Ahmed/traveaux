import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';

// A widget to display the login screen
class LoginScreen extends StatefulWidget {
  // A constructor to create a login screen widget
  LoginScreen();

  // A method to create the state of the widget
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

// A class to represent the state of the login screen widget
class _LoginScreenState extends State<LoginScreen> {
  // A global key for the form
  final _formKey = GlobalKey<FormState>();

  // A text editing controller for the email field
  final _emailController = TextEditingController();

  // A text editing controller for the password field
  final _passwordController = TextEditingController();

  // An auth service to handle the authentication logic
  AuthService _authService = AuthService();

  // A method to dispose the state
  @override
  void dispose() {
    // Dispose the controllers
    _emailController.dispose();
    _passwordController.dispose();
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
        // Set the title widget to a text widget with the app name
        title: Text('Task Manager'),
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
            // Set the main axis alignment to center
            mainAxisAlignment: MainAxisAlignment.center,
            // Add some widgets as children
            children: [
              // A text widget for the login title
              Text(
                'Login',
                // Set the style to large and bold
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              // A sized box widget for some vertical space
              SizedBox(height: 20),
              // A text form field widget for the email input
              TextFormField(
                // Set the controller to the email controller
                controller: _emailController,
                // Set the decoration
                decoration: InputDecoration(
                  // Set the border to an outline input border
                  border: OutlineInputBorder(),
                  // Set the prefix icon to an email icon
                  prefixIcon: Icon(Icons.email),
                  // Set the label text
                  labelText: 'Email',
                ),
                // Set the validator function
                validator: (value) {
                  // If the value is empty, return an error message
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  // Otherwise, return null
                  return null;
                },
              ),
              // A sized box widget for some vertical space
              SizedBox(height: 10),
              // A text form field widget for the password input
              TextFormField(
                // Set the controller to the password controller
                controller: _passwordController,
                // Set the decoration
                decoration: InputDecoration(
                  // Set the border to an outline input border
                  border: OutlineInputBorder(),
                  // Set the prefix icon to a lock icon
                  prefixIcon: Icon(Icons.lock),
                  // Set the label text
                  labelText: 'Password',
                ),
                // Set the obscure text to true
                obscureText: true,
                // Set the validator function
                validator: (value) {
                  // If the value is empty, return an error message
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  // Otherwise, return null
                  return null;
                },
              ),
              // A sized box widget for some vertical space
              SizedBox(height: 10),
              // A row widget for the login and sign up buttons
              Row(
                // Set the main axis alignment to space between
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // Add some widgets as children
                children: [
                  // An elevated button widget for the login button
                  ElevatedButton(
                    // Set the child widget to a text widget with the login text
                    child: Text('Login'),
                    // Set the on pressed function to validate and login the user
                    onPressed: () async {
                      // If the form is valid
                      if (_formKey.currentState!.validate()) {
                        // Try to login the user using the auth service
                        try {
                          // Login the user with the email and password
                          final user = await _authService.logIn(
                              _emailController.text, _passwordController.text);
                          // Navigate to the home screen with the user as an argument
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => HomeScreen(user: user)));
                        } catch (e) {
                          // If an exception occurs, show a snackbar with the error message
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(e.toString()),
                          ));
                        }
                      }
                    },
                  ),
                  // An elevated button widget for the sign up button
                  ElevatedButton(
                    // Set the child widget to a text widget with the sign up text
                    child: Text('Sign Up'),
                    // Set the on pressed function to navigate to the sign up screen
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignUpScreen()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
