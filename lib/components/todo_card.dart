import 'package:flutter/material.dart';
import '../data/todo_provider.dart';
import '../model/todo.dart';
import '../screens/todo_page.dart';

class TodoCard extends StatefulWidget {
  const TodoCard(
      {super.key, required this.todo, required this.title, this.description});

  // final String id;
  final Todo todo;
  final String title;
  final String? description;

  @override
  State<StatefulWidget> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  bool isChecked = false;
  final todoProvider = FirestoreTodoProvider();

  @override
  void initState() {
    setState(() {
      isChecked = widget.todo.completed;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TodoPage(
                      title: widget.todo.name,
                      description: widget.todo.description)));
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    final newValue = value ?? false;

                    todoProvider
                        .modifyTodo(widget.todo.id, {"completed": newValue});

                    setState(() {
                      isChecked = newValue;
                    });
                  }),
              title: Text(widget.title),
              subtitle:
                  widget.description != null ? Text(widget.description!) : null,
            ),
          ],
        ),
      ),
    );
  }
}
