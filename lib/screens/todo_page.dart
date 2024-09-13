import 'package:flutter/material.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key, required this.title, this.description});

  final String title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
      ),
      body: Column(
        children: [
          Text(title),
          description != null ? Text(description!) : Container(),
        ],
      ),
    );
  }
}
