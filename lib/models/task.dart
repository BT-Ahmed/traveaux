import 'dart:convert';

// A class to represent a task
class Task {
  // The id of the task
  final int id;

  // The title of the task
  final String title;

  // The description of the task
  final String description;

  // The picture of the task
  final String picture;

  // The latitude of the task location
  final double latitude;

  // The longitude of the task location
  final double longitude;

  // A constructor to create a task object from id, title, description, picture, latitude and longitude
  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.picture,
    required this.latitude,
    required this.longitude,
  });

  // A method to convert a task object to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'picture': picture,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  // A method to convert a JSON map to a task object
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      picture: map['picture'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  // A method to convert a task object to a JSON string
  String toJson() => json.encode(toMap());

  // A method to convert a JSON string to a task object
  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));
}