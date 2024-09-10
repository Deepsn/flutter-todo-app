import 'package:flutter/material.dart';

String parseDate(DateTime date) {
  var [year, month, day] = date.toString().split(" ")[0].split("-");
  return "$day/$month/$year";
}

class DatePicker extends StatefulWidget {
  DatePicker({super.key});

  @override
  State<StatefulWidget> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  TextEditingController _datePickerController =
      TextEditingController(text: parseDate(DateTime.now()));

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: _datePickerController,
        decoration: InputDecoration(
            labelText: "Date",
            prefixIcon: Icon(Icons.date_range_rounded),
            filled: false,
            border: OutlineInputBorder()),
        readOnly: true,
        onTap: () => _showDatePicker(),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please choose a date";
          }
          return null;
        });
  }

  Future<void> _showDatePicker() async {
    DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));

    if (picked != null) {
      _datePickerController.text = parseDate(picked);
    }
  }
}
