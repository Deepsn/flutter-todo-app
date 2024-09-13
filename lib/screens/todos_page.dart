import 'package:flutter/material.dart';

import '../components/todo_card.dart';
import '../components/todo_create.dart';
import '../data/todo_provider.dart';
import '../model/todo.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todo app",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 238, 75, 64)),
        useMaterial3: true,
      ),
      home: const TodosContainer(title: "Todo app"),
    );
  }
}

class TodosContainer extends StatefulWidget {
  const TodosContainer({super.key, required this.title});

  final String title;

  @override
  State<TodosContainer> createState() => _TodosContainerState();
}

class _TodosContainerState extends State<TodosContainer> {
  final todoProvider = FirestoreTodoProvider();

  @override
  void initState() {
    todoProvider.loadTodos();
    super.initState();
  }

  @override
  void dispose() {
    todoProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: todoProvider.todos.stream,
        builder: (context, snapshot) {
          final data = snapshot.data as List<Todo>?;

          if (data != null) {
            print("snapshot");
            print(data.length);
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(widget.title),
            ),
            body: snapshot.connectionState != ConnectionState.active ||
                    data == null
                ? const RefreshProgressIndicator()
                : ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final todo = data[index];

                      return ListTile(
                          title: TodoCard(
                              title: todo.name, description: todo.description));
                    },
                  ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _todoCreateDialogBuilder(context),
              tooltip: "Create todo",
              child: const Icon(Icons.add),
            ),
          );
        });
  }

  Future<void> _todoCreateDialogBuilder(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return TodoCreate();
        });
  }
}
