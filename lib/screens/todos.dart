import 'package:flutter/material.dart';

import '../components/todo_card.dart';
import '../components/todo_create.dart';

class Todos extends StatelessWidget {
  const Todos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todo app",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 238, 75, 64)),
        useMaterial3: true,
      ),
      home: const TodoScreen(title: "Todo app"),
    );
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key, required this.title});

  final String title;

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          TodoCard(
            title: "Testing card",
            description: "Testing description",
          ),
          TodoCard(title: "gaming")
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _todoCreateDialogBuilder(context),
        tooltip: "Create todo",
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _todoCreateDialogBuilder(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return TodoCreate();
        });
  }
}
