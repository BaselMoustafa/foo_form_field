import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {

  bool _showField = true;
  final _firstDateTimeController = DateTimeRangeFieldController(
    initialMin: DateTime(2025, 12, 10),
    initialMax: DateTime(2025, 12, 20),
  );
  final _secondDateTimeController = DateTimeRangeFieldController(
    initialMin: DateTime(2025, 12, 10),
    initialMax: DateTime(2025, 12, 20),
  );

  bool _duplicateFirstDate = true;
  FooFormFieldState<Range<DateTime>>? _controlledFieldState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Screen'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _showField = !_showField;
              });
            },
            icon: Icon(_showField ? Icons.visibility : Icons.visibility_off),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 25,
          children:!_showField ? []:[
            DateTimeRangeFormField(
              controller: _firstDateTimeController,
              properties: FooFormFieldProperties(
                onChanged: (value) {
                  log("First Date Changed Called: $value");
                },
              ),
              minFieldDecorationBuilder: (fieldState) => InputDecoration(
                label: Text('First From Date'),
              ),
              maxFieldDecorationBuilder: (fieldState) => InputDecoration(
                label: Text('First To Date'),
              ),
              builder: (context, minField, maxField, fieldState) {
                return Column(
                  spacing: 10,
                  children: [
                    minField,
                    maxField,
                  ],
                );
              },
            ),

            DateTimeRangeFormField(
              stateProvider: (fieldState) {
                log("State Provider Called: ${fieldState.isValid}");
                _controlledFieldState = fieldState;
              },
              controller:_duplicateFirstDate ? _firstDateTimeController : _secondDateTimeController,
              properties: FooFormFieldProperties(
                validator: (Range<DateTime>? value) {
                  log("Duplicated Date Validator Called: $value");
                  if (value == null || (value.min == null && value.max == null)) {
                    return 'This field is required';
                  }
                  log("Duplicated Date Validator Returned: null");
                  return null;
                },
                onChanged: (value) {
                  log("Duplicated Date Changed Called: $value");
                },
              ),
              minFieldDecorationBuilder: (fieldState) => InputDecoration(
                label: Text('Duplicated From Date'),
              ),
              maxFieldDecorationBuilder: (fieldState) => InputDecoration(
                label: Text('Duplicated To Date'),
              ),
              builder: (context, minField, maxField, fieldState) {
                return Column(
                  spacing: 10,
                  children: [
                    minField,
                    maxField,
                    ErrorTextWidget(errorText: fieldState.errorText),
                  ],
                );
              },
            ),

            DateTimeRangeFormField(
              minFieldDecorationBuilder: (fieldState) => InputDecoration(
                label: Text('Second From Date'),
              ),
              maxFieldDecorationBuilder: (fieldState) => InputDecoration(
                label: Text('Second To Date'),
              ),
              controller: _secondDateTimeController,
              properties: FooFormFieldProperties(
                onChanged: (value) {
                  log("Second Date Changed Called: $value");
                },
              ),
              builder: (context, minField, maxField, fieldState) {
                return Column(
                  spacing: 10,
                  children: [
                    minField,
                    maxField,
                  ],
                );
              },

            ),  

            ElevatedButton(
              onPressed: () {
                _controlledFieldState?.validate();
              },
              child: Text('Validate Duplicated Date'),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  _duplicateFirstDate = !_duplicateFirstDate;
                });
              },
              child: Text('Toggle'),
            ),         
            
            ElevatedButton(
              onPressed: () {
                log("First Date: ${_firstDateTimeController.value.toString()}");
                log("Second Date: ${_secondDateTimeController.value.toString()}");
              },
              child: Text('Show Values'),
            ),
          ],
        ),
      ),
    );
  }
}