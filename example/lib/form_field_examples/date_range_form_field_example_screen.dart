import 'dart:developer';

import 'package:flutter/material.dart' hide DateTimeRange;
import 'package:foo_form_field/foo_form_field.dart';

import '../widgets/controller_test_buttons.dart';
import '../widgets/example_screen.dart';

class DateRangeFormFieldExampleScreen extends StatefulWidget {
  const DateRangeFormFieldExampleScreen({super.key});

  @override
  State<DateRangeFormFieldExampleScreen> createState() => _DateRangeFormFieldExampleScreenState();
}

class _DateRangeFormFieldExampleScreenState extends State<DateRangeFormFieldExampleScreen> {

  final _controller = DateTimeRangeFieldController(
    initialValue: DateTimeRange(min: DateTime(2025, 3, 11), max: DateTime(2025, 11, 12)),
    enabled: false,
  );
  
  @override
  Widget build(BuildContext context) {
    return ExampleScreen(
      title: "Date Range Form Field",
      fieldBuilder: () => DateTimeRangeFormField(
        controller: _controller,
        onChanged: (value) => log("Range Changed To: $value"),
        onSaved: (value) => log("Range Saved: $value"),
        validator: (value) {
          if (value == null || value.min == null || value.max == null) {
            return 'This field is required';
          } 
          return null;
        },
        minFieldBuilder: (context, initialValue) => DateTimeFormField(
          controller: _controller.minValueController,
          onChanged: (value) => log("Min Date Changed To: $value"),
          onSaved: (value) => log("Min Date Saved: $value"),
          validator: (value) {
            if (value == null) {
              return 'Min Required';
            }
            return null;
          },
        ),
        maxFieldBuilder: (context, initialValue) => DateTimeFormField(
          controller: _controller.maxValueController,
          onChanged: (value) => log("Max Date Changed To: $value"),
          onSaved: (value) => log("Max Date Saved: $value"),
          validator: (value) {
            if (value == null) {
              return 'Max Required';
            }
            return null;
          },
        ),
      ),
      children: [
        ControllerTestButtons(
          title: "Range Controller Test Buttons",
          controller: _controller,
          firstDummyValue: DateTimeRange(min: DateTime(2025, 3, 11), max: DateTime(2025, 11, 12)),
          secondDummyValue: DateTimeRange(min: DateTime(2025, 5, 2), max: DateTime(2025, 7, 4)),
          valueToString: (value) => "(${value.min?.year}/${value.min?.month}/${value.min?.day} To ${value.max?.year}/${value.max?.month}/${value.max?.day})",
        ),

        ControllerTestButtons(
          title: "Min Controller Test Buttons",
          controller: _controller.minValueController,
          firstDummyValue: DateTime(2025, 3, 11),
          secondDummyValue: DateTime(2025, 11, 12),
          valueToString: (value) => "${value.year}/${value.month}/${value.day}",
        ),

        ControllerTestButtons(
          title: "Max Controller Test Buttons",
          controller: _controller.maxValueController,
          firstDummyValue: DateTime(2025, 3, 11),
          secondDummyValue: DateTime(2025, 11, 12),
          valueToString: (value) => "${value.year}/${value.month}/${value.day}",
        ),
      ],
    );
  }
}