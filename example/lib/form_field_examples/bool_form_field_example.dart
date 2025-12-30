import 'dart:developer';

import '../widgets/example_screen.dart';
import '../widgets/controller_test_buttons.dart';
import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';

class BoolFormFieldExample extends StatefulWidget {
  const BoolFormFieldExample({
    super.key,
  });

  @override
  State<BoolFormFieldExample> createState() => _BoolFormFieldExampleState();
}

class _BoolFormFieldExampleState extends State<BoolFormFieldExample> {
  final _controller = BoolFieldController(
    initialValue: false,
    enabled: false,
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
      title: "Bool Form Field",
      fieldBuilder: () => BooleanFormField(
        controller: _controller,
        properties: FooFormFieldProperties(
          onChanged: (value) => log("Bool Changed To: $value"),
          onSaved: (value) => log("Bool Saved: $value"),
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