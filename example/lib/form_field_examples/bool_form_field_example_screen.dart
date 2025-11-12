import 'dart:developer';

import '../widgets/example_screen.dart';
import '../widgets/controller_test_buttons.dart';
import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';

class BoolFormFieldExampleScreen extends StatefulWidget {
  const BoolFormFieldExampleScreen({
    super.key,
  });

  @override
  State<BoolFormFieldExampleScreen> createState() => _BoolFormFieldExampleScreenState();
}

class _BoolFormFieldExampleScreenState extends State<BoolFormFieldExampleScreen> {
  final _controller = BooleanFieldController(
    initialValue: false,
    enabled: false,
  );

  @override
  Widget build(BuildContext context) {
    return ExampleScreen(
      title: "Bool Form Field",
      children: [
        BooleanFormField(
          controller: _controller,
          onChanged: (value) => log("Bool Changed To: $value"),
          onSaved: (value) => log("Bool Saved: $value"),
          validator: (value) {
            if (value == null) {
              return 'This field is required';
            }
            return null;
          },
        ),
        ControllerTestButtons(
          title: "Bool Controller Test Buttons",
          controller: _controller,
          firstDummyValue: false,
          secondDummyValue: true,
          valueToString: (value) => value.toString(),
        ),
      ],
    );
  }
}