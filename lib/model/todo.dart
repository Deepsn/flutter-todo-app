class Todo {
  final String id;
  final String name;
  final bool completed;
  final DateTime dueDate;

  final String? description;

  Todo(
      {required this.id,
      required this.name,
      required this.completed,
      required this.dueDate,
      this.description});

  factory Todo.fromSnapshot(String id, Map<String, dynamic> todo) {
    return Todo(
      id: id,
      name: todo["name"],
      dueDate: DateTime.fromMillisecondsSinceEpoch(todo["dueDate"]),
      description: todo["description"],
      completed: todo["completed"],
    );
  }

  Object toObject() {
    return {
      "name": name,
      "completed": completed,
      "dueDate": dueDate.millisecondsSinceEpoch,
      "description": description
    };
  }
}
