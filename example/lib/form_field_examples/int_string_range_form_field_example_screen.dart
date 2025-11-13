import 'dart:developer';

import '../widgets/controller_test_buttons.dart';
import '../widgets/example_screen.dart';
import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';

class IntStringRangeFormFieldExampleScreen extends StatefulWidget {
  const IntStringRangeFormFieldExampleScreen({super.key});

  @override
  State<IntStringRangeFormFieldExampleScreen> createState() => _IntStringRangeFormFieldExampleScreenState();
}

class _IntStringRangeFormFieldExampleScreenState extends State<IntStringRangeFormFieldExampleScreen> {

  final _controller = IntStringRangeFieldController(
    initialValue: IntRange(min: 0, max: 100),
    enabled: false,
  );
  
  @override
  Widget build(BuildContext context) {
    return ExampleScreen(
      title: "Int String Range Form Field",
      fieldBuilder: ()=>IntStringRangeFormField(
          controller: _controller,
          onChanged: (value) => log("Range Changed To: $value"),
          onSaved: (value) => log("Range Saved: $value"),
          rangeValidator: IntRangeValidator(),
          validator: (value) {
            if (value == null || value.min == null || value.max == null) {
              return 'This field is required';
            }
            return null;
          },
          minFieldBuilder: (context,initialValue) => IntStringFormField(
            controller: _controller.minValueController,
            properties: TextFormFieldProperties(
              validator: (value) {
                if (value == null) {
                  return 'Min Required';
                }
                return null;
              },
              onSaved: (value) => log("Min Saved: $value"),
              onChanged: (value) => log("Min Changed: $value"),
            ),
          ),
          maxFieldBuilder: (context, initialValue) => IntStringFormField(
            controller: _controller.maxValueController,
            properties: TextFormFieldProperties(
              validator: (value) {
                if (value == null) {
                  return 'Max Required';
                }
                return null;
              },
              onSaved: (value) => log("Max Saved: $value"),
              onChanged: (value) => log("Max Changed: $value"),
            ),
          ),
        ),
      children: [
        ControllerTestButtons(
          title: "Range Controller Test Buttons",
          controller: _controller,
          firstDummyValue: IntRange(min: 0, max: 100),
          secondDummyValue: IntRange(min: 100, max: 200),
          valueToString: (value) => "(${value.min} To ${value.max})",
        ),

        ControllerTestButtons(
          title: "Min Controller Test Buttons",
          controller: _controller.minValueController,
          firstDummyValue: 0,
          secondDummyValue: 100,
          valueToString: (value) => "$value",
        ),

        ControllerTestButtons(
          title: "Max Controller Test Buttons",
          controller: _controller.maxValueController,
          firstDummyValue: 100,
          secondDummyValue: 200,
          valueToString: (value) => "$value",
        ),
      ],
    );
  }
}