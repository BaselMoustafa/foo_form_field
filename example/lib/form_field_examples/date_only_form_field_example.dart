import 'dart:developer';

import '../widgets/controller_test_buttons.dart';
import '../widgets/example_screen.dart';
import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';

class DateOnlyFormFieldExample extends StatefulWidget {
  const DateOnlyFormFieldExample({super.key});

  @override
  State<DateOnlyFormFieldExample> createState() => _DateOnlyFormFieldExampleState();
}

class _DateOnlyFormFieldExampleState extends State<DateOnlyFormFieldExample> {
  final _controller = DateOnlyFieldController(
    initialValue: DateOnly(year: 2025, month: 1, day: 1),
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
      title: "Date Only Form Field",
      fieldBuilder: () => DateOnlyFormField(
        controller: _controller,
        decoration: InputDecoration(
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
          firstDummyValue: DateOnly(year: 2025, month: 1, day: 1),
          secondDummyValue: DateOnly(year: 2025, month: 1, day: 25),
          valueToString: (value) => "${value.year}/${value.month}/${value.day}",
        ),
      ],
    );
  }
}

