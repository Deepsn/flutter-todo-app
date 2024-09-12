import 'package:flutter/material.dart';
import '../screens/todo.dart';

class TodoCard extends StatefulWidget {
  const TodoCard({super.key, required this.title, this.description});

  final String title;
  final String? description;

  @override
  State<StatefulWidget> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TodoPage(
                        title: widget.title,
                      )));
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value ?? false;
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
