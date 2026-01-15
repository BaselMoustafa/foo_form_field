import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';

class TestScreen2 extends StatefulWidget {
  const TestScreen2({super.key});

  @override
  State<TestScreen2> createState() => _TestScreen2State();
}

class _TestScreen2State extends State<TestScreen2> {

  bool _showField = true;
  final _firstDateTimeController = IntTextEditingController(
    initialValue: 10,
  );
  final _secondDateTimeController = IntTextEditingController(
    initialValue: 20,
  );

  bool _duplicateFirstDate = true;
  FooFormFieldState<String>? _controlledFieldState;

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
            IntTextFormField(
              controller: _firstDateTimeController,
              properties: TextFormFieldProperties(
                onChanged: (value) {
                  log("First Date Changed Called: $value");
                },
              ),
              formatter: IntTextFormatter(
                allowNegative: true,
              ),
            ),

            IntTextFormField(
              stateProvider: (fieldState) {
                log("State Provider Called: ${fieldState.isValid}");
                _controlledFieldState = fieldState;
              },
              controller:_duplicateFirstDate ? _firstDateTimeController : _secondDateTimeController,
              properties: TextFormFieldProperties(
                validator: (int? value) {
                  log("Duplicated Date Validator Called: $value");
                  if (value == null) {
                    return 'This field is required';
                  }
                  log("Duplicated Date Validator Returned: null");
                  return null;
                },
                onChanged: (value) {
                  log("Duplicated Date Changed Called: $value");
                },
                decoration: InputDecoration(
                  label: Text('Duplicated ${_duplicateFirstDate ? 'First' : 'Second'} Date'),
                ),
              ),

            ),

            IntTextFormField(
              controller: _secondDateTimeController,
              properties: TextFormFieldProperties(
                onChanged: (value) {
                  log("Second Date Changed Called: $value");
                },
              ),
            ),

            ElevatedButton(
              onPressed: () {
                _firstDateTimeController.value = math.Random().nextInt(100);
              },
              child: Text('Change First To Random Value'),
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