import 'dart:developer';

import 'package:flutter/material.dart';

import '../widgets/controller_test_buttons.dart';
import '../widgets/example_screen.dart';
import 'package:foo_form_field/foo_form_field.dart';

class NumTextFormFormFieldExample extends StatefulWidget {
  const NumTextFormFormFieldExample({super.key});

  @override
  State<NumTextFormFormFieldExample> createState() => _NumTextFormFormFieldExampleState();
}

class _NumTextFormFormFieldExampleState extends State<NumTextFormFormFieldExample> {
  final _controller = NumTextEditingController(
    initialValue: 160.5,
    enabled: false,
  );

  @override
  Widget build(BuildContext context) {
    return ExampleScreen(
      title: "Num Text Form Field",
      fieldBuilder: () => NumTextFormField(
        controller: _controller,
        properties: TextFormFieldProperties(
          onSaved: (value) => log("Num Text Saved: $value"),
          onChanged: (value) => log("Num Text Changed: $value"),
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
          title: "Num String Controller Test Buttons",
          controller: _controller,
          firstDummyValue: 160.5,
          secondDummyValue: 170.75,
          valueToString: (value) => value.toString(),
        ),
      ],
    );
  }
}
