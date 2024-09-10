import 'package:flutter/material.dart';

class Todo extends StatelessWidget {
  const Todo({super.key, required this.title});

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
