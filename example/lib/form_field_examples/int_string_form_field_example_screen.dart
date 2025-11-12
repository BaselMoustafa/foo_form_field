import 'dart:developer';

import 'package:flutter/material.dart';

import '../widgets/controller_test_buttons.dart';
import '../widgets/example_screen.dart';
import 'package:foo_form_field/foo_form_field.dart';

class IntStringFormFieldExampleScreen extends StatefulWidget {
  const IntStringFormFieldExampleScreen({super.key});

  @override
  State<IntStringFormFieldExampleScreen> createState() => _IntStringFormFieldExampleScreenState();
}

class _IntStringFormFieldExampleScreenState extends State<IntStringFormFieldExampleScreen> {
  final _controller = IntStringFieldController(
    initialValue: 160,
    enabled: false,
  );

  @override
  Widget build(BuildContext context) {
    return ExampleScreen(
      title: "Int String Form Field",
      fieldBuilder: () => IntStringFormField(
        controller: _controller,
        properties: TextFormFieldProperties(
          onSaved: (value) => log("Int String Saved: $value"),
          onChanged: (value) => log("Int String Changed: $value"),
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
          title: "Int String Controller Test Buttons",
          controller: _controller,
          firstDummyValue: 160,
          secondDummyValue: 170,
          valueToString: (value) => value.toString(),
        ),
      ],
    );
  }
}