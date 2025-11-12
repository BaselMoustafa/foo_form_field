import 'dart:developer';

import '../widgets/controller_test_buttons.dart';
import '../widgets/example_screen.dart';
import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';

class DateFormFieldExampleScreen extends StatefulWidget {
  const DateFormFieldExampleScreen({super.key});

  @override
  State<DateFormFieldExampleScreen> createState() => _DateFormFieldExampleScreenState();
}

class _DateFormFieldExampleScreenState extends State<DateFormFieldExampleScreen> {
  final _controller = DateFieldController(
    initialValue: DateTime(2025, 1, 1),
    enabled: false,
  );

  @override
  Widget build(BuildContext context) {
    return ExampleScreen(
      title: "Date Form Field",
      fieldBuilder: () => DateFormField(
        controller: _controller,
        onChanged: (value) => log("Date Changed To: $value"),
        onSaved: (value) => log("Date Saved: $value"),
        validator: (value) {
          if (value == null) {
            return 'This field is required';
          }
          return null;
        },
      ),
      children: [
        ControllerTestButtons(
          title: "Date Controller Test Buttons",
          controller: _controller,
          firstDummyValue: DateTime(2025, 1, 1),
          secondDummyValue: DateTime(2025, 1, 25),
          valueToString: (value) => "${value.year}/${value.month}/${value.day}",
        ),
      ],
    );
  }
}