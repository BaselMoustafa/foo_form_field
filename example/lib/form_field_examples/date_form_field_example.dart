import 'dart:developer';

import '../widgets/controller_test_buttons.dart';
import '../widgets/example_screen.dart';
import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';

class DateFormFieldExample extends StatefulWidget {
  const DateFormFieldExample({super.key});

  @override
  State<DateFormFieldExample> createState() => _DateFormFieldExampleState();
}

class _DateFormFieldExampleState extends State<DateFormFieldExample> {
  final _controller = DateTimeFieldController(
    initialValue: DateTime(2025, 1, 1),
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener((){
      log("Listener Called: ${_controller.value}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExampleScreen(
      title: "Date Form Field",
      fieldBuilder: () => DateTimeFormField(
        controller: _controller,
        decorationBuilder: (fieldState) => InputDecoration(
          label: Text("Date"),
        ),
        properties: FooFormFieldProperties(
          onChanged: (value) => log("Date Changed To: $value"),
          onSaved: (value) => log("Date Saved: $value"),
          validator: (value) {
            if (value == null) {
              return 'This field is required';
            }
            return null;
          },
        ),
      ),
      children: [
        ControllerTestButtons(
          title: "Date Controller Test Buttons",
          controller: _controller,
          firstDummyValue: DateTime(2025, 1, 1),
          secondDummyValue: DateTime(2025, 1, 25),
          valueToString: (value) => "${value.year}/${value.month}/${value.day}",
        ),
        DateTimeFormField(
          controller: _controller,
          decorationBuilder: (fieldState) => InputDecoration(
            label: Text("Copeird Date Form Field"),
          ),
          builder: (context, controlledFieldState) => Text(controlledFieldState.value.toString()),
        ),
      ],
    );
  }
}