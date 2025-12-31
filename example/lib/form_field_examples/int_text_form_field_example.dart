import 'dart:developer';

import 'package:flutter/material.dart';

import '../widgets/controller_test_buttons.dart';
import '../widgets/example_screen.dart';
import 'package:foo_form_field/foo_form_field.dart';

class IntTextFormFormFieldExample extends StatefulWidget {
  const IntTextFormFormFieldExample({super.key});

  @override
  State<IntTextFormFormFieldExample> createState() => _IntTextFormFormFieldExampleState();
}

class _IntTextFormFormFieldExampleState extends State<IntTextFormFormFieldExample> {
  final _controller = IntTextEditingController(
    initialValue: 160,
    enabled: false,
  );

  @override
  Widget build(BuildContext context) {
    return ExampleScreen(
      title: "Int Text Form Field",
      fieldBuilder: () => IntTextFormField(
        controller: _controller,
        properties: TextFormFieldProperties(
          onSaved: (value) => log("Int Text Saved: $value"),
          onChanged: (value) => log("Int Text Changed: $value"),
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