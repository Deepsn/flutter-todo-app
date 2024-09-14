import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

import '../model/todo.dart' show Todo;
import '../utils/streamed_list.dart';

class FirestoreTodoProvider {
  final todos = StreamedList<Todo>();

  Future<void> addTodo(Todo todo) {
    final todosRef = FirebaseDatabase.instance.ref("todos");
    final newTodoRef = todosRef.push();

    return newTodoRef.set(todo.toObject());
  }

  Future<void> modifyTodo(String id, Map<String, dynamic> todo) {
    final todoRef = FirebaseDatabase.instance.ref("todos/$id");

    return todoRef.update(todo);
  }

  void loadTodos() {
    final todosRef = FirebaseDatabase.instance.ref("todos");

    todosRef.onValue.listen((event) {
      Map<String, dynamic> todosSnapshot =
          jsonDecode(jsonEncode((event.snapshot.value))) as dynamic;

      final todosObjects = todosSnapshot
          .map((id, todo) {
            return MapEntry(id, Todo.fromSnapshot(id, todo));
          })
          .values
          .toList();

      todos.set(todosObjects);
    });
  }

  void dispose() {
    todos.dispose();
  }
}
