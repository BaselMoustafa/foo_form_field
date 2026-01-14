
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';

import '../widgets/controller_test_buttons.dart';
import '../widgets/example_screen.dart';

class IntOnlyStringFormFieldExample extends StatefulWidget {
  const IntOnlyStringFormFieldExample({super.key});

  @override
  State<IntOnlyStringFormFieldExample> createState() => _IntOnlyStringFormFieldExampleState();
}

class _IntOnlyStringFormFieldExampleState extends State<IntOnlyStringFormFieldExample> {
  final _controller = StringTextEditingController(
    initialValue: "83489283",
  );

  @override
  Widget build(BuildContext context) {
    return ExampleScreen(
      title: "Int Only String Form Field",
      fieldBuilder: () => StringTextFormField.integer(
        controller: _controller,
        maxLength: 5,
        messages: StringTextFormatterErrorMessages(
          exceedsMaxLengthMessage: "عديت المسموح",
          invalidValueMessage: "رقم غير صالح",                
        ),
        properties: TextFormFieldProperties(
          onSaved: (value) => log("Saved: $value"),
          onChanged: (value) => log("Changed: $value"),
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
          title: "Int Only String Controller Test Buttons",
          controller: _controller,
          firstDummyValue: "2321",
          secondDummyValue: "948978",
          valueToString: (value) => value,
        ),
      ],
    );
  }
}