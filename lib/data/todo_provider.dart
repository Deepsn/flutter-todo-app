import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

import '../model/todo.dart' show Todo;
import '../utils/streamed_list.dart';

class FirestoreTodoProvider {
  final todos = StreamedList<Todo>();

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
    final todosRef = FirebaseDatabase.instance.ref("todos");

    todosRef.onChildAdded.listen((event) {
      todos.addToList(Todo.fromSnapshot(event.snapshot));
    });
  }

  void dispose() {
    todos.dispose();
  }
}
