import 'package:flutter/material.dart';
import 'package:flutter_todo_app/components/date_picker.dart';

class TodoCreate extends StatefulWidget {
  TodoCreate({super.key});

  @override
  State<StatefulWidget> createState() => _TodoCreateState();
}

class _TodoCreateState extends State<TodoCreate> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Create a todo"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 300, child: Container()),
            TextFormField(
                autocorrect: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: const Text("Name")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please provide a name for the todo";
                  }
                  return null;
                }),
            SizedBox(
              height: 15,
            ),
            TextFormField(
                autocorrect: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: const Text("Description")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please provide a description for the todo";
                  }
                  return null;
                }),
            SizedBox(
              height: 15,
            ),
            // Container(child: SfDateRangePicker())
            DatePicker()
          ],
        ),
      ),
      contentPadding: EdgeInsets.all(20).subtract(EdgeInsets.only(bottom: 10)),
      actionsPadding: EdgeInsets.only(bottom: 10),
      actions: [
        Center(
            child: TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text("Create")))
      ],
    );
  }
}
