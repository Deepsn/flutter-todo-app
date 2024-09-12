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
}
