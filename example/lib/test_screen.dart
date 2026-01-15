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
  final _firstDateTimeController = DateTimeFieldController();
  final _secondDateTimeController = DateTimeFieldController();

  bool _duplicateFirstDate = true;
  FooFormFieldState<DateTime>? _controlledFieldState;

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
          spacing: 16,
          children:!_showField ? []:[
            DateTimeFormField(
              controller: _firstDateTimeController,
              decoration: InputDecoration(
                label: Text('First Date '),
              ),
            ),

            DateTimeFormField(
              controller:_duplicateFirstDate ? _firstDateTimeController : _secondDateTimeController,
              decoration: InputDecoration(
                label: Text('Duplicated ${_duplicateFirstDate ? 'First' : 'Second'} Date'),
              ),
              properties: FooFormFieldProperties(
                validator: (value) {
                  if (value == null) {
                    return 'This field is required';
                  }
                  return null;
                },
              ),
            ),

            DateTimeFormField(
              controller: _secondDateTimeController,
              decoration: InputDecoration(
                label: Text('Second Date'),
              ),
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