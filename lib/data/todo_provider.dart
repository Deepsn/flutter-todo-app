import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

import '../model/todo.dart';

class FirestoreTodoProvider {
  StreamController<List<Todo>> _streamController = StreamController();
  late Stream<List<Todo>> todos;

  FirestoreTodoProvider() {
    todos = _streamController.stream;
  }

  Future<void> addTodo(Todo todo) {
    final todosRef = FirebaseDatabase.instance.ref("todos");
    final newTodoRef = todosRef.push();

    return newTodoRef.set({
      "name": todo.name,
      "completed": todo.completed,
      "dueDate": todo.dueDate.millisecondsSinceEpoch,
      "description": todo.description
    });
  }

  void loadTodos() {
    
  }

  void dispose() {
    _streamController.close();
  }
}
