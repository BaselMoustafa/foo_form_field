import 'dart:developer';

import 'package:flutter/material.dart' hide DateTimeRange;
import 'package:foo_form_field/foo_form_field.dart';

import '../widgets/controller_test_buttons.dart';
import '../widgets/example_screen.dart';

class DateOnlyRangeFormFieldExample extends StatefulWidget {
  const DateOnlyRangeFormFieldExample({super.key});

  @override
  State<DateOnlyRangeFormFieldExample> createState() => _DateOnlyRangeFormFieldExampleState();
}

class _DateOnlyRangeFormFieldExampleState extends State<DateOnlyRangeFormFieldExample> {

  final _controller = DateOnlyRangeFieldController(
    minController: DateOnlyFieldController(
      initialValue: DateOnly(year: 2025, month: 12, day: 10),
      enabled: false,
    ),
    maxController: DateOnlyFieldController(
      initialValue: DateOnly(year: 2025, month: 12, day: 20),
    ),
  );
  
  @override
  Widget build(BuildContext context) {
    return ExampleScreen(
      title: "Date Only Range Form Field",
      fieldBuilder: () => DateOnlyRangeFormField(
        controller: _controller,
        minDate: DateOnly(year: 2025, month: 12, day: 5),
        maxDate: DateOnly(year: 2025, month: 12, day: 25),
        builder: (context, controlledFieldState, minField, maxField) {
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
          firstDummyValue: Range(min: DateOnly(year: 2025, month: 3, day: 11), max: DateOnly(year: 2025, month: 11, day: 12)),
          secondDummyValue: Range(min: DateOnly(year: 2025, month: 5, day: 2), max: DateOnly(year: 2025, month: 7, day: 4)),
          valueToString: (value) => "(${value.min?.year}/${value.min?.month}/${value.min?.day} To ${value.max?.year}/${value.max?.month}/${value.max?.day})",
        ),

        ControllerTestButtons(
          title: "Min Controller Test Buttons",
          controller: _controller.minController,
          firstDummyValue: DateOnly(year: 2025, month: 3, day: 11),
          secondDummyValue: DateOnly(year: 2025, month: 11, day: 12),
          valueToString: (value) => "${value.year}/${value.month}/${value.day}",
        ),

        ControllerTestButtons(
          title: "Max Controller Test Buttons",
          controller: _controller.maxController,
          firstDummyValue: DateOnly(year: 2025, month: 3, day: 11),
          secondDummyValue: DateOnly(year: 2025, month: 11, day: 12),
          valueToString: (value) => "${value.year}/${value.month}/${value.day}",
        ),
      ],
    );
  }
}

