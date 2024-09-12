import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import '../data/todo_provider.dart';
import '../model/todo.dart';

class TodoCreate extends StatefulWidget {
  TodoCreate({super.key});

  @override
  State<StatefulWidget> createState() => _TodoCreateState();
}

class _TodoCreateState extends State<TodoCreate> {
  final _formKey = GlobalKey<FormBuilderState>();
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

    outlinedBorder(String label) =>
        InputDecoration(border: OutlineInputBorder(), label: Text(label));

    return AlertDialog(
      title: const Text("Create a todo"),
      content: FormBuilder(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormBuilderTextField(
                  name: "name",
                  validator: FormBuilderValidators.required(
                      errorText: "Please provide a name for the todo"),
                  decoration: outlinedBorder("Name")),
              const SizedBox(height: 10),
              FormBuilderTextField(
                  name: "description",
                  decoration: outlinedBorder("Description")),
              const SizedBox(height: 10),
              FormBuilderDateTimePicker(
                name: "dueDate",
                inputType: InputType.date,
                format: DateFormat("dd-MM-yyyy"),
                decoration: outlinedBorder("Date"),
              )
            ],
          )),
      contentPadding: EdgeInsets.all(20).subtract(EdgeInsets.only(bottom: 10)),
      actionsPadding: EdgeInsets.only(bottom: 10),
      actions: [
        Center(
            child: TextButton(
                onPressed: () {
                  final state = _formKey.currentState;
                  if (state == null) return;

                  state.saveAndValidate();
                  if (!state.isValid) return;

                  todoProvider.addTodo(Todo(
                    completed: false,
                    name: state.value["name"],
                    dueDate: state.value["dueDate"],
                    description: state.value["description"],
                  ));
                },
                child: const Text("Create")))
      ],
    );
  }
}
