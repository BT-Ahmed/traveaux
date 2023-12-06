import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../models/user.dart';
import 'file_service.dart';

// A class to handle the authentication logic
class AuthService {
  // A file service to read and write JSON files
  FileService fileService = FileService();

  // A method to sign up a new user
  Future<void> signUp(User user) async {
    // Get the directory path
    final directory = await getApplicationDocumentsDirectory();
    // Get the file path
    final file = File('${directory.path}/users.json');
    // Read the file content
    final content = await fileService.readFile(file);
    // Parse the content as a list of maps
    final list = content as List<dynamic>;
    // Check if the user email already exists in the list
    final exists = list.any((map) => map['email'] == user.email);
    // If the email exists, throw an exception
    if (exists) {
      throw Exception('The email is already taken.');
    }
    // Otherwise, add the user to the list
    list.add(user.toMap());
    // Write the list to the file
    await fileService.writeFile(file, list);
  }

  // A method to log in an existing user
  Future<User> logIn(String email, String password) async {
    // Get the directory path
    final directory = await getApplicationDocumentsDirectory();
    // Get the file path
    final file = File('${directory.path}/users.json');
    // Read the file content
    final content = await fileService.readFile(file);
    // Parse the content as a list of maps
    final list = content as List<dynamic>;
    // Find the user with the matching email and password in the list
    final user = list.firstWhere(
            (map) => map['email'] == email && map['password'] == password,
        orElse: () => null);
    // If the user is not found, throw an exception
    if (user == null) {
      throw Exception('Invalid email or password.');
    }
    // Otherwise, return the user object
    return User.fromMap(user);
  }
}
