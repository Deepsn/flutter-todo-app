import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_todo_app/screens/loading_page.dart';
import 'package:flutter_todo_app/screens/todos_page.dart';

import 'firebase_options.dart';

void main() async {
  await dotenv.load();
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text(
                "Failed to load the application. Please reopen the app.");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return TodosPage();
          }

          return LoadingPage();
        });
  }
}
