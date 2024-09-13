import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

class Todo {
  final String name;
  final bool completed;
  final DateTime dueDate;

  final String? description;

  Todo(
      {required this.name,
      required this.completed,
      required this.dueDate,
      this.description});

  factory Todo.fromSnapshot(DataSnapshot snapshot) {
    Map<String, dynamic> value = jsonDecode(jsonEncode(snapshot.value));

    return Todo(
      name: value["name"],
      dueDate: DateTime.fromMillisecondsSinceEpoch(value["dueDate"]),
      description: value["description"],
      completed: value["completed"],
    );
  }
}
