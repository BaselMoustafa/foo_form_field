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
  final _dateTimeController = DateTimeFieldController();
  final _intTextEditingController = IntTextEditingController();
  final _textEditingController = TextEditingController();
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
              controller: _dateTimeController,
              decoration: InputDecoration(
                label: Text('Date'),
              ),
            ),
            IntTextFormField(
              controller: _intTextEditingController,
            ),
            TextFormField(
              controller: _textEditingController,
            ),
            ElevatedButton(
              onPressed: () {
                log(_dateTimeController.value.toString());
                log(_intTextEditingController.value.toString());
              },
              child: Text('Show Values'),
            ),
          ],
        ),
      ),
    );
  }
}