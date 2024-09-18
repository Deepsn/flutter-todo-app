import 'package:flutter/material.dart';
import '../data/todo_provider.dart';
import '../model/todo.dart';
import '../screens/todo_page.dart';
import 'confirm_modal.dart';

class TodoCard extends StatefulWidget {
  const TodoCard(
      {super.key, required this.todo, required this.title, this.description});

  final Todo todo;
  final String title;
  final String? description;

  @override
  State<StatefulWidget> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  final todoProvider = FirestoreTodoProvider();

  bool isChecked = false;
  bool isHovered = false;

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
      key: widget.key,
      child: InkWell(
        onHover: (hovered) {
          setState(() {
            isHovered = hovered;
          });
        },
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TodoPage(
                      title: widget.todo.name,
                      description: widget.todo.description)));
        },
        child: ListTile(
          trailing: isHovered
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      tooltip: "Delete",
                      icon: const Icon(Icons.delete_forever),
                      onPressed: () async {
                        bool accepted = await showConfirmDialog(
                            context, "Confirm delete",
                            accept: "Delete", decline: "Cancel");

                        if (!accepted) return;
                        todoProvider.deleteTodo(widget.todo.id);
                      },
                    )
                  ],
                )
              : null,
          title: Column(
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
                subtitle: widget.description != null
                    ? Text(widget.description!)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
