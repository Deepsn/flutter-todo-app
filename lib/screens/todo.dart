import 'package:flutter/material.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
      ),
      body: Wrap(
        children: [
          Text(title),
          Text("Todo description"),
        ],
      ),
    );
  }
}
