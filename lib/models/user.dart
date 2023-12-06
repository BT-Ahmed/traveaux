import 'dart:convert';

// A class to represent a user
class User {
  // The email of the user
  final String email;

  // The password of the user
  final String password;

  // The name of the user
  final String name;

  // A constructor to create a user object from email, password and name
  User({
    required this.email,
    required this.password,
    required this.name,
  });

  // A method to convert a user object to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'name': name,
    };
  }

  // A method to convert a JSON map to a user object
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'],
      password: map['password'],
      name: map['name'],
    );
  }

  // A method to convert a user object to a JSON string
  String toJson() => json.encode(toMap());

  // A method to convert a JSON string to a user object
  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}