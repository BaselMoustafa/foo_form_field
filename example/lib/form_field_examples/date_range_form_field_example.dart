import 'dart:developer';

import 'package:flutter/material.dart' hide DateTimeRange;
import 'package:foo_form_field/foo_form_field.dart';

import '../widgets/controller_test_buttons.dart';
import '../widgets/example_screen.dart';

class DateRangeFormFieldExample extends StatefulWidget {
  const DateRangeFormFieldExample({super.key});

  @override
  State<DateRangeFormFieldExample> createState() => _DateRangeFormFieldExampleState();
}

class _DateRangeFormFieldExampleState extends State<DateRangeFormFieldExample> {

  final _controller = DateTimeRangeFieldController(
    minController: DateTimeFieldController(
      initialValue: DateTime(2025, 12 , 10),
    ),
    maxController: DateTimeFieldController(
      initialValue: DateTime(2025, 12, 20),
    ),
  );
  
  @override
  Widget build(BuildContext context) {
    return ExampleScreen(
      title: "Date Range Form Field",
      fieldBuilder: () => DateTimeRangeFormField(
        controller: _controller,
        minDate: DateTime(2025, 12, 5),
        maxDate: DateTime(2025, 12, 25),
        builder: (context, minField, maxField, fieldState) {
          return Column(
            spacing: 10,
            children: [
              minField,
              maxField,
            ],
          );
        },
        properties: FooFormFieldProperties(
          onChanged: (value) => log("Range Changed To: $value"),
          onSaved: (value) => log("Range Saved: $value"),
          validator: (value) {
            if (value == null || value.min == null || value.max == null) {
              return 'This field is required';
            } 
            return null;
          },
      
        ),
      ),
      children: [
        ControllerTestButtons(
          title: "Range Controller Test Buttons",
          controller: _controller,
          firstDummyValue: Range(min: DateTime(2025, 3, 11), max: DateTime(2025, 11, 12)),
          secondDummyValue: Range(min: DateTime(2025, 5, 2), max: DateTime(2025, 7, 4)),
          valueToString: (value) => "(${value.min?.year}/${value.min?.month}/${value.min?.day} To ${value.max?.year}/${value.max?.month}/${value.max?.day})",
        ),

        ControllerTestButtons(
          title: "Min Controller Test Buttons",
          controller: _controller.minController,
          firstDummyValue: DateTime(2025, 3, 11),
          secondDummyValue: DateTime(2025, 11, 12),
          valueToString: (value) => "${value.year}/${value.month}/${value.day}",
        ),

        ControllerTestButtons(
          title: "Max Controller Test Buttons",
          controller: _controller.maxController,
          firstDummyValue: DateTime(2025, 3, 11),
          secondDummyValue: DateTime(2025, 11, 12),
          valueToString: (value) => "${value.year}/${value.month}/${value.day}",
        ),
      ],
    );
  }
}